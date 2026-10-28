"""Citirea campurilor JSON cu aceleasi reguli ca importurile Delphi (JStr / JFloat / JLang / JBool).

Valorile lipsa sau gresite nu opresc importul: textul devine "", numarul 0 (StrToFloatDef(..., 0)).
"""

from __future__ import annotations

import math
from typing import Any


def jstr(obj: Any, name: str) -> str:
    """Textul campului, Trim; null / obiect / lista = ""."""
    if not isinstance(obj, dict):
        return ""
    value = obj.get(name)
    if value is None or isinstance(value, (dict, list)):
        return ""
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, float) and value.is_integer():
        value = int(value)
    return str(value).strip()


def jfloat(obj: Any, name: str) -> float:
    """Numarul campului; un sir se citeste cu punct sau virgula zecimala; altfel 0."""
    if not isinstance(obj, dict):
        return 0.0
    value = obj.get(name)
    if isinstance(value, bool) or value is None:
        return 0.0
    if isinstance(value, (int, float)):
        return float(value) if math.isfinite(value) else 0.0
    if isinstance(value, str):
        try:
            number = float(value.strip().replace(",", "."))
        except ValueError:
            return 0.0
        return number if math.isfinite(number) else 0.0
    return 0.0


def jbool(obj: Any, name: str, default: bool) -> bool:
    if not isinstance(obj, dict):
        return default
    value = obj.get(name)
    if isinstance(value, bool):
        return value
    if isinstance(value, (int, float)):
        return value != 0
    if isinstance(value, str):
        return value.strip().lower() in ("true", "1")
    return default


def jobj(obj: Any, name: str) -> dict | None:
    value = obj.get(name) if isinstance(obj, dict) else None
    return value if isinstance(value, dict) else None


def jlang(obj: Any, name: str, lang: str) -> str:
    """Camp tradus {"ro": .., "ru": ..}; un sir simplu e acceptat pentru orice limba."""
    value = obj.get(name) if isinstance(obj, dict) else None
    if isinstance(value, dict):
        return jstr(value, lang)
    if value is None or isinstance(value, list):
        return ""
    return jstr({name: value}, name)


def trunc(value: float) -> int:
    """Trunc din Delphi (spre zero)."""
    return int(value)
