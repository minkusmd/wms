"""Linia de comanda `pi` (python -m priceimport ...)."""

from __future__ import annotations

from datetime import datetime
from typing import Optional

import typer

from . import STAGE, __version__, repo
from .config import get_settings
from .coordinator import run_supplier
from .db import open_db
from .log import setup_logging
from .windows import run_window, send_report

app = typer.Typer(add_completion=False, help=f"PriceImport {__version__} (etapa {STAGE}: aplicare prin documente 1414, oprita implicit)")


def _settings(log_to_file: bool = True):
    settings = get_settings()
    setup_logging(settings.data_dir / "logs" if log_to_file else None)
    return settings


@app.command()
def check() -> None:
    """Conexiunea la Firebird, tabelele TPI_* si furnizorii configurati."""
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        typer.echo(f"Conectat: {settings.dsn()} ca {settings.fb_user}")
        missing = [t for t in ("TPI_SUPPLIER", "TPI_RUN", "TPI_RUN_ERROR", "TPI_ITEM_CHANGE", "TPI_HEARTBEAT")
                   if not db.scalar("SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = ?", (t,))]
        if missing:
            typer.echo(f"LIPSESC tabelele: {', '.join(missing)} - ruleaza DB Model/price_import_stage1.sql")
            raise typer.Exit(1)
        for s in repo.load_suppliers(db, only_active=False):
            typer.echo(f"  {s.supplier_id:>7} {s.name[:30]:<30} {s.adapter_code:<14} ferestre={s.window_mask} "
                       f"prag +{s.max_up_pct:g}/-{s.max_down_pct:g}% activ={int(s.active)}")
        db.commit()


@app.command()
def run(supplier_id: int, plid: Optional[int] = typer.Option(None, help="external_plid: un PLID anume"),
        notify: bool = typer.Option(False, help="trimite raportul in Telegram")) -> None:
    """O rulare manuala (dry-run) pentru un furnizor."""
    settings = _settings()
    with open_db(settings) as db:
        supplier = repo.load_supplier(db, supplier_id)
        db.commit()
    if supplier is None:
        typer.echo(f"Furnizorul {supplier_id} nu e in TPI_SUPPLIER")
        raise typer.Exit(1)
    outcome = run_supplier(settings, supplier, trigger="MANUAL", plid=plid)
    title = f"Rulare manuală · {supplier.name} · {datetime.now():%d.%m %H:%M}"
    if notify:
        text = send_report(settings, title, [outcome], f"manual_{supplier_id}_{datetime.now():%H%M%S}")
    else:
        from .report import build_message
        text = build_message(title, [outcome], dry_run=not settings.apply_enabled)
    typer.echo(text)
    raise typer.Exit(0 if outcome.status.value not in ("ERROR", "TIMEOUT") else 2)


@app.command()
def preview(supplier_id: int, plid: Optional[int] = typer.Option(None, help="external_plid: un PLID anume"),
            adapter: Optional[str] = typer.Option(None, help="adaptorul, daca TPI_SUPPLIER lipseste"),
            xlsx: bool = typer.Option(False, help="scrie si fisierul .xlsx cu toate schimbarile")) -> None:
    """Analiza unui furnizor FARA nicio scriere in baza (merge si inainte de DDL-ul etapei 1)."""
    from .coordinator import preview_supplier
    from .report import build_message, report_path, write_xlsx
    from .repo import SupplierConfig

    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        has_table = bool(db.scalar("SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = 'TPI_SUPPLIER'"))
        supplier = repo.load_supplier(db, supplier_id) if has_table else None
        name = db.scalar("SELECT NAME FROM TS_CUSTOMER WHERE CUSTOMERID = ?", (supplier_id,))
        db.commit()
    if supplier is None:
        supplier = SupplierConfig(supplier_id=supplier_id, name=(name or str(supplier_id)).strip(),
                                  adapter_code=adapter or "external_plid", source_kind="A", window_mask=3,
                                  priority=50, est_duration_sec=None, max_rps=2.0, price_category_id=-1,
                                  max_up_pct=20.0, max_down_pct=20.0, noise_pct=0.0, min_volume_ratio=0.7,
                                  gone_after_runs=2, auto_apply=False, active=True, firma_id=None)
    elif adapter:
        supplier.adapter_code = adapter
    outcome = preview_supplier(settings, supplier, plid=plid)
    typer.echo(build_message(f"Previzualizare · {supplier.name}", [outcome]))
    typer.echo(f"\nbaza: {outcome.baseline}; {outcome.note or ''}")
    if xlsx:
        path = write_xlsx(report_path(settings.data_dir, f"preview_{supplier_id}_{plid or 'ultim'}"), [outcome])
        typer.echo(f"xlsx: {path}")


@app.command()
def window(index: int = typer.Argument(..., help="0 = prima fereastra (09:00), 1 = a doua (15:00)"),
           only: Optional[str] = typer.Option(None, help="doar acesti furnizori, ex. 198,14805"),
           notify: bool = typer.Option(True, help="trimite raportul in Telegram")) -> None:
    """Ruleaza acum o fereastra (cu termenele calculate fata de ora ei de start)."""
    settings = _settings()
    selected = {int(x) for x in only.split(",")} if only else None
    outcomes = run_window(settings, index, notify=notify, only=selected)
    for o in outcomes:
        typer.echo(f"{o.supplier.supplier_id:>7} {o.status.value:<10} run={o.run_id} {o.note or ''}")


@app.command()
def serve() -> None:
    """Procesul permanent: ferestrele 09/15 + heartbeat."""
    from .service import serve as serve_forever
    serve_forever(_settings())


@app.command()
def health(max_age_sec: int = 120) -> None:
    """Pentru HEALTHCHECK-ul Docker: baza raspunde si heartbeat-ul pi-worker e proaspat."""
    settings = _settings(log_to_file=False)
    try:
        with open_db(settings) as db:
            age = db.scalar("SELECT DATEDIFF(SECOND FROM HEARTBEAT_AT TO CURRENT_TIMESTAMP) FROM TPI_HEARTBEAT "
                            "WHERE INSTANCE = 'pi-worker'")
            db.commit()
    except Exception as exc:               # noqa: BLE001
        typer.echo(f"DB: {exc}")
        raise typer.Exit(1)
    if age is None or age > max_age_sec:
        typer.echo(f"heartbeat vechi: {age}")
        raise typer.Exit(1)
    typer.echo(f"ok ({age} s)")


@app.command()
def status(limit: int = 20) -> None:
    """Ultimele rulari (VW_TPI_RUN)."""
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        for r in repo.recent_runs(db, limit):
            typer.echo(f"{r['RUNID']:>6} {str(r['STARTED_AT'])[:16]} {r['SUPPLIERID']:>7} "
                       f"{(r['SUPPLIER_NAME'] or '').strip()[:22]:<22} {r['STATUS'].strip():<10} "
                       f"{r['DURATION_SEC'] or 0:>5}s PLID={r['PLID'] or '-'} noi={r['N_NEW'] or 0} "
                       f"↑{r['N_PRICE_UP'] or 0} ↓{r['N_PRICE_DOWN'] or 0} carantina={r['N_QUARANTINE'] or 0}")
        db.commit()


@app.command("compare-wms")
def compare_wms(plid: int) -> None:
    """Echivalenta cu cele 4 reevaluari WMS pe un PLID (criteriul de acceptanta al etapei 1)."""
    from .wmscheck import compare_plid
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        info, comparisons = compare_plid(db, plid)
        db.commit()
    done = repo.pricelist_done(info)
    typer.echo(f"PLID {plid}, furnizor {info['SUPPLIERID']}, {info['DATA']}, "
               f"{'PRELUCRAT deja (comparatia e aproape goala)' if done else 'neprelucrat'}")
    all_equal = True
    for c in comparisons:
        all_equal &= c.equal
        typer.echo(f"  {c.kind:<30} WMS {len(c.wms):>5}  Python {len(c.python):>5}  "
                   f"{'IDENTIC' if c.equal else f'doar WMS {len(c.only_wms)}, doar Python {len(c.only_python)}'}")
        for code, goodsid in sorted(c.only_wms)[:5]:
            typer.echo(f"      doar WMS:    {code} / {goodsid}")
        for code, goodsid in sorted(c.only_python)[:5]:
            typer.echo(f"      doar Python: {code} / {goodsid}")
    raise typer.Exit(0 if all_equal else 3)


# --- etapa 2 -------------------------------------------------------------------------------

def _print_apply(result) -> None:
    from .apply import KIND_NAMES
    mode = "TEST (ROLLBACK)" if result.test_only else "aplicat"
    typer.echo(f"{result.operation} lot {result.batch_id}: {mode}; documente {result.docids or '-'}; "
               f"randuri {dict((KIND_NAMES[k], v) for k, v in result.rows_by_kind.items())}; "
               f"aplicate {result.n_applied}, respinse {len(result.rejected)}, sarite {len(result.skipped)}")
    for (code, goodsid), message in list(result.rejected.items())[:15]:
        typer.echo(f"   respins {code} / {goodsid}: {message[:160]}")
    for (code, goodsid), reason in list(result.skipped.items())[:10]:
        typer.echo(f"   sarit   {code} / {goodsid}: {reason}")
    if result.error:
        typer.echo(f"   EROARE: {result.error}")


@app.command("apply")
def apply_cmd(run_id: int, test: bool = typer.Option(False, help="documentele se fac si se anuleaza (ROLLBACK)")) -> None:
    """Aplica schimbarile APPLY inca neaplicate ale unei rulari (ex. dupa aprobari din carantina)."""
    from .apply import ApplyError, apply_run
    settings = _settings()
    if not test and not settings.apply_enabled:
        typer.echo("Aplicarea e oprita (PI_APPLY_ENABLED=false). Foloseste --test sau porneste comutatorul.")
        raise typer.Exit(1)
    try:
        _print_apply(apply_run(settings, run_id, test_only=test))
    except ApplyError as exc:
        typer.echo(f"Nu se aplica: {exc}")
        raise typer.Exit(1)


@app.command("apply-test")
def apply_test(supplier_id: int, plid: Optional[int] = typer.Option(None, help="un PLID anume (implica external_plid)"),
               adapter: Optional[str] = typer.Option(None, help="alt adaptor doar pentru aceasta rulare")) -> None:
    """O rulare noua (dry-run) + aplicarea ei de TEST: documente 1414 reale, CLOSE_REEVALUARE, apoi ROLLBACK."""
    from .apply import ApplyError, apply_run
    settings = _settings()
    with open_db(settings) as db:
        supplier = repo.load_supplier(db, supplier_id)
        db.commit()
    if supplier is None:
        typer.echo(f"Furnizorul {supplier_id} nu e in TPI_SUPPLIER")
        raise typer.Exit(1)
    if adapter or plid is not None:
        # doar in memorie: un PLID existent se citeste cu external_plid, oricare ar fi adaptorul furnizorului
        supplier.adapter_code = adapter or "external_plid"
    outcome = run_supplier(settings, supplier, trigger="MANUAL", plid=plid)
    typer.echo(f"rularea {outcome.run_id}: {outcome.status.value}, baza {outcome.baseline}; {outcome.note or ''}")
    if outcome.status.value != "DRY_RUN" or outcome.baseline != "gf":
        typer.echo("Testul de aplicare cere o rulare DRY_RUN pe baza TS_GOODS_FOREIGN (PLID neprelucrat).")
        raise typer.Exit(1)
    try:
        _print_apply(apply_run(settings, outcome.run_id, test_only=True, items=outcome.items))
    except ApplyError as exc:
        typer.echo(f"Nu se aplica: {exc}")
        raise typer.Exit(1)


@app.command("rollback")
def rollback_cmd(run_id: int, test: bool = typer.Option(False, help="documentul se face si se anuleaza")) -> None:
    """Anuleaza o rulare aplicata: document 1414 compensatoriu cu valorile de dinainte."""
    from .apply import ApplyError, rollback_run
    settings = _settings()
    try:
        _print_apply(rollback_run(settings, run_id, test_only=test))
    except ApplyError as exc:
        typer.echo(f"Nu se anuleaza: {exc}")
        raise typer.Exit(1)


@app.command()
def quarantine(supplier_id: Optional[int] = None, status_: str = typer.Option("PENDING", "--status")) -> None:
    """Randurile din carantina (implicit cele care asteapta o decizie)."""
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        rows = repo.list_quarantine(db, supplier_id, status_.upper())
        db.commit()
    for r in rows:
        delta = f"{float(r['DELTA_PCT']):+.1f}%" if r["DELTA_PCT"] is not None else ""
        typer.echo(f"{r['QID']:>6} run {r['RUNID']:>5} {r['SUPPLIERID']:>7} {r['SUPPLIER_GOODS_CODE'][:20]:<20} "
                   f"{(r['REASON_CODE'] or '').strip():<18} {r['OLD_PRICE']} -> {r['NEW_PRICE']} {delta} "
                   f"{(r['SUPPLIER_GOODS_NAME'] or '')[:40]}")
    typer.echo(f"{len(rows)} randuri")


def _decide(qids: list[int], status_value: str, by: str, note: Optional[str]) -> set[int]:
    settings = _settings(log_to_file=False)
    runs: set[int] = set()
    with open_db(settings) as db:
        for qid in qids:
            row = repo.decide_quarantine(db, qid, status_value, by, note)
            if row is None:
                typer.echo(f"{qid}: nu exista")
            elif row["STATUS"].strip() != "PENDING":
                typer.echo(f"{qid}: e deja {row['STATUS'].strip()}")
            else:
                runs.add(row["RUNID"])
                typer.echo(f"{qid}: {status_value} ({row['SUPPLIER_GOODS_CODE']})")
        db.commit()
    return runs


@app.command()
def approve(qids: list[int], by: str = typer.Option(..., help="cine aproba"), note: Optional[str] = None,
            apply_now: bool = typer.Option(False, "--apply", help="aplica imediat produsele aprobate")) -> None:
    """Aproba randuri din carantina; aceeasi valoare trece si la rularile urmatoare (30 de zile)."""
    runs = _decide(qids, "APPROVED", by, note)
    if apply_now:
        from .apply import ApplyError, apply_run
        settings = _settings()
        if not settings.apply_enabled:
            typer.echo("Aplicarea e oprita (PI_APPLY_ENABLED=false): aprobarea ramine pentru rularea urmatoare.")
            return
        for run_id in sorted(runs):
            try:
                _print_apply(apply_run(settings, run_id))
            except ApplyError as exc:
                typer.echo(f"rularea {run_id}: {exc} (aprobarea ramine pentru rularea urmatoare)")


@app.command()
def reject(qids: list[int], by: str = typer.Option(..., help="cine respinge"), note: Optional[str] = None) -> None:
    """Respinge randuri din carantina (pretul vechi ramine)."""
    _decide(qids, "REJECTED", by, note)


@app.command()
def mute(supplier_id: int, hours: int = 6) -> None:
    """Opreste alertele repetate ale unui furnizor pentru cateva ore."""
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        n = repo.mute_alerts(db, f"RUN|{supplier_id}|", hours)
        db.commit()
    typer.echo(f"{n} alerte oprite {hours} h")


@app.command()
def watchdog() -> None:
    """Ruleaza o data SP_PI_WATCHDOG (in productie il programeaza SWNService)."""
    settings = _settings(log_to_file=False)
    with open_db(settings) as db:
        n = db.scalar("EXECUTE PROCEDURE SP_PI_WATCHDOG")
        db.commit()
    typer.echo(f"alerte trimise: {n}")


def main() -> None:
    app()


if __name__ == "__main__":
    main()
