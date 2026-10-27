"""Verificarea de echivalenta (criteriul de acceptanta al etapei 1): pentru un PLID, setul ales de diff-ul
Python = setul celor 4 interogari ale reevaluarilor din WMS (copiate din Parsers/PriceListReevaluationUnit.pas).

Interogarile WMS compara pricelistul cu starea CURENTA din TS_GOODS_FOREIGN - au sens pentru un PLID
inca neprelucrat (TS_PRICELISTS.FLAGS fara bitul 4); pentru unul prelucrat ambele parti sint aproape goale.
"""

from __future__ import annotations

from dataclasses import dataclass

from . import repo
from .db import Db
from .diff import diff_against_gf
from .models import ChangeType

SQL_NEW = (
    "select gf.goodsid, pli1.supplier_goods_code "
    "from ts_pricelist_items pli1 "
    "join ts_goods_foreign gf on (gf.goods_code = pli1.supplier_goods_code and gf.customerid = ?) "
    "where pli1.plid = ? and not exists(select 1 from ts_goods_foreign gfo "
    "  where gfo.goods_code = pli1.supplier_goods_code and gfo.customerid = ? and get_flg_value(gfo.flags, 3) = 1)")

SQL_OLD = (
    "SELECT gf.GOODSID, gf.GOODS_CODE AS SUPPLIER_GOODS_CODE FROM TS_GOODS_FOREIGN gf "
    "JOIN TS_PRICELISTS pl ON pl.PLID = ? "
    "WHERE gf.CUSTOMERID = pl.SUPPLIERID AND get_flg_value(gf.FLAGS, 3) = 1 "
    "AND NOT EXISTS (SELECT 1 FROM TS_PRICELIST_ITEMS pi WHERE pi.PLID = pl.PLID "
    "AND pi.SUPPLIER_GOODS_CODE = gf.GOODS_CODE)")

_SQL_PRICES = (
    "select GF.GOODSID, P.SUPPLIER_GOODS_CODE from TS_PRICELIST_ITEMS P "
    "join ts_pricelists pl on pl.plid = P.plid "
    "join TS_GOODS_FOREIGN GF on (GF.GOODS_CODE = P.SUPPLIER_GOODS_CODE and GF.CUSTOMERID = pl.supplierid) and ("
    "  (coalesce(P.PRICE7, 0) {op} coalesce(gf.PRICE7, 0)) or "
    "  (coalesce(P.PRICE0, 0) > 0 and coalesce(P.PRICE0, 0) {op} coalesce(gf.PRICE0, 0)) or "
    "  iif(get_flg_value(GF.flags, 4) = 1, (coalesce(P.PRICE3, 0) {op} coalesce(gf.PRICE3, 0)), false)) "
    "where P.plid = ? and GET_FLG_IN_PRICE(GF.GOODSID) = 1")
SQL_UP = _SQL_PRICES.format(op=">")
SQL_DOWN = _SQL_PRICES.format(op="<")


@dataclass
class KindComparison:
    kind: str
    wms: set[tuple[str, int]]
    python: set[tuple[str, int]]

    @property
    def only_wms(self) -> set[tuple[str, int]]:
        return self.wms - self.python

    @property
    def only_python(self) -> set[tuple[str, int]]:
        return self.python - self.wms

    @property
    def equal(self) -> bool:
        return self.wms == self.python


def _pairs(db: Db, sql: str, params) -> set[tuple[str, int]]:
    return {(r["SUPPLIER_GOODS_CODE"], r["GOODSID"]) for r in db.query(sql, params)}


def compare_plid(db: Db, plid: int) -> tuple[dict, list[KindComparison]]:
    info = repo.pricelist_info(db, plid)
    if info is None:
        raise ValueError(f"PLID {plid} nu exista")
    supplier_id = info["SUPPLIERID"]
    wms_new = _pairs(db, SQL_NEW, (supplier_id, plid, supplier_id))
    wms_old = _pairs(db, SQL_OLD, (plid,))
    # in WMS un cod "nou" poate aparea si la preturi (produsul e in pret prin alt furnizor); efectul e acelasi
    wms_up = _pairs(db, SQL_UP, (plid,)) - wms_new
    wms_down = _pairs(db, SQL_DOWN, (plid,)) - wms_new

    _, rates = repo.load_currencies(db)
    items = repo.load_pricelist_items(db, plid)
    result = diff_against_gf(items, repo.load_gf_state(db, supplier_id), prev_codes=set(),
                             exclusions=set(), noise_pct=0.0, gone_after_runs=1, rates=rates)

    def ours(*types: ChangeType) -> set[tuple[str, int]]:
        return {(c.code, c.goodsid) for c in result.changes if c.change_type in types and c.goodsid is not None}

    comparisons = [
        KindComparison("produse noi (RETURNED)", wms_new, ours(ChangeType.RETURNED)),
        KindComparison("produse vechi (GONE)", wms_old, ours(ChangeType.GONE, ChangeType.PENDING_GONE)),
        KindComparison("preturi marite (PRICE_UP)", wms_up, ours(ChangeType.PRICE_UP)),
        KindComparison("preturi scazute (PRICE_DOWN)", wms_down, ours(ChangeType.PRICE_DOWN)),
    ]
    return info, comparisons
