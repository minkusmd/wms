"""Raportul unei ferestre / rulari: mesaj HTML pentru Telegram (<= 4096 caractere) + fisier .xlsx cu tot."""

from __future__ import annotations

import html
from collections import Counter
from datetime import datetime
from pathlib import Path

import xlsxwriter

from .coordinator import RunOutcome
from .models import Change, ChangeType, Decision, RunStatus

TELEGRAM_LIMIT = 4000          # lasam loc pentru sufixul "(trunchiat)"
TOP_N = 5

STATUS_ICON = {
    RunStatus.DRY_RUN: "✅", RunStatus.APPLIED: "✅", RunStatus.PARTIAL: "🟡", RunStatus.UNCHANGED: "⏭",
    RunStatus.BLOCKED: "🛑", RunStatus.ERROR: "❌", RunStatus.TIMEOUT: "⌛", RunStatus.SKIPPED: "⏸",
}

REASON_TEXT = {
    "THRESHOLD_UP": "peste pragul de creștere", "THRESHOLD_DOWN": "peste pragul de scădere",
    "ZERO_PRICE": "preț 0", "NEGATIVE_PRICE": "preț negativ", "CURRENCY_CHANGED": "monedă schimbată",
    "CURRENCY_MISMATCH": "monedă greșită (≈ curs)", "ABSURD_PRICE_LOW": "preț absurd de mic",
    "ABSURD_PRICE_HIGH": "preț absurd de mare", "ITEM_QUARANTINED": "alt preț al produsului în carantină",
    "CLOSE_REJECTED": "respins de CLOSE_REEVALUARE",
}

PRICE_FIELD_TEXT = {0: "cost", 3: "RRP", 7: "indicativ"}


def _e(text) -> str:
    return html.escape(str(text if text is not None else ""), quote=False)


def _num(n: int) -> str:
    return f"{n:,}".replace(",", " ")


def _short(text: str | None, limit: int = 45) -> str:
    text = (text or "").strip()
    return text if len(text) <= limit else text[:limit - 1] + "…"


def _real_price_changes(changes: list[Change], change_type: ChangeType) -> list[Change]:
    """Schimbarile reale de pret, una per produs (coloana cu variatia cea mai mare: la furnizorii cu
    PRICE0 = PRICE7 aceeasi schimbare ar aparea de doua ori)."""
    best: dict[tuple[str, int | None], Change] = {}
    for c in changes:
        if c.change_type != change_type or c.reason == "NOISE":
            continue
        key = (c.code, c.goodsid)
        if key not in best or abs(c.delta_pct or 0) > abs(best[key].delta_pct or 0):
            best[key] = c
    return list(best.values())


def _supplier_line(o: RunOutcome) -> str:
    icon = STATUS_ICON.get(o.status, "•")
    name = f"{_e(_short(o.supplier.name, 28))} {o.supplier.supplier_id}"
    if o.status in (RunStatus.ERROR, RunStatus.TIMEOUT):
        err = o.errors[0] if o.errors else None
        detail = _e(_short(err.message if err else o.note, 90))
        http = f" · HTTP {o.error_http}" if o.error_http else ""
        retry = f" · {o.error_retries} retry" if o.error_retries else ""
        return f"{icon} {name} — {o.status.value}{http}{retry}: {detail}"
    if o.status in (RunStatus.UNCHANGED, RunStatus.SKIPPED):
        return f"{icon} {name} — {o.status.value}: {_e(_short(o.note, 80))}"
    d = o.diff
    parts = [f"{_num(o.n_valid)} poz.", f"{o.duration_sec:.0f} s"]
    if d:
        up = len(_real_price_changes(d.changes, ChangeType.PRICE_UP))
        down = len(_real_price_changes(d.changes, ChangeType.PRICE_DOWN))
        parts.append(f"↑{up} ↓{down}")
        new = d.count(ChangeType.NEW)
        ret = d.count(ChangeType.RETURNED)
        gone = d.count(ChangeType.GONE)
        if new:
            parts.append(f"+{new} noi")
        if ret:
            parts.append(f"🔁{ret}")
        if gone:
            parts.append(f"−{gone} ies")
        quarantine = len({(c.code, c.goodsid) for c in d.changes if c.decision == Decision.QUARANTINE})
        if quarantine:
            parts.append(f"🧪{quarantine}")
    if o.n_applied or o.docids:
        parts.append(f"📝 {o.n_applied} aplicate" + (f" (doc {', '.join(map(str, o.docids))})" if o.docids else ""))
    if o.n_rejected:
        parts.append(f"⛔ {o.n_rejected} respinse")
    line = f"{icon} {name} — " + " · ".join(parts)
    if o.status == RunStatus.BLOCKED:
        line += f"\n    🛑 BLOCAT: {_e(_short(o.note, 150))}"
    if o.plid:
        line += f" · PLID {o.plid}"
    return line


def build_message(title: str, outcomes: list[RunOutcome], dry_run: bool = True) -> str:
    n_err = sum(1 for o in outcomes if o.status in (RunStatus.ERROR, RunStatus.TIMEOUT, RunStatus.BLOCKED))
    header = f"📦 <b>{_e(title)}</b>" + (" · <i>dry-run</i>" if dry_run else "")
    if n_err:
        header += f"\n⚠️ {n_err} cu probleme din {len(outcomes)}"
    sections: list[str] = [header, "\n".join(_supplier_line(o) for o in outcomes)]

    all_changes = [(o, c) for o in outcomes for c in o.changes]
    new_items = [c for _, c in all_changes if c.change_type == ChangeType.NEW]
    if new_items:
        cats = Counter((c.category or "fără categorie").strip() or "fără categorie" for c in new_items)
        top = " · ".join(f"{_e(_short(k, 25))} {v}" for k, v in cats.most_common(6))
        more = f" · +{len(cats) - 6} categorii" if len(cats) > 6 else ""
        sections.append(f"🆕 <b>Produse noi nelegate: {len(new_items)}</b> — {top}{more}")

    # in topuri doar schimbarile cu procent (pretul vechi 0 -> nou nu are delta)
    downs = sorted(((o, c) for o in outcomes for c in _real_price_changes(o.changes, ChangeType.PRICE_DOWN)
                    if c.delta_pct is not None), key=lambda oc: oc[1].delta_pct)
    ups = sorted(((o, c) for o in outcomes for c in _real_price_changes(o.changes, ChangeType.PRICE_UP)
                  if c.delta_pct is not None), key=lambda oc: -oc[1].delta_pct)
    for label, rows in (("📉 Top scăderi", downs), ("📈 Top creșteri", ups)):
        if rows:
            many = len(outcomes) > 1
            lines = [f"• {_e(_short(c.name or c.code))} {c.delta_pct:+.1f}% "
                     f"({PRICE_FIELD_TEXT.get(c.price_field, '')}"
                     + (f", {_e(_short(o.supplier.name, 15))})" if many else ")")
                     for o, c in rows[:TOP_N]]
            sections.append(f"<b>{label}</b>\n" + "\n".join(lines))

    gone = sum(1 for _, c in all_changes if c.change_type == ChangeType.GONE)
    pending = sum(1 for _, c in all_changes if c.change_type == ChangeType.PENDING_GONE)
    returned = sum(1 for _, c in all_changes if c.change_type == ChangeType.RETURNED)
    if gone or pending or returned:
        sections.append(f"🚫 Ies din pricelist: {gone} · ⏳ lipsă prima dată: {pending} · 🔁 Reapărute: {returned}")

    quarantine = Counter(c.reason for _, c in all_changes
                         if c.decision == Decision.QUARANTINE and c.reason != "ITEM_QUARANTINED")
    if quarantine:
        detail = ", ".join(f"{v} × {REASON_TEXT.get(k, k)}" for k, v in quarantine.most_common())
        sections.append(f"🧪 <b>Carantină: {sum(quarantine.values())}</b> ({_e(detail)})")

    error_lines = []
    for o in outcomes:
        for err in o.errors:
            if err.error_class in ("NO_CODE", "BAD_SKU", "BAD_NUMBER", "SCHEMA") and err.row_no is not None:
                continue      # erorile de rand sint in fisierul .xlsx / TPI_RUN_ERROR
            where = f" [{_e(o.error_endpoint)}]" if o.error_endpoint and err.severity.value == "CRIT" else ""
            error_lines.append(f"• {_e(_short(o.supplier.name, 20))}: {_e(err.error_class)}{where} — "
                               f"{_e(_short(err.message, 120))}")
    if error_lines:
        sections.append("<b>⚠️ Erori</b>\n" + "\n".join(error_lines[:10])
                        + (f"\n… încă {len(error_lines) - 10}" if len(error_lines) > 10 else ""))

    run_ids = [o.run_id for o in outcomes if o.run_id]
    if run_ids:
        sections.append(f"<i>Detalii: VW_TPI_RUN / TPI_ITEM_CHANGE, RUNID {min(run_ids)}–{max(run_ids)}</i>")
    return _fit(sections)


def _fit(sections: list[str]) -> str:
    text = "\n\n".join(sections)
    if len(text) <= TELEGRAM_LIMIT:
        return text
    # se scot liniile de la coada sectiunilor lungi pina incape
    while len(text) > TELEGRAM_LIMIT and any("\n" in s for s in sections[1:]):
        idx = max(range(1, len(sections)), key=lambda i: len(sections[i]))
        lines = sections[idx].split("\n")
        if len(lines) <= 1:
            break
        sections[idx] = "\n".join(lines[:-1])
        text = "\n\n".join(sections)
    return text[:TELEGRAM_LIMIT] + ("\n(trunchiat)" if len(text) > TELEGRAM_LIMIT else "")


def write_xlsx(path: Path, outcomes: list[RunOutcome]) -> Path:
    path.parent.mkdir(parents=True, exist_ok=True)
    wb = xlsxwriter.Workbook(str(path))
    bold = wb.add_format({"bold": True})
    pct = wb.add_format({"num_format": "0.0"})
    ws = wb.add_worksheet("Rulari")
    head = ["RUNID", "Furnizor", "ID", "Status", "Durata s", "PLID", "Pozitii", "Nota"]
    ws.write_row(0, 0, head, bold)
    for r, o in enumerate(outcomes, start=1):
        ws.write_row(r, 0, [o.run_id, o.supplier.name, o.supplier.supplier_id, o.status.value,
                            round(o.duration_sec, 1), o.plid, o.n_valid, o.note or ""])
    ws.autofilter(0, 0, max(len(outcomes), 1), len(head) - 1)

    ws = wb.add_worksheet("Schimbari")
    head = ["RUNID", "Furnizor", "Cod", "GOODSID", "Tip", "Coloana", "Vechi", "Nou", "Val. veche", "Val. noua",
            "Delta %", "Decizie", "Motiv", "Denumire", "Categorie"]
    ws.write_row(0, 0, head, bold)
    r = 1
    for o in outcomes:
        for c in o.changes:
            ws.write_row(r, 0, [o.run_id, o.supplier.name, c.code, c.goodsid, c.change_type.value,
                                PRICE_FIELD_TEXT.get(c.price_field, ""), c.old_price, c.new_price, c.old_cur,
                                c.new_cur])
            if c.delta_pct is not None:
                ws.write_number(r, 10, c.delta_pct, pct)
            ws.write_row(r, 11, [c.decision.value, c.reason or "", c.name or "", c.category or ""])
            r += 1
    ws.autofilter(0, 0, max(r - 1, 1), len(head) - 1)
    ws.freeze_panes(1, 0)

    ws = wb.add_worksheet("Erori")
    ws.write_row(0, 0, ["RUNID", "Furnizor", "Severitate", "Clasa", "Rand", "Cod", "Mesaj"], bold)
    r = 1
    for o in outcomes:
        for err in o.errors:
            ws.write_row(r, 0, [o.run_id, o.supplier.name, err.severity.value, err.error_class, err.row_no,
                                err.code or "", err.message])
            r += 1
    wb.close()
    return path


def report_path(data_dir: Path, label: str) -> Path:
    return data_dir / "reports" / f"{datetime.now():%Y-%m-%d}" / f"{label}.xlsx"
