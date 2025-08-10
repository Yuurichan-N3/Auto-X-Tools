#!/usr/bin/env bash
set -euo pipefail
mkdir -p logs
ts="$(date +%Y%m%d-%H%M%S)"
[ -f logs/run.log ] && mv logs/run.log "logs/run-$ts.log" || true
touch logs/run.log && echo "[rotate] $ts" >> logs/run.log
