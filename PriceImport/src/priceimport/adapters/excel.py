"""Adaptorul `excel`: pricelisturile trimise de furnizorii manuali (Excel / CSV), primite prin botul Telegram
sau date din linia de comanda. Maparea coloanelor: suppliers/<id>.yaml (vezi excelparse); fara mapare,
coloanele se gasesc dupa antet (alias-uri RO / RU / EN)."""

from __future__ import annotations

from ..excelparse import ExcelError, detect_layout, file_sha256, parse_items, read_sheets
from ..models import FetchResult
from .base import AdapterError, RunContext, SupplierAdapter


class ExcelAdapter(SupplierAdapter):
    code = "excel"

    def fetch(self, ctx: RunContext) -> FetchResult:
        if ctx.file_path is None:
            raise AdapterError("CONFIG", "adaptorul excel are nevoie de un fisier (bot Telegram / --file)")
        try:
            sheets = read_sheets(ctx.file_path)
            layout = detect_layout(sheets, ctx.params)
            parsed = parse_items(sheets, layout, ctx.params, ctx.currency_ids)
        except ExcelError as exc:
            raise AdapterError(exc.error_class, str(exc)) from exc
        ctx.progress(layout.describe())
        note = (f"{ctx.file_path.name}: {layout.describe()}; {parsed.n_rows} rinduri, {len(parsed.items)} valide, "
                f"{parsed.n_skipped} sarite (fara pret / fara stoc), {parsed.n_duplicates} coduri repetate")
        return FetchResult(items=parsed.items, row_errors=parsed.row_errors, n_fetched=parsed.n_rows,
                           n_skipped=parsed.n_skipped, n_duplicates=parsed.n_duplicates,
                           source_sha256=file_sha256(ctx.file_path), note=note)
