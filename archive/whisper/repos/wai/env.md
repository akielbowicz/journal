# wai — repo environment notes

## docs/cartography (2026-09-02)

- Cartography reports live in `docs/cartography/`: 12 markdown artifacts of record + self-contained HTML views + `index.html` + `assets/` (vendored `mermaid.min.js` v9.4.3 IIFE, shared `cartography.css`).
- Regeneration path is re-running the codebase-cartography skill — there is deliberately NO build pipeline or render script (skill v0.8.0 invariant; a pandoc-based `scripts/render-cartography.sh` existed briefly and was deleted as superseded).
- Reports are evidence snapshots: counts (fan-in, file sizes, check counts) drift with `src/`; every claim carries file:line so drift is visible on re-run.
