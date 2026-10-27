FROM python:3.12-slim

# clientul Firebird (protocolul e compatibil cu serverul Firebird 5)
RUN apt-get update \
 && apt-get install -y --no-install-recommends libfbclient2 tzdata \
 && rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ=Europe/Chisinau \
    PI_FB_CLIENT_LIBRARY=/usr/lib/x86_64-linux-gnu/libfbclient.so.2 \
    PI_DATA_DIR=/app/data \
    PI_SUPPLIERS_DIR=/app/suppliers

WORKDIR /app
COPY pyproject.toml ./
COPY src ./src
RUN pip install --no-cache-dir .
COPY suppliers ./suppliers

RUN useradd --system --uid 10001 priceimport && mkdir -p /app/data && chown priceimport /app/data
USER priceimport

HEALTHCHECK --interval=60s --timeout=20s --start-period=90s --retries=3 CMD ["pi", "health"]
CMD ["pi", "serve"]
