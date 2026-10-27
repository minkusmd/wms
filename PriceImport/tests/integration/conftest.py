"""Baza Firebird 5 embedded pentru testele de integrare: schema minima + DDL-urile PriceImport."""

from __future__ import annotations

import os
import subprocess
from pathlib import Path

import pytest

FB_HOME = Path(os.environ.get("PI_TEST_FB_HOME", r"C:\Program Files\Firebird\Firebird_5_0"))
ISQL = FB_HOME / "isql.exe"
REPO = Path(__file__).resolve().parents[3]
BASE_SCHEMA = Path(__file__).resolve().parents[1] / "schema" / "base_schema.sql"
DDL = [REPO / "DB Model" / name for name in (
    "price_import_stage1.sql", "price_import_grants.sql", "price_import_stage2.sql", "price_import_stage2_grants.sql")]

needs_fb = pytest.mark.skipif(not ISQL.exists(), reason="Firebird 5 local lipseste")


def run_isql(db_path: Path | None, script: Path) -> None:
    env = {**os.environ, "ISC_USER": "SYSDBA", "ISC_PASSWORD": "x"}
    args = [str(ISQL), "-q", "-b", "-i", str(script)] + ([str(db_path)] if db_path else [])
    res = subprocess.run(args, capture_output=True, text=True, env=env)
    assert res.returncode == 0 and "Statement failed" not in res.stderr, res.stderr + res.stdout


def build_db(folder: Path, scripts: list[Path]) -> Path:
    """Baza noua; isql (DDL) ruleaza inainte de orice conexiune Python (embedded tine fisierul exclusiv)."""
    db_path = folder / "pi_it.fdb"
    create = folder / "create.sql"
    create.write_text(f"create database '{db_path.as_posix()}' page_size 8192 default character set UTF8;\n")
    run_isql(None, create)
    for script in [BASE_SCHEMA, *scripts]:
        run_isql(db_path, script)
    return db_path


def make_settings(db_path: Path, folder: Path, **over):
    from priceimport.config import Settings
    values = dict(fb_host="", fb_database=str(db_path), fb_user="SYSDBA", fb_password="x",
                  fb_client_library=str(FB_HOME / "fbclient.dll"), data_dir=folder / "data",
                  suppliers_dir=folder / "suppliers")
    values.update(over)
    return Settings(**values)
