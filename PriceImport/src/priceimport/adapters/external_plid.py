"""Adaptorul `external_plid`: pricelistul l-a creat deja alt proces (WMSParsers, frame78, ultra2_sync.py).

Serviciul nu descarca nimic: citeste cel mai nou TS_PRICELISTS al furnizorului, iar daca a fost deja
analizat intr-o rulare anterioara, rularea e UNCHANGED. Daca pricelistul e mai vechi decit
PI_EXTERNAL_MAX_AGE_HOURS, rularea primeste un avertisment (procesul extern nu mai ruleaza).
"""

from __future__ import annotations

from .. import repo
from ..models import FetchResult, RowError, Severity
from .base import AdapterError, RunContext, SupplierAdapter, sha256_json


class ExternalPlidAdapter(SupplierAdapter):
    code = "external_plid"

    def fetch(self, ctx: RunContext) -> FetchResult:
        supplier_id = ctx.supplier.supplier_id
        if ctx.plid is not None:
            info = repo.pricelist_info(ctx.db, ctx.plid)
            if info is None or info["SUPPLIERID"] != supplier_id:
                raise AdapterError("CONFIG", f"PLID {ctx.plid} nu exista sau nu e al furnizorului {supplier_id}")
        else:
            info = repo.latest_pricelist(ctx.db, supplier_id)
            if info is None:
                raise AdapterError("NO_PRICELIST", "furnizorul nu are niciun pricelist in TS_PRICELISTS")

        plid = info["PLID"]
        warnings: list[RowError] = []
        age_hours = (info["AGE_MIN"] or 0) / 60.0
        if age_hours > ctx.settings.external_max_age_hours:
            warnings.append(RowError("STALE_SOURCE",
                                     f"ultimul pricelist (PLID {plid}) are {age_hours:.0f} h - importul extern "
                                     "(WMSParsers / frame78 / ultra2_sync) nu a rulat", severity=Severity.WARN))

        if ctx.plid is None:
            last = repo.last_processed_plid(ctx.db, supplier_id)
            if last is not None and plid <= last:
                return FetchResult(items=[], plid=plid, unchanged=True, warnings=warnings,
                                   plid_processed=repo.pricelist_done(info),
                                   note=f"niciun pricelist nou dupa PLID {last}")

        ctx.progress(f"citesc PLID {plid}")
        items = repo.load_pricelist_items(ctx.db, plid)
        payload = sorted((i.code, i.price0, i.cur0, i.price3, i.cur3, i.price7, i.cur7, i.stock) for i in items)
        return FetchResult(items=items, n_fetched=len(items), plid=plid, plid_processed=repo.pricelist_done(info),
                           source_sha256=sha256_json(payload), warnings=warnings,
                           note=(info.get("MENTIUNI") or "").strip() or None)
