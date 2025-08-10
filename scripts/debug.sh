#!/usr/bin/env bash
set -euo pipefail
echo "[debug] Node: $(node -v)"
echo "[debug] Puppeteer cache: $PUPPETEER_CACHE_DIR"
echo "[debug] running in emulateMobile=false, en-US"
node -e "console.log('ok')"
