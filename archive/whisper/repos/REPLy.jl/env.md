# REPLy.jl — Durable Knowledge

## Governance Framework (established 2026-08-01)

Value-alignment governance artifacts live in the repo root and docs/src:

| Artifact | Location |
|----------|----------|
| **GOVERNANCE.md** — BSD + Agent Charter | repo root |
| **Falsifiable Value Proposition** | `docs/src/value-proposition.md` |
| **VRR Agenda Template** | `docs/src/vrr-agenda.md` |
| **Alignment Vocabulary** | `.wai/resources/ubiquitous-language/contexts/alignment.md` |

### Value Proposition

> REPLy.jl will enable **Julia tool builders** to **ship** **structured REPL interaction into their editors, IDEs, and MCP servers** by **cutting integration time from days to minutes** within **the first development session**, as measured by **time-to-first-successful-eval for a new client**, compared to **building directly on Sockets.jl or adapting RemoteREPL.jl**.

### Invariant Chain

BSD §3 prohibitions → `mcp_check_dangerous_patterns()` in `src/mcp/server.jl` → `safety dispatch` tests in `test/unit/mcp_adapter_test.jl`

13 dangerous eval patterns are enforced: `run()`, `pipeline()`, `write()`, `open(; write)`, `download()`, `HTTP.request()`, `rm()`, `rmrf()`, `mv()`, `cp()`, `mkpath()`, backtick execution via `readchomp`, backtick execution via `read`. Override with `allow_unsafe=true`.

### Open Tickets

- `REPLy_jl-zwe4` (P3): Schedule quarterly VRR — first due 2026-10-29
- `REPLy_jl-lhxk` (P2): Pre-v1.0 security audit
- `REPLy_jl-plqj` (P3): Decay detection dashboard

### Pre-existing

- `build_test.jl` has 3 pre-existing failures (Scratch.jl paths — unrelated to governance work)
- BSD §4 irreversible-action guard (shutdown doesn't wait for in-flight evals) is partial