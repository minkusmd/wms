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
    # etapa 2 - aplicarea preturilor. Comutatorul global e OPRIT implicit; in plus fiecare furnizor
    # trebuie sa aiba TPI_SUPPLIER.FLG_AUTO_APPLY = 1.
    apply_enabled: bool = False
    # utilizatorul WMS si firma documentelor 1414 (ca WMSParsers: /user:204 /firma:307225 PRIME STORE)
    wms_user_id: int = 204
    default_firma_id: int = 307225
    quarantine_expire_days: int = 3
    approval_memory_days: int = 30
    alert_repeat_min: int = 360

    # etapa 3 - botul Telegram pi-bot (bot SEPARAT de cel al SWNService: getUpdates are un singur consumator)
    bot_token: str = ""
    bot_token_file: Path | None = None
    telegram_api_base: str = "https://api.telegram.org"
    bot_max_file_mb: int = 20                 # limita Bot API pentru getFile
    preview_max_age_hours: int = 6            # "Aplica" pe o previzualizare mai veche cere una noua
    # etapa 4a - potrivirea codurilor nelegate cu catalogul (zilnic, dupa ferestre)
    match_enabled: bool = True
    match_time: time = time(21, 30)
    # etapa 4b - continutul (imagini + descrieri), in afara ferestrelor de pret
    content_enabled: bool = True
    content_times: list[time] = Field(default_factory=lambda: [time(11, 0), time(22, 0)])
    content_threads: int = 8                  # fire de descarcare a imaginilor (ca cMamicoThreadCount)
    content_max_minutes: int = 50             # dupa atit descarcarea se opreste; restul ramine pentru rularea urmatoare
    content_transfer: bool = True             # copierea in TS_GOODS_IMAGE / TS_GOODS_DSC (fara suprascriere)
    # False = imaginile doar pentru codurile legate de un produs fara imagini; True = toate (ca WMSParsers)
    content_download_all: bool = False

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

    def token(self) -> str:
        if self.bot_token_file and self.bot_token_file.exists():
            return self.bot_token_file.read_text(encoding="utf-8").strip()
        return self.bot_token

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
