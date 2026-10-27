from datetime import datetime

from helpers import RATES, gf, item, supplier

from priceimport.config import Settings
from priceimport.coordinator import RunOutcome
from priceimport.diff import diff_against_gf
from priceimport.models import RowError, RunStatus, Severity
from priceimport.report import TELEGRAM_LIMIT, build_message, write_xlsx
from priceimport.thresholds import apply_thresholds
from priceimport.windows import order_suppliers, plan_window


def outcome(n=3, name="ACCENT <&>", status=RunStatus.DRY_RUN):
    items = [item(f"C{i}", p7=100 + i, name=f"Laptop {i} & co", category=f"Cat {i % 9}") for i in range(n)]
    items += [item(f"N{i}", category=f"Nou {i % 12}") for i in range(n)]
    state = {f"C{i}": [gf(f"C{i}", i, p7=100)] for i in range(n)}
    state["G"] = [gf("G", 999)]
    d = diff_against_gf(items, state, prev_codes=set(), exclusions=set(), noise_pct=0.5, gone_after_runs=2,
                        rates=RATES)
    apply_thresholds(d.changes, supplier(), [], {}, RATES)
    return RunOutcome(supplier=supplier(name=name), status=status, run_id=7, diff=d, n_valid=len(items),
                      duration_sec=12.3, plid=6100)


def test_message_escapes_and_lists_sections():
    text = build_message("Pricelisturi · 27.10", [outcome(30)])
    assert "ACCENT &lt;&amp;&gt;" in text and "<&>" not in text
    for marker in ("Produse noi nelegate", "Top creșteri", "Carantină", "Ies din pricelist", "RUNID 7"):
        assert marker in text


def test_message_fits_telegram_limit():
    outs = [outcome(800, name=f"Furnizor {i}") for i in range(12)]
    for o in outs:
        o.errors = [RowError("HTTP_5XX", "x" * 300, severity=Severity.CRIT)] * 15
    assert len(build_message("Fereastra 09", outs)) <= TELEGRAM_LIMIT + 20


def test_error_line():
    o = RunOutcome(supplier=supplier(), status=RunStatus.ERROR, run_id=1, error_http=503, error_retries=5,
                   errors=[RowError("HTTP_5XX", "HTTP 503 dupa 5 incercari", severity=Severity.CRIT)])
    text = build_message("t", [o])
    assert "HTTP 503" in text and "5 retry" in text


def test_xlsx(tmp_path):
    path = write_xlsx(tmp_path / "r.xlsx", [outcome(5)])
    assert path.exists() and path.stat().st_size > 1000


def test_plan_and_order():
    settings = Settings()
    plan = plan_window(settings, 1, datetime(2026, 10, 27, 15, 7))
    assert plan.slot == "2026-10-27 15"
    assert plan.soft_deadline == datetime(2026, 10, 27, 15, 40)
    assert plan.hard_deadline == datetime(2026, 10, 27, 15, 55)
    order = order_suppliers([supplier(supplier_id=1, priority=20, est_duration_sec=5),
                             supplier(supplier_id=2, priority=10, est_duration_sec=5),
                             supplier(supplier_id=3, priority=20, est_duration_sec=60)])
    assert [s.supplier_id for s in order] == [2, 3, 1]
