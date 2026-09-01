# Tray.jl — environment notes

## Repo
- `~/para/areas/dev/gh/sk/Tray.jl`
- Julia 1.12+, ReTestItems, Supposition.jl, Documenter.jl

## Tools
- pretender (gate mode) — structural code quality, runs in CI
- testaruda — test selection, Julia adapter
- espectacular (ah) — spec-test contracts
- beads (bd) — issue tracking
- wai — research/rationale tracking
- openspec — change proposals
- replyc — inline Julia evaluation (REPLy.jl server)

## Key targets
- `just test` — full test suite
- `just test-file "pattern"` — focused @testitem blocks
- `just pretender-check` — code quality scan
- `just ci` — full CI pipeline

## Project state
- 73/73 issues closed, all epics complete
- 46 Espectacular contracts
- v0.2.0 released (first release)