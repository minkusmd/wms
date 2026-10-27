"""Etapa 2: aplicarea unei rulari prin documente de reevaluare 1414 (si anularea ei).

Randurile se construiesc aici, cu regulile din Parsers/PriceListReevaluationUnit.pas (BuildRow) si cu
aceleasi 4 tipuri ca reevaluarile WMS; documentele le face SP_PI_APPLY_KIND (SQL SECURITY DEFINER):
SP_CREATE_NEW_DOCUMENT + TDB_GOODS_PRICE + ADJUST_RRP_REEVALUATION + CLOSE_REEVALUARE, cu produsul
respins scos si inchiderea reluata. Fiecare tip = o tranzactie, ca in WMS; test_only = ROLLBACK la fiecare.
Inchiderile trec pe rind (CLOSE_REEVALUARE atinge produse comune mai multor furnizori).
"""

from __future__ import annotations

import threading
from dataclasses import dataclass, field
from typing import Any

from firebird.driver import DatabaseError

from . import repo
from .config import Settings
from .db import Db, open_db
from .log import get_logger
from .models import PRICE_COST, PRICE_LIST, PRICE_RRP, ChangeType, GfRow, SupplierItem

log = get_logger(__name__)

KIND_NEW, KIND_OLD, KIND_UP, KIND_DOWN = 0, 1, 2, 3
KIND_NAMES = {KIND_NEW: "produse noi", KIND_OLD: "produse vechi", KIND_UP: "preturi marite",
              KIND_DOWN: "preturi scazute"}
MDL, USD = 498, 840

APPLY_LOCK = threading.Lock()


class ApplyError(Exception):
    pass


@dataclass
class ApplyRow:
    kind: int
    goodsid: int
    code: str
    price0: float
    cur0: int
    price3: float
    cur3: int
    price7: float
    cur7: int
    flg_epp: bool
    note: str | None = None


@dataclass
class ApplyResult:
    batch_id: int | None = None
    operation: str = "APPLY"
    test_only: bool = False
    docids: list[int] = field(default_factory=list)
    rows_by_kind: dict[int, int] = field(default_factory=dict)
    applied: dict[tuple[str, int], int] = field(default_factory=dict)       # (cod, goodsid) -> DOCID
    rejected: dict[tuple[str, int], str] = field(default_factory=dict)      # (cod, goodsid) -> mesaj
    skipped: dict[tuple[str, int], str] = field(default_factory=dict)       # BuildRow: motiv
    error: str | None = None

    @property
    def n_applied(self) -> int:
        return len(self.applied)


def build_row(kind: int, goodsid: int, code: str, price0: float | None, price3: float | None, cur3: int | None,
              price7: float | None, cur7: int | None, flg_epp: bool) -> tuple[ApplyRow | None, str]:
    """Port 1:1 al BuildRow (Tframe78PriceList.DoCreateReevaluare). (None, motiv) = randul nu intra."""
    p3, p7, p0 = price3 or 0.0, price7 or 0.0, price0 or 0.0
    epp, note = flg_epp, ""
    # furnizorul nu da pret indicativ: singurul reper e RRP-ul -> modul EPP
    if p7 == 0 and p3 > 0:
        epp = True
    # 03.10.2026: produs pe RRP fara RRP in pricelist - iese de pe RRP (FLG_EPP = 0, PRICE3 = 0)
    if epp and p3 == 0:
        epp, note = False, "iese de pe RRP"
    if p7 == 0 and p3 == 0:
        return None, "NO_PRICE"
    if p7 == 0 and epp:
        cur7 = cur3 if cur3 else USD          # valuta 7 nu vine din pricelist: valuta RRP-ului
    elif not cur7:
        return None, "NO_CURRENCY7"
    cur3 = cur3 or MDL
    return ApplyRow(kind, goodsid, code, p0, cur7, p3, cur3, p7, cur7, epp, note or None), ""


def plan_apply(changes: list[dict[str, Any]], items: dict[str, SupplierItem],
               gf_state: dict[str, list[GfRow]]) -> tuple[list[ApplyRow], dict[tuple[str, int], str]]:
    """Randurile documentelor din schimbarile cu DECISION = APPLY inca neaplicate ale unei rulari."""
    types: dict[tuple[str, int], set[str]] = {}
    for c in changes:
        if c["DECISION"].strip() != "APPLY" or c["APPLIED_DOCID"] is not None or c["GOODSID"] is None:
            continue
        types.setdefault((c["SUPPLIER_GOODS_CODE"], c["GOODSID"]), set()).add(c["CHANGE_TYPE"].strip())

    rows: list[ApplyRow] = []
    skipped: dict[tuple[str, int], str] = {}
    for (code, goodsid), kinds in types.items():
        gf = next((r for r in gf_state.get(code, []) if r.goodsid == goodsid), None)
        if gf is None:
            skipped[(code, goodsid)] = "NO_GF_ROW"
            continue
        if ChangeType.GONE.value in kinds:
            kind, source = KIND_OLD, gf
        else:
            item = items.get(code)
            if item is None:
                skipped[(code, goodsid)] = "NO_ITEM"
                continue
            if ChangeType.RETURNED.value in kinds:
                kind = KIND_NEW
            elif ChangeType.PRICE_UP.value in kinds:
                kind = KIND_UP
            elif ChangeType.PRICE_DOWN.value in kinds:
                kind = KIND_DOWN
            else:
                continue
            source = item
        row, reason = build_row(kind, goodsid, code, source.price0, source.price3, source.cur3,
                                source.price7, source.cur7, gf.epp)
        if row is None:
            skipped[(code, goodsid)] = reason
        else:
            rows.append(row)
    return rows, skipped


def plan_rollback(changes: list[dict[str, Any]], gf_state: dict[str, list[GfRow]],
                  later: set[tuple[str, int | None]]) -> tuple[list[ApplyRow], dict[tuple[str, int], str]]:
    """Randurile documentului compensatoriu: valorile de dinainte de rulare, peste starea curenta."""
    by_item: dict[tuple[str, int], list[dict[str, Any]]] = {}
    for c in changes:
        if c["APPLIED_DOCID"] is not None and c["GOODSID"] is not None:
            by_item.setdefault((c["SUPPLIER_GOODS_CODE"], c["GOODSID"]), []).append(c)

    rows: list[ApplyRow] = []
    skipped: dict[tuple[str, int], str] = {}
    for (code, goodsid), item_changes in by_item.items():
        if (code, goodsid) in later:
            skipped[(code, goodsid)] = "CHANGED_LATER"
            continue
        gf = next((r for r in gf_state.get(code, []) if r.goodsid == goodsid), None)
        if gf is None:
            skipped[(code, goodsid)] = "NO_GF_ROW"
            continue
        kinds = {c["CHANGE_TYPE"].strip() for c in item_changes}
        p0, p3, cur3, p7, cur7 = gf.price0, gf.price3, gf.cur3, gf.price7, gf.cur7
        if ChangeType.RETURNED.value in kinds:
            kind = KIND_OLD                    # intrase in pricelist -> iese din nou
        elif ChangeType.GONE.value in kinds:
            kind = KIND_NEW                    # iesise -> revine
        else:
            up = any(c["CHANGE_TYPE"].strip() == ChangeType.PRICE_UP.value for c in item_changes)
            kind = KIND_DOWN if up else KIND_UP
            for c in item_changes:
                old = None if c["OLD_PRICE"] is None else float(c["OLD_PRICE"])
                if c["PRICE_FIELD"] == PRICE_LIST:
                    p7, cur7 = old, c["OLD_CURRENCYID"] or cur7
                elif c["PRICE_FIELD"] == PRICE_COST:
                    p0 = old
                elif c["PRICE_FIELD"] == PRICE_RRP:
                    p3, cur3 = old, c["OLD_CURRENCYID"] or cur3
        row, reason = build_row(kind, goodsid, code, p0, p3, cur3, p7, cur7, gf.epp)
        if row is None:
            skipped[(code, goodsid)] = reason
        else:
            rows.append(row)
    return rows, skipped


def execute_batch(db: Db, run_id: int, operation: str, supplier_id: int, firma_id: int, user_id: int,
                  rrp_discount: float, rows: list[ApplyRow], test_only: bool) -> ApplyResult:
    """Lotul + cite un document pe tip (0..3, ordinea WMS). La o eroare tipurile urmatoare nu mai pornesc."""
    result = ApplyResult(operation=operation, test_only=test_only)
    result.batch_id = repo.insert_apply_batch(db, run_id, operation, supplier_id, firma_id, user_id,
                                              rrp_discount, test_only)
    repo.insert_apply_rows(db, result.batch_id, rows)
    db.commit()
    by_kind: dict[int, list[ApplyRow]] = {}
    for row in rows:
        by_kind.setdefault(row.kind, []).append(row)

    n_rejected = 0
    with APPLY_LOCK:
        for kind in (KIND_NEW, KIND_OLD, KIND_UP, KIND_DOWN):
            kind_rows = by_kind.get(kind)
            if not kind_rows:
                continue
            try:
                docid, n_rows, n_rej = repo.apply_kind(db, result.batch_id, kind)
                rejected = {(r["SUPPLIER_GOODS_CODE"], r["GOODSID"]): (r["REJECT_MSG"] or "").strip()
                            for r in repo.rejected_rows(db, result.batch_id, kind)}
                if test_only:
                    db.rollback()
                else:
                    db.commit()
            except DatabaseError as exc:
                db.rollback()
                result.error = f"{KIND_NAMES[kind]}: {exc}"
                log.error("apply_kind_failed", batch=result.batch_id, kind=kind, error=str(exc))
                break
            result.docids.append(docid)
            result.rows_by_kind[kind] = n_rows
            n_rejected += n_rej
            result.rejected.update(rejected)
            for row in kind_rows:
                key = (row.code, row.goodsid)
                if key not in rejected:
                    result.applied[key] = docid
            log.info("apply_kind", batch=result.batch_id, kind=KIND_NAMES[kind], docid=docid, rows=n_rows,
                     rejected=n_rej, test=test_only)

    status = "TESTED" if test_only and not result.error else (
        "FAILED" if result.error and not result.docids else ("PARTIAL" if result.error or n_rejected else "DONE"))
    repo.finish_apply_batch(db, result.batch_id, status, [] if test_only else result.docids, len(rows), n_rejected,
                            result.error)
    db.commit()
    return result


def _supplier_firma(settings: Settings, supplier: repo.SupplierConfig) -> int:
    return supplier.firma_id or settings.default_firma_id


def apply_run(settings: Settings, run_id: int, *, test_only: bool = False,
              items: list[SupplierItem] | None = None) -> ApplyResult:
    """Aplica schimbarile APPLY neaplicate ale rularii. `items` = pozitiile din memorie (altfel din PLID-ul rularii)."""
    with open_db(settings) as db:
        if not repo.stage2_ready(db):
            raise ApplyError("lipsesc tabelele etapei 2 (DB Model/price_import_stage2.sql)")
        run = repo.load_run(db, run_id)
        if run is None:
            raise ApplyError(f"rularea {run_id} nu exista")
        supplier = repo.load_supplier(db, run["SUPPLIERID"])
        assert supplier is not None
        if (run.get("BASELINE") or "").strip() != "gf":
            raise ApplyError(f"rularea {run_id} nu e comparata cu TS_GOODS_FOREIGN (baza "
                             f"{(run.get('BASELINE') or '-').strip()}): pricelistul a fost deja aplicat")
        plid = run["PLID"]
        first_apply = not (run["N_APPLIED"] or 0)
        if plid is not None:
            info = repo.pricelist_info(db, plid)
            if info and repo.pricelist_done(info) and not repo.plid_applied_by_service(db, plid):
                raise ApplyError(f"PLID {plid} e deja prelucrat in WMS (reevaluarile s-au facut) - nu se aplica a doua oara")
        if not first_apply and repo.newer_runs_exist(db, supplier.supplier_id, run_id):
            raise ApplyError(f"exista rulari mai noi pentru furnizorul {supplier.supplier_id}; aplica-le pe acelea")
        if items is None:
            if plid is None:
                raise ApplyError("rularea nu are PLID si pozitiile nu au fost date")
            items = repo.load_pricelist_items(db, plid)
        changes = repo.load_run_changes(db, run_id)
        gf_state = repo.load_gf_state(db, supplier.supplier_id)
        rrp_discount = repo.load_rrp_discount(db, supplier.supplier_id)
        db.commit()

        rows, skipped = plan_apply(changes, {i.code: i for i in items}, gf_state)
        result = execute_batch(db, run_id, "APPLY", supplier.supplier_id, _supplier_firma(settings, supplier),
                               settings.wms_user_id, rrp_discount, rows, test_only)
        result.skipped = skipped
        if test_only:
            return result

        for (code, goodsid), docid in result.applied.items():
            repo.mark_changes_applied(db, run_id, code, goodsid, docid)
        for (code, goodsid), message in result.rejected.items():
            repo.mark_changes(db, run_id, code, goodsid, "QUARANTINE", "CLOSE_REJECTED")
        for (code, goodsid), reason in skipped.items():
            repo.mark_changes(db, run_id, code, goodsid, "IGNORE", reason[:32])
        if result.rejected:
            repo.create_quarantine(db, run_id, supplier.supplier_id, settings.quarantine_expire_days)
        kinds = {(r.code, r.goodsid): r.kind for r in rows}
        repo.insert_goods_events(db, run_id, ((goodsid, "STOCK" if kinds[(code, goodsid)] in (KIND_NEW, KIND_OLD)
                                                else "PRICE") for (code, goodsid) in result.applied))
        if plid is not None and result.docids:
            repo.set_pricelist_done(db, plid)
        docids = ",".join(filter(None, [(run["REEVAL_DOCIDS"] or "").strip()] + [str(d) for d in result.docids]))
        status = "PARTIAL" if (result.rejected or result.error) else "APPLIED"
        repo.update_run(db, run_id, status=status, n_applied=(run["N_APPLIED"] or 0) + result.n_applied,
                        reeval_docids=docids[:256] or None,
                        error_text=result.error or (f"{len(result.rejected)} respinse la CLOSE_REEVALUARE"
                                                    if result.rejected else run["ERROR_TEXT"]))
        db.commit()
        return result


def rollback_run(settings: Settings, run_id: int, *, test_only: bool = False) -> ApplyResult:
    """Document compensatoriu cu valorile de dinainte (fara ADJUST_RRP: PRICE3 vechi e deja ajustat)."""
    with open_db(settings) as db:
        run = repo.load_run(db, run_id)
        if run is None or not (run["N_APPLIED"] or 0):
            raise ApplyError(f"rularea {run_id} nu are nimic aplicat")
        if run["STATUS"].strip() == "ROLLED_BACK":
            raise ApplyError(f"rularea {run_id} e deja anulata")
        supplier = repo.load_supplier(db, run["SUPPLIERID"])
        assert supplier is not None
        changes = repo.load_run_changes(db, run_id)
        gf_state = repo.load_gf_state(db, supplier.supplier_id)
        later = repo.later_applied_codes(db, supplier.supplier_id, run_id)
        db.commit()
        rows, skipped = plan_rollback(changes, gf_state, later)
        result = execute_batch(db, run_id, "ROLLBACK", supplier.supplier_id, _supplier_firma(settings, supplier),
                               settings.wms_user_id, 0.0, rows, test_only)
        result.skipped = skipped
        if not test_only and result.docids:
            repo.insert_goods_events(db, run_id, ((goodsid, "PRICE") for (_, goodsid) in result.applied))
            repo.update_run(db, run_id, status="ROLLED_BACK",
                            error_text=f"anulata prin doc {','.join(map(str, result.docids))}; "
                                       f"sarite {len(skipped)}, respinse {len(result.rejected)}")
            db.commit()
        return result
