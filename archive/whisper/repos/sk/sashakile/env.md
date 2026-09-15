# sk (sashakile workspace) — environment facts

### Usage tracking (2026-09-14/15)
`reports/usage-tracker-sk.py` (adapted from `charly/microdancing/scripts/usage-tracker.py`, sk-only filter) ingests `~/.claude/projects/-var-home-sasha-para-areas-dev-gh-sk*`, `~/.pi/agent/sessions/--var-...-gh-sk*`, and `~/.amp/file-changes` into `reports/data/usage_report_sk.json`. Full caveats live in `reports/data/README.md` — key ones: **Claude encodes dots as dashes in project dir names** (`REPLy-jl` ≡ `REPLy.jl`, alias pairs in the JSON `projects`), `sxAct` is a distinct repo (April, codex-only predecessor of XAct.jl), `cosito` ≠ `cositos`, subscription fees appear only in monthly/daily aggregates (metadata sums hourly), and 11 of 24 repo dirs in gh/sk have zero captured sessions. The markdown summary is a curated snapshot — re-derive its numbers from the JSON if regenerated.

### Workspace layout
`gh/sk` itself is **not a git repo** — it's a folder of independent repos; `sk/reports/` holds cross-project analyses (Aug-03 evaluation suite + usage data) documented via `reports/README.md`.
