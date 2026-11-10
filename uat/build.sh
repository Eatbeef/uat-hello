#!/usr/bin/env bash
# uat-hello build (the contract with uat-build.yml): write the release files into $UAT_OUT.
# Everything written there ships under app/ on UAT-01. Regular files only.
set -euo pipefail
: "${UAT_OUT:?UAT_OUT must be set}"
install -m 0644 server.mjs package.json "$UAT_OUT/"
