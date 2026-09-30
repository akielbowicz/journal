
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

### 2026-09-29 19:19 — snap
- Two tickets shipped + a Ro5 review sweep, all pushed to main (b48185b): Ro5 over bc39f9d..main (merge modify/delete false-clean fixed, deletion blast radii, CRLF-safe rename, no-base merge warning, CHANGELOG #59) → specodelic-ag5 (corpus discovery: bare lint/graph name the openspec/ tree, doctor corpus-discovery check, CHANGELOG #60) → specodelic-15g (Option A user-approved: bare row refs resolve in id:spec files in both lint+graph, typing violations on bare refs visible, coverage message truthful, CHANGELOG #61).
- Decisions of record on both tickets: ag5 = option b+c (configured corpus path deferred); 15g = Option A (dotless own-row refs; dotful keep gh#5 hint; unknown bare stay metasyntactic). All gates green each ship (just ci, lint-specs 18/0, graph 0 dangling, openspec strict 9/9). Follow-up filed: specodelic-xx1 (P3, verify --timeout-secs).
- **Next:** specodelic-9m4 (P1 HITL) awaits the USER's approval of add-observability-contracts (blocks 7l3); ready P2s: b15 (lint rule completion), c32 (spk migrate), vv8 (conformance suite). Resume via /renew.

### 2026-09-29 20:29 — snap
- add-graph-views openspec change created, Rule-of-5 reviewed twice, READY at approval gate (openspec/changes/add-graph-views/): `spk graph --format edges` TSV + violations-annotated rows + `spk guide --json` (new subcommand) + scripts/graph_views.py mermaid views; build-time-only rendering into docs/src/views/
- 3 tickets filed+reviewed (issue-review, READY_TO_WORK): specodelic-x30 (contract-wiring checker spike — spec-level interface impedance from declared edges), specodelic-5qj (declared-dataflow wiring view spike, re-anchored to `spk graph -j`), bajan-ac8 in bajan repo (type prose wiring into structured rows). All metadata.files + base_commit anchored, meters appended, pushed
- User decision: intended (declared) dataflow is sufficient — vampiro source-level integration explicitly out of scope
- Note: concurrent session landed specodelic-b15 (03f0f33, five lint rules) — src/lint.rs mystery resolved
- **Next:** user approves add-graph-views → start tasks 1.1 RED (CLI tests for --format edges contract); x30/5qj spikes can run in parallel (independent)

### 2026-09-29 20:30 — snap: observability approved (9m4) + b15 lint totality landed (03f0f33)
- specodelic-9m4 approved+closed (decision of record commented): add-observability-contracts greenlit as proposed — observes typing (specodelic.md Rev 8 / kinds.md Rev 5, D3 general-rule reconciliation), advisory-only linter.observability (gating/waivers deferred to follow-up changes), boundaries derived not tagged, observes acyclic-exempt. 7l3 unblocks (still gated on b15 + cxq).
- specodelic-b15 (in_progress, TDD red→green, commit 03f0f33): 5 lint rules landed — every_state_used, every_transition_valid (model_shape remainder), no_self_ref, acyclic (traces_to∪derives_from∪guard-as-edge, self-loops = no_self_ref's beat, rotation-normalized dedup), single_root_reachable (UNDIRECTED connectivity to SOME intent over traces_to/derives_from/guard/from-to/emits; outbound-only would flag every non-emitting state; mp1 row 8 owns any-vs-own tightening).
- TYPING DECISION: ref_kind_compatible stays GRAPH-layer-owned (graph.rs labeled violations + non-zero exit); lint does not duplicate (double-report + pre-decides mp1 rows 7-9). graph-shape rules live in lint because linter-graph_shape.md owns them and neither layer enforced them before.
- Dogfood: specs/ 18 files 0 findings; openspec tree 0 after faithful bridges (hooks capability guards got typed citations appended to prose — typing-table-faithful, mp1 row 7 may revisit; model-check no_fabrication traces_to = [[spec]] beside prose pointer; spk new scaffold now ships connected minimal loop c1/t1/p1 — placeholder island previously). CHANGELOG #62. just ci green, pushed 03f0f33.
- Pre-existing discovery: CI on main was already red before b15 — openspec-validate leg exits 127 (openspec binary not installed in the GH runner). NOT fixed this session — verify/separate ticket when next on CI.
- external_completeness NOT implemented: checklist manifest format = Needs Human Review (checker file's own Notes) → filed as mp1 row 10 (dedicated *.checklist.md convention with item list + item/status/mapped_ids/rationale mapping table is the candidate sketch). b15 stays open for that leg.
- **Next:** mp1 HITL rows 7-10 (guard typing, reachability target, kinds field-set, checklist format) — or claim b15's remaining leg after row 10; then cxq corpus reconciliation, then 7l3 (observability implementation). Resume via /renew.

### 2026-09-29 21:37 — snap
- Specced error handling for the corpus: investigated gap (output contract in CHANGELOG #48 unspecced; mute `failed` states; untyped `¬x_ok.guard` guards), scaffolded openspec change `add-error-contract` (proposal, design D1–D7+D2a, dual-format delta — validate --strict green, sync-sections green, `just lint-specs` green)
- Two Rule-of-5 passes folded in: graph-decidable failure-class rule (D2a), 3-tier enforcement routing (`enforcement_routed`), namespaced labels `<file-id>.<variant_head>`, all capability rows → invariant (published extension_points live only in errors.md), orchestrate carve-out made a checked list
- Issue review pass: created HITL approval gate `specodelic-d53` and dep'd `specodelic-uie` on it (uie no longer falsely READY); set metadata.files + base_commit on uie/xx1; filed COORDINATION note — uie ∩ cxq ∩ mp1 guard-typing sequencing still needs the maintainer's call
- **Next:** maintainer approves/rejects via `specodelic-d53`; decide uie↔cxq↔mp1 guard-typing ordering before phase 2 touches guard rows; then implement `add-error-contract` phase 1 (specs/errors.md + per-error properties, RED graph fixtures first). Nothing committed yet — openspec/changes/add-error-contract/ is uncommitted work.
### 2026-09-30 14:12 — snap
- Shipped specodelic-8kk end-to-end: `spk orchestrate` drives parse → lint → compile → model_check → verify per specs/orchestrate.md (cdd81bf). lint_one split into per-checker family slices + pub per-checker invocations so dependents of a failed checker are never invoked (skipped with reason, independent branches report). coverage-only compile gate; model_check stage passes only on no_counterexample (native exploration_only honestly fails). Ro5 review (converged stage 4, EDGE-001 TypeSafe-verified @ 0.97) fixed: checklist-only corpus no longer vacuously succeeds (exit 2), parse gate reads structured parse_errors (ParseInput) not note prose, transitive skip reasons carry dependency's real status (6ca2315).
- mp1 row 4 HITL DECIDED (user): orchestrator stays scoped to parsed → verified — parsing outside orchestrate.md's Model; decision of record in specs/orchestrate.md Notes + CHANGELOG #70; specodelic-8kk CLOSED (1e6cc24). Coverage gap filed: constraint_kind_closed/property_kind_closed as lint rules (P3 bead).
- Gates all green throughout; pushed through 1e6cc24; main in sync; beads: 8kk closed, mp1 rows 1-3/5-9 still open.
- **Next:** claim mp1 rows (HITL decisions) or next feature bead: specodelic-5qj (dataflow view), uie (error contract), 8kk-done → 3l7/vv8 also open. Resume via /renew.

### 2026-09-30 16:10 — snap
- Terminology disambiguation shipped (commit 933c968, ticket specodelic-clf closed): project vs format vs tool (`spk`) vs subject, USAGE.md §0; fixed specodelic.md:12 self-reference sentence and STATUS.md §1 definition.
- Built resume/checkpoint domain spec at /tmp/resume-specs/batch-resume.md — lint/compile/orchestrate-verified; derived parallelism via law rows (monoid ⇒ chunked reduce, semilattice manifest ⇒ concurrent checkpointing); Rule-of-5 fixes applied: map/reduce split, process_is_deterministic, emits_survive_replay (12 constraints / 14 properties, full coverage). /tmp is volatile — promote it somewhere durable.
- Decision: one format change is warranted — named law cases (associativity/identity/commutativity/idempotence) made machine-checkable; everything else stays convention (no ## Operations section, no new property kinds). Plan filed as ticket specodelic-9qw.
- **Next:** fresh session → `bd ready`, claim specodelic-9qw, scaffold openspec change `update-law-named-cases` (confirm owning capability via `openspec spec list`; validate --strict; approval gate before implementation; dual-format archive recipe at archive time).
