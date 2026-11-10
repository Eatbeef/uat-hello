#!/usr/bin/env bash
# uat-hello test (the contract with uat-build.yml): test what is in $UAT_OUT, exit non-zero on failure.
set -euo pipefail
: "${UAT_OUT:?UAT_OUT must be set}"
port=$((20000 + RANDOM % 20000))
PORT="$port" node "$UAT_OUT/server.mjs" &
pid=$!
trap 'kill "$pid" 2>/dev/null || true' EXIT
for _ in $(seq 1 50); do
  if body="$(curl -fsS "http://127.0.0.1:$port/healthz" 2>/dev/null)"; then break; fi
  sleep 0.1
done
[ "${body:-}" = "ok" ] || { echo "healthz did not answer ok" >&2; exit 1; }
[ "$(curl -fsS "http://127.0.0.1:$port/")" = "uat-hello v1" ] || { echo "/ wrong" >&2; exit 1; }
code="$(curl -s -o /dev/null -w '%{http_code}' "http://127.0.0.1:$port/nope")"
[ "$code" = "404" ] || { echo "unknown path gave $code" >&2; exit 1; }
echo "uat-hello tests passed"
