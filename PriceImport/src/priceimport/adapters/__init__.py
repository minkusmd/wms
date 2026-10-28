"""Registrul adaptoarelor: TPI_SUPPLIER.ADAPTER_CODE -> clasa. Un furnizor nou = un modul + o linie aici."""

from __future__ import annotations

from .accent import AccentAdapter
from .agropiese import AgroPieseAdapter
from .base import AdapterError, DeadlineExceeded, RunContext, SupplierAdapter
from .dmlink import DMLinkAdapter
from .excel import ExcelAdapter
from .external_plid import ExternalPlidAdapter
from .nex import NexAdapter
from .olisgrup import OlisGrupAdapter
from .triomac import TriomacAdapter

ADAPTERS: dict[str, type[SupplierAdapter]] = {
    cls.code: cls for cls in (ExternalPlidAdapter, AgroPieseAdapter, ExcelAdapter, AccentAdapter, DMLinkAdapter,
                              OlisGrupAdapter, NexAdapter, TriomacAdapter)
}


def get_adapter(code: str) -> SupplierAdapter:
    try:
        return ADAPTERS[code]()
    except KeyError as exc:
        raise AdapterError("CONFIG", f"adaptor necunoscut: {code}") from exc


__all__ = ["ADAPTERS", "AdapterError", "DeadlineExceeded", "RunContext", "SupplierAdapter", "get_adapter"]
