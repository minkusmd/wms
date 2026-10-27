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

app = typer.Typer(add_completion=False, help=f"PriceImport {__version__} (etapa {STAGE}: dry-run, fara aplicare)")


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
        text = build_message(title, [outcome])
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


def main() -> None:
    app()


if __name__ == "__main__":
    main()
