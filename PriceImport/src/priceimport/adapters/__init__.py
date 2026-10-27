"""Registrul adaptoarelor: TPI_SUPPLIER.ADAPTER_CODE -> clasa. Un furnizor nou = un modul + o linie aici."""

from __future__ import annotations

from .agropiese import AgroPieseAdapter
from .base import AdapterError, DeadlineExceeded, RunContext, SupplierAdapter
from .external_plid import ExternalPlidAdapter

ADAPTERS: dict[str, type[SupplierAdapter]] = {
    cls.code: cls for cls in (ExternalPlidAdapter, AgroPieseAdapter)
}


def get_adapter(code: str) -> SupplierAdapter:
    try:
        return ADAPTERS[code]()
    except KeyError as exc:
        raise AdapterError("CONFIG", f"adaptor necunoscut: {code}") from exc


__all__ = ["ADAPTERS", "AdapterError", "DeadlineExceeded", "RunContext", "SupplierAdapter", "get_adapter"]
