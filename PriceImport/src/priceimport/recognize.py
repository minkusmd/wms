"""Recunoasterea furnizorului unui fisier primit prin Telegram (plan, sectiunea 6.2).

Semnalele se combina "noisy-or" (1 - produsul lui 1 - s): textul `#ID` decide singur; regulile din
TPI_FILE_RULE (expeditor, nume de fisier, text, foaie, semnatura antetului) si suprapunerea codurilor cu
TS_GOODS_FOREIGN adauga incredere. Decizie automata doar cu scor >= 0.9 si un cistigator clar.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field

AUTO_SCORE = 0.9
AUTO_MARGIN = 0.3
SKU_MIN_OVERLAP = 0.3
SKU_WEIGHT = 0.95
RULE_WEIGHTS = {"SENDER_TG_ID": 0.6, "FILENAME_RE": 0.4, "CAPTION_RE": 0.5, "HEADER_SIG": 0.8, "SHEET_NAME": 0.3}

_CAPTION_ID = re.compile(r"(?:#|(?:^|\s)/?f(?:urnizor)?\s+)(\d{2,7})\b", re.IGNORECASE)


@dataclass
class Candidate:
    supplier_id: int
    score: float = 0.0
    methods: list[str] = field(default_factory=list)


@dataclass
class Recognition:
    candidates: list[Candidate]
    decided: Candidate | None
    explicit: bool = False                    # furnizorul scris in text (#ID)

    @property
    def method(self) -> str | None:
        if self.decided is None:
            return None
        return "CAPTION" if self.explicit else "+".join(self.decided.methods)[:16]


@dataclass
class FileSignals:
    caption: str | None
    sender_tg_id: int | None
    forward_from: str | None
    file_name: str
    sheet_names: list[str]
    header_signature: str | None
    codes: list[str]


def caption_supplier(caption: str | None) -> int | None:
    match = _CAPTION_ID.search(caption or "")
    return int(match.group(1)) if match else None


def _rule_matches(rule_type: str, pattern: str, s: FileSignals) -> bool:
    try:
        if rule_type == "SENDER_TG_ID":
            return s.sender_tg_id is not None and pattern.strip() == str(s.sender_tg_id)
        if rule_type == "HEADER_SIG":
            return s.header_signature is not None and pattern.strip() == s.header_signature
        if rule_type == "FILENAME_RE":
            return re.search(pattern, s.file_name, re.IGNORECASE) is not None
        if rule_type == "CAPTION_RE":
            return re.search(pattern, " ".join(filter(None, [s.caption, s.forward_from])), re.IGNORECASE) is not None
        if rule_type == "SHEET_NAME":
            return any(re.search(pattern, name, re.IGNORECASE) for name in s.sheet_names)
    except re.error:
        return False
    return False


def recognize(signals: FileSignals, rules: list[dict], overlap: dict[int, int], configured: set[int]) -> Recognition:
    """`rules` = randurile TPI_FILE_RULE active, `overlap` = furnizor -> coduri gasite in TS_GOODS_FOREIGN,
    `configured` = furnizorii din TPI_SUPPLIER (doar ei pot fi alesi automat)."""
    explicit = caption_supplier(signals.caption)
    if explicit is not None:
        cand = Candidate(explicit, 1.0, ["CAPTION"])
        return Recognition([cand], cand if explicit in configured else None, explicit=True)

    evidence: dict[int, list[tuple[str, float]]] = {}
    for rule in rules:
        rule_type = rule["RULE_TYPE"].strip()
        if _rule_matches(rule_type, rule["PATTERN"], signals):
            weight = RULE_WEIGHTS.get(rule_type, 0.3) * float(rule.get("WEIGHT") or 1)
            evidence.setdefault(rule["SUPPLIERID"], []).append((rule_type, min(weight, 0.99)))
    sample = max(len(signals.codes), 1)
    for supplier_id, found in overlap.items():
        share = found / sample
        if share >= SKU_MIN_OVERLAP:
            evidence.setdefault(supplier_id, []).append((f"SKU{round(share * 100)}", min(share * SKU_WEIGHT, 0.99)))

    candidates = []
    for supplier_id, items in evidence.items():
        miss = 1.0
        for _, s in items:
            miss *= 1.0 - s
        candidates.append(Candidate(supplier_id, round(1.0 - miss, 3), [m for m, _ in items]))
    candidates.sort(key=lambda c: (-c.score, c.supplier_id))

    eligible = [c for c in candidates if c.supplier_id in configured]
    decided = None
    if eligible and eligible[0].score >= AUTO_SCORE:
        runner_up = next((c.score for c in candidates if c.supplier_id != eligible[0].supplier_id), 0.0)
        if eligible[0].score - runner_up >= AUTO_MARGIN:
            decided = eligible[0]
    return Recognition(candidates, decided)
