import logging

from priceimport.log import SecretMaskFilter, mask_secrets, setup_logging


def test_mask_secrets():
    assert mask_secrets("GET /products?api_token=abc123&page=2") == "GET /products?api_token=***&page=2"
    assert mask_secrets("password=x token=y") == "password=*** token=***"


def test_library_log_records_are_masked():
    record = logging.LogRecord("httpx", logging.INFO, __file__, 1, 'HTTP Request: GET %s "%s"',
                               ("https://h/p?api_token=SECRET&page=1", "HTTP/1.1 200 OK"), None)
    SecretMaskFilter().filter(record)
    assert "SECRET" not in record.getMessage() and "api_token=***" in record.getMessage()


def test_httpx_info_is_silenced(tmp_path):
    setup_logging(tmp_path)
    assert logging.getLogger("httpx").getEffectiveLevel() == logging.WARNING
    logging.getLogger("other").info("url?api_token=SECRET")
    for handler in logging.getLogger().handlers:
        handler.flush()
    assert "SECRET" not in (tmp_path / "priceimport.log").read_text(encoding="utf-8")
    logging.basicConfig(force=True, handlers=[logging.NullHandler()])
