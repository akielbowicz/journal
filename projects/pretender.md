# pretender — multi-language code-quality CLI

CLI that flags structural issues (complexity, missing assertions, risky call
patterns) beyond linters, with CI/agent integration. Source:
`para/areas/dev/gh/charly/pretender` (beads tracking, openspec, no-db bd mode).

## Status

- **Noise channel eliminated (2026-09-21)**: pretender-5bw + 68j merged —
  Rust/Julia assertion macros counted and `min_assertions` scoped to
  test-identifying units; self-scan min_assertions events 236 → 0.
- Session value investigation showed adoption (2.7k invocations, 10+ repos)
  but zero findings→fix conversions; the fix loop is now the focus.

## Tasks

- [x] pretender-15w — gate exit-code enforcement (advisory stays default; runnable-meter acceptance) — closed 09-29
- [x] pretender-u8a — stable finding IDs + resolution-rate metric (computable kill-criterion) — closed 09-29
- [x] pretender-5p4 — hook-location doctor check (genesis 0.8.3 effective_hooks_dir) — closed 09-29
- [x] pretender-xgt — --staged/--diff short-circuit format-aware output (JSON/SARIF envelope) — closed 10-01, shipped in v0.8.0
- [ ] pretender-dj5 — persistent gate findings → bd tickets (unblocked: u8a + 15w landed)
- [ ] pretender-2tp — set TAP_GITHUB_TOKEN secret (needs GitHub web UI PAT: contents:write on homebrew-charly + scoop-charly; 3rd manual tap patch this release — PAT makes releases zero-touch)
- [ ] merge 2 dependabot PRs (serde_json 1.0.151, clap 4.6.7) — CI green, landed during v0.8.0 release
- [ ] refresh PATH-installed pretender binary (`cargo install --path pretender`)
- [ ] (optional) `bd dolt remote remove origin` to silence broken dolt push in no-db mode

## Notes

- Released **v0.8.0** (10-01): managed-block provenance + drift doctor check
  (genesis 0.11.1), tree-sitter-rust 0.24 (&raw silent metric-loss fix),
  format-aware --staged short-circuit. crates.io + GH release at 0.8.0;
  tap/scoop patched manually (5585fbf / 5a5227a — token still missing).
- Released **v0.7.1** (10-01): advisory-lease fail-closed diagnostics (GH #35).
- Released **v0.6.0** (09-29): resolution tracking, pre-push hooks, hook-location
  doctor check, genesis 0.8.3. crates.io + GH release + tap/scoop all at 0.6.0
  (tap/scoop patched manually — workflow token missing, see pretender-2tp).

## Notes

- Anti-goal on rule work: thresholds/config must stay byte-identical; noise
  drops must come from parser/rule-scope fixes only (verified via git diff).
- Rule semantic changes require an openspec proposal first (project constraint).
- pi-session evidence base for adoption metrics: `~/.pi/agent/sessions/`
  (2,701 `pretender check` occurrences across 156 session files as of 09-20).
