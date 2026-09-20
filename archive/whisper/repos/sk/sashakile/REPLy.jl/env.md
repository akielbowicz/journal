

## Migrated from REPLy.jl

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

## Multi-Version Julia Testing (learned 2026-09-17)

- Root + `test/Manifest.toml` are gitignored; CI resolves fresh per version. For local multi-version testing use `JULIA_DEPOT_PATH=/tmp/<ver>depot` isolated depots and `rm` both manifests first (fresh resolve per version).
- **Gotcha:** instantiating a 1.12-resolved Manifest under 1.10 pulls PrecompileTools 1.3.x, which fails to load on 1.10 (`UndefVarError: StaticData` — needs `Base.StaticData`, absent ≤1.11). A fresh 1.10 resolve picks PrecompileTools 1.2.x. Upstream v1.3.4 still unfixed.
- **Gotcha:** 1.10's `Pkg.test` sandbox errors "can not merge projects" if a local `test/Manifest.toml` exists (path-fixed REPLy dev entry collides during merge). Never present in CI.
- 1.10 test-compat patterns (fixed in suite): `isexecutable` shim (Base 1.11+); Revise mock injected as plain (non-const) global; clone const-reassignment asserted per-version — 1.10 silently ignores it (#56933).
- Transient Julia 1.13 precompile race on first depot population: `Zstd_jll`/`PCRE2_jll` "not available with flags CacheFlags(debug_level=1)". Clears once stdlibs compiled once; never reproduced after.

## CI Notes (learned 2026-09-17)

- Matrix covers Julia 1.10 / 1.12 / 1.13; coverage + Codecov gated to the 1.12 leg.
- actionlint pinned to v1.7.12: `@latest` (main) depends on go-json-experiment which no longer compiles against stable Go (`json.SkipFunc` removed). Recheck when bumping.
- lefthook is NOT installed in CI (only needed locally for git hooks via `just hooks`); it also broke CI the same way.
- Pre-push hook runs `just test` (~3–4 min) — expect slow pushes.
- `aek-analysis/` (local audit output, untracked) is excluded in `_typos.toml`; typos pre-commit fails on it otherwise.

## Launcher (replyc)

- `~/.julia/bin/replyc` + its UUID-namespaced scratch env are rebuilt by `Pkg.build("REPLy")`. The build tests now rebuild when the launcher is missing, built by a different Julia version, OR its pinned `--project` dir is missing (stale-launcher self-heal). Last Julia run wins the launcher pin.
