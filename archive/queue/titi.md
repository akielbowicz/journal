# Queue: titi

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-27 21:08 — titi

- Ran a Universal Rule-of-5 review of the full titi openspec suite (11 specs + 2 active changes) → committed fixes across 13 files (`a2ad472`): resolved CRITICAL cache-path conflict in `add-test-item-detection`, added `.csproj`-set-diff invalidation to graph-cache GC-04, fixed misplaced MODIFIED DG-06 delta, added `diagnostics`+`cli` deltas for E011/exit-codes 10&20, added E014 `VERSION_PARSE_INVALID`, inlined TIA-* contracts into the testaruda adapter CLI-19, added Phasing section to project.md, plus ~20 MEDIUM/LOW fixes.
- Fixed blocking feasibility gaps (`40329d4`): testId→`--filter` FullyQualifiedName derivation + parameterized-row fallback in CLI-06, `.jls`→`.edn` for run history, handshake-failure ordering for CLI-19. Created 15 `bd` issues (2 epics + blockers + 8 test-item-detection tasks).
- Reviewed testaruda (v0.2.3, `34e8db6`) source: resolved both titi adapter blockers — Decision 2 (long-lived process confirmed via `AdapterIO::spawn`), Decision 4 (whole-repo `static-deps` confirmed via store's hardcoded `component="default"`). Bumped titi's testaruda pin v0.2.0→v0.2.3, updated inlined TIA-ADAPT-012, closed `bd` `titi-euu`/`titi-7qw`, escalated `titi-co9` to P0 (`d12b58a`).
- Created testaruda-side change `add-dotnet-adapter-detection` (TIA-ADAPT-023 .NET adapter + TIA-ADAPT-024 shell-split core change that unblocks Julia too). Rule-of-5 reviewed and fixed all findings: added `.cs`/`.fs`/`.vb` to extension mappings (CRITICAL — source changes must route to titi), split shell-split into its own requirement, cited all 5 spawn sites, picked `shell-words`, added polyglot/empty-string/Windows-path edge scenarios, added `design.md`. Pinned `runtime_edges=false` in titi CLI-19 for cross-repo handshake agreement.
- Committed & pushed both repos: titi `f8147a7`, testaruda `dae6fd9` (charly's repo `cv:charly-vibes/testaruda`, main).
- **Next:** `add-test-item-detection` epic (`titi-022`) is unblocked and ready — start with `bd ready` → claim `titi-976` (TID-1 domain types). The `add-testaruda-adapter` epic (`titi-dik`) remains gated on `titi-co9` (external testaruda-side implementation of `add-dotnet-adapter-detection`, now specced & pushed for charly to implement). SEQ-1 (`titi-2bz`, TRX-parser ownership ordering) and the .NET 10 `--list-tests` JSON verification (`titi-or6`) are open coordination/verify items.

---

## 2026-07-27 19:33 — titi

- Created `add-test-item-detection` OpenSpec change: test-item-level detection, test-to-source edges, safety invariants, coverage ingestion — fills the gap between titi's project-level TIA and the per-test patterns from testaruda/Testimonial.jl
- Applied 5 spec deltas across domain-model, dependency-graph, cli, configuration, and new test-detection capability (26 requirements, 21 parsed deltas)
- Ran Rule of 5 universal review: found 18 issues (0 critical, 6 high); fixed all — origin label, VSTest .NET 10 syntax, parameterized tests, framework-aware filter, cache path unification, run-history retention, Cobertura correlation docs
- This change is a prerequisite for `add-testaruda-adapter`'s deferred Phase 2
- **Next:** either implement Phase 1 tasks (1.1–1.8 domain types) or advance `add-testaruda-adapter`'s blocking decisions

---
