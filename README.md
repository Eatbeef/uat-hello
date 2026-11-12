# uat-hello (B5 plan U-1)

The dummy UAT app for the release-path dry run and the G7 abuse-case runs. Steve creates
**`Eatbeef/uat-hello` as a public repository** (it holds nothing private; see `deploy/controller/README.md`,
"Repository access") and copies these files to its root.

- `server.mjs`: `node:http`, no dependencies, `127.0.0.1:$PORT` (default 8080). `GET /healthz` → `ok`,
  `GET /` → `uat-hello v1`, anything else 404, other methods 405.
- `uat/build.sh`, `uat/test.sh`: the controller's app contract.

On UAT-01 (B5-6c): `deploy/uat01/apps/uat-hello.conf` (port 8080, `/healthz`, `server.mjs`) gives the unit
`uat-hello.service` and the uat-receive config; Tailscale Serve 443 fronts it (runbook phase 14).
ac13 2026-11-12T14:13:05.8248642+08:00
ac17 2026-11-12T15:15:28.5223359+08:00
