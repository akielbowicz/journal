
### 2026-09-29 09:46 — snap
- Verified AGENTS.md sibling-tool constraints were prose-only; shipped hook-enforced guards (specodelic-jua, closed, pushed to main): `scripts/guards/sibling-blockers.sh` + `lefthook.yml` (pre-commit/pre-push via .beads/hooks shim chain) + `guard-siblings` in `just ci`; 7 tests in `tests/sibling_blockers.rs`
- Guard blocks: claimed/unset core.hooksPath, non-.sample writes in .git/hooks, espectacular/vampiro wiring in workflows (comment mentions exempt — publish.yml false positive found and fixed live)
- **Next:** nothing pending; if sibling-tool work starts, espectacular adoption still gated on specodelic-4ae decision note, vampiro needs an integration ticket first
