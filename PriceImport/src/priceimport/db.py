"""Conexiunea Firebird (firebird-driver) + citiri/scrieri simple cu rezultat ca dict."""

from __future__ import annotations

from contextlib import contextmanager
from typing import Any, Iterable, Iterator, Sequence

from firebird.driver import connect, driver_config

from .config import Settings

_client_configured = False


def _configure_client(settings: Settings) -> None:
    global _client_configured
    if not _client_configured and settings.fb_client_library:
        driver_config.fb_client_library.value = settings.fb_client_library
    _client_configured = True


class Db:
    """O conexiune; fiecare metoda lucreaza in tranzactia curenta, commit() explicit."""

    def __init__(self, settings: Settings):
        _configure_client(settings)
        self.con = connect(settings.dsn(), user=settings.fb_user, password=settings.password(),
                           charset=settings.fb_charset)

    def close(self) -> None:
        try:
            if self.con.main_transaction.is_active():
                self.con.rollback()
        finally:
            self.con.close()

    def commit(self) -> None:
        # fara tranzactie activa (nimic citit / scris de la ultimul commit) driverul ar arunca AttributeError
        if self.con.main_transaction.is_active():
            self.con.commit()

    def rollback(self) -> None:
        if self.con.main_transaction.is_active():
            self.con.rollback()

    def query(self, sql: str, params: Sequence[Any] = ()) -> list[dict[str, Any]]:
        with self.con.cursor() as cur:
            cur.execute(sql, params)
            names = [d[0].strip() for d in cur.description]
            return [dict(zip(names, row)) for row in cur.fetchall()]

    def query_one(self, sql: str, params: Sequence[Any] = ()) -> dict[str, Any] | None:
        rows = self.query(sql, params)
        return rows[0] if rows else None

    def scalar(self, sql: str, params: Sequence[Any] = ()) -> Any:
        with self.con.cursor() as cur:
            cur.execute(sql, params)
            row = cur.fetchone()
            return row[0] if row else None

    def execute(self, sql: str, params: Sequence[Any] = ()) -> None:
        with self.con.cursor() as cur:
            cur.execute(sql, params)

    def execute_returning(self, sql: str, params: Sequence[Any] = ()) -> Any:
        """INSERT ... RETURNING x -> x."""
        with self.con.cursor() as cur:
            cur.execute(sql, params)
            row = cur.fetchone()
            return row[0] if row else None

    def executemany(self, sql: str, rows: Iterable[Sequence[Any]]) -> int:
        """Instructiunea se pregateste o singura data (cursorul o tine in cache)."""
        n = 0
        with self.con.cursor() as cur:
            for row in rows:
                cur.execute(sql, row)
                n += 1
        return n


@contextmanager
def open_db(settings: Settings) -> Iterator[Db]:
    db = Db(settings)
    try:
        yield db
    finally:
        db.close()
