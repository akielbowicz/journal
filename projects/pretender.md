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

- [ ] pretender-15w — gate exit-code enforcement (advisory stays default; runnable-meter acceptance)
- [ ] pretender-u8a — stable finding IDs + resolution-rate metric (computable kill-criterion)
- [ ] pretender-dj5 — persistent gate findings → bd tickets (blocked on u8a)
- [ ] refresh PATH-installed pretender binary (`cargo install --path pretender`)
- [ ] (optional) `bd dolt remote remove origin` to silence broken dolt push in no-db mode

## Notes

- Anti-goal on rule work: thresholds/config must stay byte-identical; noise
  drops must come from parser/rule-scope fixes only (verified via git diff).
- Rule semantic changes require an openspec proposal first (project constraint).
- pi-session evidence base for adoption metrics: `~/.pi/agent/sessions/`
  (2,701 `pretender check` occurrences across 156 session files as of 09-20).
