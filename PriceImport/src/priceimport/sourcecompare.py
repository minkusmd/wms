"""Echivalenta unui adaptor nativ cu pricelistul creat de importul Delphi (WMSParsers / frame78).

Aceleasi coduri si aceleasi valori in campurile pe care le folosesc reevaluarile; diferentele de pret
intre doua momente diferite (PLID-ul vechi vs descarcarea de acum) sint asteptate si se numara separat.
"""

from __future__ import annotations

from dataclasses import dataclass, field

from .models import SupplierItem

FIELDS = ("price0", "cur0", "price7", "cur7", "price3", "cur3", "name", "brand", "model", "category", "stock")
PRICE_FIELDS = {"price0", "price3", "price7"}


def _norm(name: str, value):
    if name in PRICE_FIELDS:
        return round(float(value or 0), 2)            # NULL si 0 sint acelasi lucru pentru reevaluari
    if name.startswith("cur"):
        return value
    text = " ".join(str(value or "").split())
    return text


@dataclass
class SourceDiff:
    only_new: list[str] = field(default_factory=list)
    only_old: list[str] = field(default_factory=list)
    common: int = 0
    field_diffs: dict[str, list[tuple[str, object, object]]] = field(default_factory=dict)

    def identical_share(self, name: str) -> float:
        return 1.0 - len(self.field_diffs.get(name, [])) / self.common if self.common else 1.0


def compare_items(new: list[SupplierItem], old: list[SupplierItem]) -> SourceDiff:
    by_new = {i.code.rstrip(): i for i in new}
    by_old = {i.code.rstrip(): i for i in old}
    result = SourceDiff(only_new=sorted(set(by_new) - set(by_old)), only_old=sorted(set(by_old) - set(by_new)))
    for code in sorted(set(by_new) & set(by_old)):
        result.common += 1
        a, b = by_new[code], by_old[code]
        for name in FIELDS:
            va, vb = _norm(name, getattr(a, name)), _norm(name, getattr(b, name))
            if va != vb:
                result.field_diffs.setdefault(name, []).append((code, vb, va))
    return result


def format_diff(diff: SourceDiff, examples: int = 5) -> str:
    lines = [f"comune: {diff.common}; doar in sursa noua: {len(diff.only_new)}; doar in PLID: {len(diff.only_old)}"]
    if diff.only_new:
        lines.append("  doar noi: " + ", ".join(diff.only_new[:examples]))
    if diff.only_old:
        lines.append("  doar in PLID: " + ", ".join(diff.only_old[:examples]))
    for name in FIELDS:
        rows = diff.field_diffs.get(name, [])
        if rows:
            sample = "; ".join(f"{c}: {old!r} -> {new!r}" for c, old, new in rows[:examples])
            lines.append(f"  {name}: {len(rows)} diferite ({diff.identical_share(name):.1%} identice) - {sample}")
    return "\n".join(lines)
