"""Obiecte de test comune."""

from __future__ import annotations

from priceimport.models import GfRow, SupplierItem
from priceimport.repo import SupplierConfig

MDL, USD, EUR = 498, 840, 976
RATES = {MDL: 1.0, USD: 18.23, EUR: 20.32}


def supplier(**over) -> SupplierConfig:
    base = dict(supplier_id=198, name="ACCENT", adapter_code="external_plid", source_kind="A", window_mask=3,
                priority=10, est_duration_sec=None, max_rps=2.0, price_category_id=-1, max_up_pct=20.0,
                max_down_pct=20.0, noise_pct=0.5, min_volume_ratio=0.7, gone_after_runs=2, auto_apply=False,
                active=True, firma_id=None)
    base.update(over)
    return SupplierConfig(**base)


def item(code: str, p7: float | None = 100.0, p0: float | None = None, p3: float | None = None,
         cur: int = USD, name: str | None = None, category: str | None = None) -> SupplierItem:
    return SupplierItem(code=code, name=name or f"Produs {code}", category=category, price0=p0, cur0=cur,
                        price3=p3, cur3=MDL, price7=p7, cur7=cur)


def gf(code: str, goodsid: int, p7: float | None = 100.0, p0: float | None = None, p3: float | None = None,
       in_price: bool = True, epp: bool = False, goods_in_price: bool = True, cur: int = USD) -> GfRow:
    return GfRow(goodsid=goodsid, code=code, title=f"Titlu {code}", price0=p0, cur0=cur, price3=p3, cur3=MDL,
                 price7=p7, cur7=cur, in_price=in_price, epp=epp, goods_in_price=goods_in_price)
