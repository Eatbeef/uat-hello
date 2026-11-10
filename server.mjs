// uat-hello: the dummy UAT app for the B5 dry run and the G7 abuse-case runs (B5 plan U-1).
// No dependencies. Binds loopback only; Tailscale Serve on UAT-01 fronts it (plan §10.2 #15).
import { realpathSync } from "node:fs";
import { createServer } from "node:http";
import { fileURLToPath } from "node:url";

export const VERSION = "1";

export function handler(req, res) {
  const headers = { "content-type": "text/plain; charset=utf-8", "cache-control": "no-store" };
  if (req.method !== "GET" && req.method !== "HEAD") {
    res.writeHead(405, headers).end("method not allowed\n");
  } else if (req.url === "/healthz") {
    res.writeHead(200, headers).end("ok\n");
  } else if (req.url === "/") {
    res.writeHead(200, headers).end(`uat-hello v${VERSION}\n`);
  } else {
    res.writeHead(404, headers).end("not found\n");
  }
}

// On UAT-01 the unit starts /srv/apps/uat-hello/current/app/server.mjs through the `current` symlink, while
// import.meta.url is the resolved path: compare real paths.
if (process.argv[1] && realpathSync(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const port = Number(process.env.PORT ?? "8080");
  createServer(handler).listen(port, "127.0.0.1");
}
