
### 2026-09-29 09:46 — snap
- Verified AGENTS.md sibling-tool constraints were prose-only; shipped hook-enforced guards (specodelic-jua, closed, pushed to main): `scripts/guards/sibling-blockers.sh` + `lefthook.yml` (pre-commit/pre-push via .beads/hooks shim chain) + `guard-siblings` in `just ci`; 7 tests in `tests/sibling_blockers.rs`
- Guard blocks: claimed/unset core.hooksPath, non-.sample writes in .git/hooks, espectacular/vampiro wiring in workflows (comment mentions exempt — publish.yml false positive found and fixed live)
- **Next:** nothing pending; if sibling-tool work starts, espectacular adoption still gated on specodelic-4ae decision note, vampiro needs an integration ticket first

### 2026-09-29 16:02 — snap
- Shipped specodelic-7oq: `spk merge` pre-merge check (f5cee52, pushed) — id collisions, rename-replay flags, per-branch blast radii from each tip's own graph artifact, post-union relint gate. 4 integration tests RED→GREEN; docs merge section; CHANGELOG #53.
- Gates green: just ci + lint-specs 18/0 + graph 0 dangling + openspec strict 8/8. specodelic-7oq closed; snap journaled via turu.
- Merge HITL approval semantics (the `resolved` transition) deferred to specodelic-mp1.
- **Next:** claim specodelic-b15 (lint: model_shape, graph_shape, reference typing, external_completeness) or specodelic-7pi (graph edges) — both P2. Resume via /renew.

### 2026-09-29 17:18 — snap
- Investigated format gap (edge interfaces / observability); designed `observes` reference + unobserved-effect advisory + derived boundary classification; Rule-of-5'd both the design and the spec delta (boundary tag dropped for derivation, Constraint-only sources, acyclic-exempt, advisory-first, scope semantics stated)
- Created + pushed openspec change `add-observability-contracts` (proposal/design/tasks + dual-format delta `specs/observability/spec.md`); all gates green (openspec --strict, spk lint, sync-sections)
- Filed + triaged beads `specodelic-7l3` per issue-review: full self-describing description (MUST/METER/ANTI-GOALS/HITL/FILES), metadata.files + base_commit, deps on b15 (reference-typing lint) + cxq (corpus reconciliation), HITL approval gate `specodelic-9m4` (P1) — pushed 68ad4ee
- **Next:** user reviews `openspec/changes/add-observability-contracts/proposal.md` + design.md → `bd close specodelic-9m4` unblocks implementation (b15 & cxq still gate it); implementation = tasks.md phases, red-first
