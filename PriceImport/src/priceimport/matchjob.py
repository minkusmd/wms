"""Jobul de potrivire (zilnic, la cerere din CLI / bot) + acceptarea / respingerea propunerilor."""

from __future__ import annotations

from dataclasses import dataclass

from . import repo
from .config import Settings
from .db import open_db
from .log import get_logger
from .matching import Proposal, get_index
from .models import SupplierItem

log = get_logger(__name__)


@dataclass
class MatchSummary:
    supplier_id: int
    run_id: int | None
    n_new: int = 0
    n_with_proposals: int = 0
    n_saved: int = 0            # propuneri noi in TPI_MATCH_CANDIDATE


def _items_for_run(db, run: dict) -> list[SupplierItem]:
    rows = repo.new_codes_of_run(db, run["RUNID"])
    by_code = {r["SUPPLIER_GOODS_CODE"]: r for r in rows}
    if run["PLID"]:
        # din pricelist vin si brandul / modelul (brandul diferit scade scorul)
        items = [i for i in repo.load_pricelist_items(db, run["PLID"]) if i.code in by_code]
        if items:
            return items
    return [SupplierItem(code=r["SUPPLIER_GOODS_CODE"], name=r["SUPPLIER_GOODS_NAME"] or "",
                         category=r["SUPPLIER_CATEGORY"]) for r in rows]


def run_matching(settings: Settings, supplier_ids: list[int] | None = None, dry: bool = False) -> list[MatchSummary]:
    summaries = []
    with open_db(settings) as db:
        if not repo.has_table(db, "TPI_MATCH_CANDIDATE"):
            raise RuntimeError("lipseste TPI_MATCH_CANDIDATE (DB Model/price_import_stage4.sql)")
        suppliers = supplier_ids or [s.supplier_id for s in repo.load_suppliers(db)]
        index = get_index(db)
        db.commit()
        for supplier_id in suppliers:
            run = repo.latest_analyzed_run(db, supplier_id)
            summary = MatchSummary(supplier_id, run["RUNID"] if run else None)
            summaries.append(summary)
            if run is None:
                continue
            items = _items_for_run(db, run)
            summary.n_new = len(items)
            proposals = index.match_items(supplier_id, items)
            decisions = repo.candidate_decisions(db, supplier_id)
            names = {i.code: i.name for i in items}
            accepted_codes = {code for (code, _), st in decisions.items() if st == "ACCEPTED"}
            for code, props in proposals.items():
                summary.n_with_proposals += 1
                if dry or code in accepted_codes:
                    continue
                for p in props:
                    summary.n_saved += repo.save_candidate(db, run["RUNID"], supplier_id, code, names.get(code),
                                                           p.goodsid, p.method, p.score, p.detail,
                                                           decisions.get((code, p.goodsid)))
            if dry:
                db.rollback()
            else:
                db.commit()
            log.info("matching", supplier=supplier_id, run=run["RUNID"], new=summary.n_new,
                     proposals=summary.n_with_proposals, saved=summary.n_saved)
    return summaries


def accept_candidate(settings: Settings, cand_id: int, decided_by: str) -> str:
    """Leaga codul de produs (SP_PI_LINK_GOODS); produsul intra in pret la urmatoarea rulare."""
    with open_db(settings) as db:
        cand = repo.get_candidate(db, cand_id)
        if cand is None:
            return "NOT_FOUND"
        if cand["STATUS"].strip() != "PROPOSED":
            return f"ALREADY_{cand['STATUS'].strip()}"
        result = repo.link_goods(db, cand["SUPPLIERID"], cand["SUPPLIER_GOODS_CODE"], cand["GOODSID"],
                                 cand["SUPPLIER_GOODS_NAME"], settings.wms_user_id)
        if result in ("LINKED", "ALREADY"):
            repo.decide_candidate(db, cand_id, "ACCEPTED" if result == "LINKED" else "SUPERSEDED", decided_by)
            repo.supersede_other_candidates(db, cand["SUPPLIERID"], cand["SUPPLIER_GOODS_CODE"], cand_id)
        db.commit()
    return result


def reject_candidate(settings: Settings, cand_id: int, decided_by: str) -> str:
    with open_db(settings) as db:
        cand = repo.get_candidate(db, cand_id)
        if cand is None:
            return "NOT_FOUND"
        if cand["STATUS"].strip() != "PROPOSED":
            return f"ALREADY_{cand['STATUS'].strip()}"
        repo.decide_candidate(db, cand_id, "REJECTED", decided_by)
        db.commit()
    return "REJECTED"


def format_proposal(p: Proposal) -> str:
    return f"{p.method} {p.score:.2f} {p.detail}"
