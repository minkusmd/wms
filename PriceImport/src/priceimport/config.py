"""Configurarea serviciului: variabile de mediu (prefix PI_) + fisiere suppliers/<id>.yaml.

Secretele nu stau in fisiere urmarite de git: parola Firebird vine din PI_FB_PASSWORD sau din
fisierul indicat de PI_FB_PASSWORD_FILE (Docker secret); cheile API ale furnizorilor stau in
TS_API_CONFIG, ca in WMS.
"""

from __future__ import annotations

from datetime import time
from functools import lru_cache
from pathlib import Path
from typing import Any

import yaml
from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict

PROJECT_DIR = Path(__file__).resolve().parents[2]


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="PI_", env_file=".env", extra="ignore")

    # Firebird. FB_HOST gol = conexiune embedded la fisierul FB_DATABASE (teste locale).
    fb_host: str = "192.168.106.254"
    fb_port: int = 3050
    fb_database: str = "SW"
    fb_user: str = "PRICEIMPORT"
    fb_password: str = ""
    fb_password_file: Path | None = None
    fb_client_library: str | None = None
    fb_charset: str = "UTF8"
    # utilizatorul WMS in numele caruia se scriu documentele (etapa 2); 0 = nesetat
    wms_user_id: int = 0

    timezone: str = "Europe/Chisinau"
    data_dir: Path = PROJECT_DIR / "data"
    suppliers_dir: Path = PROJECT_DIR / "suppliers"

    # ferestrele zilnice: ora de start; termenele sint minute de la start
    windows: list[time] = Field(default_factory=lambda: [time(9, 0), time(15, 0)])
    soft_deadline_min: int = 40
    hard_deadline_min: int = 55
    misfire_grace_min: int = 30
    max_parallel: int = 4
    stale_run_min: int = 3
    # pricelist extern mai vechi de atit = furnizorul nu mai e importat (alerta)
    external_max_age_hours: int = 26

    telegram_channel: str = "PRICELIST_IMPORT"
    telegram_errors_channel: str = "ERRORS"
    telegram_enabled: bool = True

    http_connect_timeout: float = 10.0
    http_read_timeout: float = 60.0
    http_max_attempts: int = 5

    def password(self) -> str:
        if self.fb_password_file and self.fb_password_file.exists():
            return self.fb_password_file.read_text(encoding="utf-8").strip()
        return self.fb_password

    def dsn(self) -> str:
        if not self.fb_host:
            return self.fb_database
        return f"{self.fb_host}/{self.fb_port}:{self.fb_database}"


@lru_cache
def get_settings() -> Settings:
    return Settings()


def load_supplier_yaml(settings: Settings, supplier_id: int) -> dict[str, Any]:
    """Parametrii adaptorului (suppliers/<id>.yaml); lipsa fisierului = dictionar gol."""
    path = settings.suppliers_dir / f"{supplier_id}.yaml"
    if not path.exists():
        return {}
    with path.open(encoding="utf-8") as f:
        return yaml.safe_load(f) or {}
