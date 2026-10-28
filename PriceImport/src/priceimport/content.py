"""Jobul de continut (etapa 4b): descrieri + imagini de la furnizorii cu API, apoi copierea la produse.

Pentru fiecare furnizor activ cu adaptor care stie continutul (dmlink, olisgrup, nex, triomac):
  1. descarcarea catalogului prin adaptor (aceleasi pozitii ca pricelistul: cu stoc, fara coduri ambigue);
  2. staging-ul TS_PRICELIST_ITEMS_DESCRIPTION / _IMAGES: se scrie doar descrierea cu alt text (SHA-256
     calculat in baza) si lista de URL-uri schimbata (rescrisa cu IMAGE null, ca in Delphi: imaginile deja
     descarcate ale listelor neschimbate raman); totul intr-o tranzactie;
  3. imaginile nedescarcate (IMAGE null) ale pozitiilor legate de un produs fara nicio imagine (doar acolo le
     poate copia pasul 4; PI_CONTENT_DOWNLOAD_ALL = toate, ca WMSParsers): in fire, PNG <= 1200 px; un cod se
     scrie doar daca a venit macar o imagine, altfel ramine pentru rularea urmatoare (DMLinkFetch);
  4. copierea in productie prin SP_PI_CONTENT_TRANSFER, cod cu cod (ordine alfabetica), commit la 50 -
     imaginile doar la produsele fara imagini, descrierea doar unde lipseste.
Accent (198) nu are continut in WMSParsers (imaginile lui vin prin FTP, alt flux) si nu intra aici.
"""

from __future__ import annotations

import hashlib
import html
import json
import socket
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, field
from typing import Any

from . import repo
from .adapters import ADAPTERS, AdapterError, RunContext, get_adapter
from .config import Settings, load_supplier_yaml
from .content_images import ImageFetcher
from .db import Db, open_db
from .log import get_logger
from .models import ContentItem
from .repo import SupplierConfig

log = get_logger(__name__)
HOST = socket.gethostname()
COMMIT_EVERY = 50                  # cCommitEvery din PriceListContentTransferUnit
IMAGE_COMMIT_EVERY = 20            # coduri cu imagini (blob-uri mari) per tranzactie
MAX_ERRORS = 20


@dataclass
class ContentSummary:
    supplier_id: int
    name: str
    status: str = "OK"
    n_items: int = 0
    n_desc_written: int = 0         # descrieri noi / schimbate in staging
    n_img_lists_changed: int = 0    # coduri cu lista de URL-uri noua / schimbata
    n_img_pending: int = 0          # coduri cu imagini de descarcat acum
    n_img_deferred: int = 0         # coduri nedescarcate care nu trebuie acum (nelegate / produsul are imagini)
    n_img_saved: int = 0            # imagini descarcate si salvate
    n_img_failed: int = 0           # coduri fara nicio imagine descarcata (raman pentru rularea urmatoare)
    bytes_in: int = 0
    n_pairs: int = 0                # coduri legate de un produs, trecute prin SP_PI_CONTENT_TRANSFER
    n_goods_images: int = 0         # produse care au primit imagini
    n_images_copied: int = 0
    n_desc_copied: int = 0
    stopped: bool = False           # termenul s-a terminat in timpul descarcarii
    errors: list[str] = field(default_factory=list)
    duration_sec: float = 0.0

    def counts(self) -> dict[str, Any]:
        return dict(n_items=self.n_items, n_desc_written=self.n_desc_written,
                    n_img_lists_changed=self.n_img_lists_changed, n_img_pending=self.n_img_pending,
                    n_img_deferred=self.n_img_deferred, n_img_saved=self.n_img_saved,
                    n_img_failed=self.n_img_failed, bytes_in=self.bytes_in,
                    n_pairs=self.n_pairs, n_goods_images=self.n_goods_images, n_images_copied=self.n_images_copied,
                    n_desc_copied=self.n_desc_copied)


def _sha(text: str) -> bytes:
    return hashlib.sha256(text.encode("utf-8")).digest()


def desc_changed(item: ContentItem, state: tuple[bytes, bytes, str | None] | None) -> bool:
    if state is None:
        return True
    h_ro, h_ru, category = state
    return ((item.desc_ro is not None and _sha(item.desc_ro) != h_ro)
            or (item.desc_ru is not None and _sha(item.desc_ru) != h_ru)
            or (item.category is not None and item.category != (category or "")))


def plan_staging(contents: list[ContentItem], desc_state: dict, image_lists: dict[str, tuple[list[str], bool]]
                 ) -> tuple[list[ContentItem], list[ContentItem], dict[str, list[str]]]:
    """(descrieri de scris, liste de URL-uri de rescris, cod -> URL-uri de descarcat).
    Un furnizor fara text / fara imagini nu sterge ce e deja in staging (ca in Delphi)."""
    descs, lists, pending = [], [], {}
    for item in contents:
        if item.has_description() and desc_changed(item, desc_state.get(item.code)):
            descs.append(item)
        if not item.images:
            continue
        old_urls, old_pending = image_lists.get(item.code, ([], False))
        if old_urls != item.images:
            lists.append(item)
            pending[item.code] = item.images
        elif old_pending:
            pending[item.code] = old_urls
    return descs, lists, pending


def content_suppliers(db: Db, supplier_ids: list[int] | None = None) -> list[SupplierConfig]:
    if supplier_ids:
        found = [repo.load_supplier(db, sid) for sid in supplier_ids]
        return [s for s in found if s is not None]
    return [s for s in repo.load_suppliers(db)
            if s.adapter_code in ADAPTERS and ADAPTERS[s.adapter_code].has_content]


def _fetch_contents(settings: Settings, db: Db, supplier: SupplierConfig, summary: ContentSummary
                    ) -> list[ContentItem]:
    adapter = get_adapter(supplier.adapter_code)
    if not adapter.has_content:
        raise AdapterError("CONFIG", f"adaptorul {supplier.adapter_code} nu are continut")
    iso, _ = repo.load_currencies(db)
    ctx = RunContext(settings=settings, supplier=supplier, db=db, params=load_supplier_yaml(settings, supplier.supplier_id),
                     currency_ids=iso, progress=lambda msg: log.info("progress", content=supplier.supplier_id, msg=msg))
    fetch = adapter.fetch(ctx)
    db.commit()
    products = json.loads(fetch.raw_payload or b"[]")
    contents = []
    for item in fetch.items:
        index = (item.row_no or 0) - 1
        if 0 <= index < len(products):
            content = adapter.content_of(products[index], item.code)
            if content is not None:
                contents.append(content)
    summary.n_items = len(fetch.items)
    return contents


def _download(settings: Settings, db: Db, supplier_id: int, pending: dict[str, list[str]],
              summary: ContentSummary, deadline: float | None, fetcher: ImageFetcher | None = None) -> None:
    own = fetcher is None
    fetcher = fetcher or ImageFetcher(settings.http_connect_timeout, settings.http_read_timeout)
    written = 0
    pool = ThreadPoolExecutor(max_workers=max(1, settings.content_threads), thread_name_prefix="pi-img")
    try:
        futures = [pool.submit(fetcher.fetch_code, code, urls) for code, urls in sorted(pending.items())]
        for future in as_completed(futures):
            if future.cancelled():
                continue
            result = future.result()
            summary.bytes_in += result.bytes_in
            if result.n_ok:
                repo.replace_code_images(db, supplier_id, result.code, result.urls, result.images)
                summary.n_img_saved += result.n_ok
                written += 1
                if written % IMAGE_COMMIT_EVERY == 0:
                    db.commit()
            else:
                summary.n_img_failed += 1
            for error in result.errors:
                if len(summary.errors) < MAX_ERRORS:
                    summary.errors.append(f"{result.code}: {error}")
            if deadline is not None and time.monotonic() > deadline and not summary.stopped:
                summary.stopped = True
                for f in futures:
                    f.cancel()
        db.commit()
    finally:
        pool.shutdown(wait=True, cancel_futures=True)
        if own:
            fetcher.close()


def _transfer(settings: Settings, db: Db, supplier_id: int, codes: list[str], summary: ContentSummary) -> None:
    linked = repo.linked_codes(db, supplier_id)
    for n, code in enumerate(sorted(c for c in set(codes) if c in linked), start=1):
        goodsid, images, descriptions = repo.content_transfer(db, supplier_id, code, settings.wms_user_id)
        if goodsid is not None:
            summary.n_pairs += 1
        if images:
            summary.n_goods_images += 1
            summary.n_images_copied += images
        summary.n_desc_copied += 1 if descriptions else 0
        if n % COMMIT_EVERY == 0:
            db.commit()
    db.commit()


def run_supplier_content(settings: Settings, supplier: SupplierConfig, *, dry: bool = False, download: bool = True,
                         transfer: bool | None = None, trigger: str = "MANUAL", deadline: float | None = None,
                         fetcher: ImageFetcher | None = None) -> ContentSummary:
    started = time.monotonic()
    summary = ContentSummary(supplier.supplier_id, supplier.name)
    transfer = settings.content_transfer if transfer is None else transfer
    with open_db(settings) as db:
        run_id = None
        if not dry:
            if not repo.has_table(db, "TPI_CONTENT_RUN"):
                raise RuntimeError("lipseste TPI_CONTENT_RUN (DB Model/price_import_stage4b.sql)")
            run_id = repo.insert_content_run(db, supplier.supplier_id, trigger, HOST)
            db.commit()
        try:
            contents = _fetch_contents(settings, db, supplier, summary)
            descs, lists, pending = plan_staging(contents, repo.content_desc_state(db, supplier.supplier_id),
                                                 repo.content_image_lists(db, supplier.supplier_id))
            summary.n_desc_written, summary.n_img_lists_changed = len(descs), len(lists)
            if not settings.content_download_all:
                needed = repo.codes_needing_images(db, supplier.supplier_id)
                summary.n_img_deferred = sum(1 for code in pending if code not in needed)
                pending = {code: urls for code, urls in pending.items() if code in needed}
            summary.n_img_pending = len(pending)
            if dry:
                db.rollback()
                summary.status = "DRY_RUN"
            else:
                for item in descs:
                    repo.upsert_content_desc(db, supplier.supplier_id, item.code, item.desc_ro, item.desc_ru,
                                             item.category)
                for item in lists:
                    repo.replace_code_images(db, supplier.supplier_id, item.code, item.images)
                db.commit()
                if download and pending:
                    _download(settings, db, supplier.supplier_id, pending, summary, deadline, fetcher)
                if transfer:
                    repo.set_session_user(db, settings.wms_user_id)
                    _transfer(settings, db, supplier.supplier_id, [c.code for c in contents], summary)
                summary.status = "PARTIAL" if (summary.stopped or summary.n_img_failed) else "OK"
        except Exception as exc:            # noqa: BLE001 - un furnizor cazut nu le opreste pe celelalte
            db.rollback()
            summary.status = "ERROR"
            summary.errors.insert(0, f"{type(exc).__name__}: {exc}")
            log.exception("content_failed", supplier=supplier.supplier_id)
        summary.duration_sec = time.monotonic() - started
        if run_id is not None:
            repo.finish_content_run(db, run_id, summary.status, error_text="; ".join(summary.errors[:5]) or None,
                                    **summary.counts())
            db.commit()
    log.info("content_done", supplier=supplier.supplier_id, status=summary.status, **summary.counts())
    return summary


def run_content(settings: Settings, supplier_ids: list[int] | None = None, *, dry: bool = False,
                download: bool = True, transfer: bool | None = None, trigger: str = "MANUAL",
                max_minutes: int | None = None) -> list[ContentSummary]:
    minutes = settings.content_max_minutes if max_minutes is None else max_minutes
    deadline = time.monotonic() + minutes * 60 if minutes > 0 else None
    with open_db(settings) as db:
        suppliers = content_suppliers(db, supplier_ids)
        db.commit()
    return [run_supplier_content(settings, s, dry=dry, download=download, transfer=transfer, trigger=trigger,
                                 deadline=deadline) for s in suppliers]


def format_summary(s: ContentSummary) -> str:
    text = (f"{s.name} ({s.supplier_id}): {s.status} - {s.n_items} pozitii; staging: {s.n_desc_written} descrieri, "
            f"{s.n_img_lists_changed} liste de imagini noi/schimbate; imagini: {s.n_img_pending} coduri de "
            f"descarcat ({s.n_img_deferred} amanate), {s.n_img_saved} salvate, {s.n_img_failed} coduri esuate, {s.bytes_in / 1e6:.1f} MB; "
            f"la produse: {s.n_images_copied} imagini ({s.n_goods_images} produse), {s.n_desc_copied} descrieri "
            f"({s.n_pairs} coduri legate); {s.duration_sec:.0f} s")
    if s.stopped:
        text += "; oprit la termen"
    return text


def report_text(summaries: list[ContentSummary]) -> str:
    lines = ["<b>PriceImport - continut</b>"]
    for s in summaries:
        lines.append(html.escape(format_summary(s)))
        if s.status == "ERROR" and s.errors:
            lines.append("  " + html.escape(s.errors[0][:300]))
    return "\n".join(lines)
