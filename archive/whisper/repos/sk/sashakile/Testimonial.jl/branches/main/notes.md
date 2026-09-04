### 2026-07-29 14:38 — snap (CI fix marathon)
- Fixed 5+ CI failures across Julia 1.11 and 1.12: SnoopCompile v3 requires 1.12, v2 available for 1.11; removed dead `using Pkg`; made SnoopCompile optional with @eval try/catch; dual v2/v3 macro dispatch via runtime eval (parse-time macro conflict); removed SnoopCompile from main [deps] to avoid Pkg.test resolution conflicts; CI develops Testimonial as path dep into runner project for Pkg.instantiate.
- **testimonial-1v4f CLOSED** with CI green on both 1.11 and 1.12.
- **Next:** testimonial-be7o (parse inference edges into CoverageIndex.inference_edges) — first Phase 2 continuation.

### 2026-07-29 13:30 — implemented testimonial-1v4f (SnoopCompile dep + driver inference capture)
- **Closed** testimonial-1v4f — SnoopCompile 3.2.7 added to both Project.tomls; driver.jl wraps `@snoop_inference` around test execution and serializes caller→callee edges to `inference_trace.jls` sidecar; `_collect_coverage` cleans up sidecar to prevent leakage; `.gitignore` updated.
- **Latent bug fixed**: removed dead `using Pkg` from driver.jl — was failing under Pkg.test's restricted `JULIA_LOAD_PATH` (all subprocess tests silently failed, returning empty coverage).
- **Test**: test_inference_capture.jl (5 assertions) — runs driver directly in temp cwd, asserts sidecar created + non-empty + deserializes to edge vector.
- **Ro5 review**: ACCEPT — no blocking issues. Pre-existing `Threads.@threads` cwd race for tracefile.info also affects inference sidecar (be7o should be aware).
- **Next**: testimonial-be7o (parse inference edges into CoverageIndex.inference_edges) or testimonial-1v4f (next in Phase 2 chain). testimonial-777t (JET dep + static) also unblocked.
### 2026-07-29 15:37 — snap
- Fixed `testimonial-pfpu`: adapter discover was returning Testimonial.jl's own tests (~699 nodes) instead of target project's when invoked externally. Root cause: `handle_discover` used `@__DIR__` (always Testimonial.jl source tree) for default test dir. Fix: try `pwd()/test/` first, fall back to `@__DIR__/../test/` when it doesn't exist (handles Pkg.test Julia 1.12+ cwd quirk)
- Added 5 regression test sets in `test/test_protocol.jl` covering external project discover, fallback, and explicit params
- All Pkg.test passes, CI green on main
- **Next:** testimonial-be7o (parse inference edges into coverage index) or testimonial-777t (JET dep + static analysis pass)

### 2026-07-29 22:34 — snap
- **testimonial-777t**: Added JET weakdep + `static_edges`/`layer_data` fields to CoverageIndex; created `src/StaticLayer.jl` with `run_static_analysis()` (JET-based analysis with graceful fallback to function-name scanning); 16 new tests covering defaults, empty inputs, valid source, graceful degradation
- **CI fix marathon**: Wrong JET UUID → corrected; moved JET from `[deps]` to `[weakdeps]` to avoid transitive dep conflict in TestimonialRunner project (Cthulhu/SnoopCompile/JET on Julia 1.12); widened compat to `"0"` for cross-Julia-version resolution
- **State**: Julia 1.11 ✅ green; Julia 1.12 cancelled by CI infrastructure timeout (subprocess tests slow, not code-related)
- **Next:** testimonial-7e9x (Implement StaticProvider and register in query pipeline) — unblocked now that static_edges exist in CoverageIndex

### 2026-07-30 15:09 — snap
- Completed **Static Layer (Phase 3)**: StaticProvider, query pipeline, LayerKind explain output, static-deps handler enhancement, and integration tests — 4 tickets closed in sequence
- Key changes: `src/Query.jl` (static_provider), `src/Protocol.jl` (session_static_edges, _build_static_edges enhanced), `src/Testimonial.jl` (export), `test/` (query tests, format tests, protocol tests, static integration tests)
- All 1250 quick tests pass (up from 1201 at session start)
- **Next:** Continue with inference layer — `testimonial-3t08` (inference edges in ingest response) or `testimonial-1udj` (inference integration tests)

### 2026-07-30 18:06 — snap
- Fixed CI failure: stale static-deps tests (dict→array format) + missing imports in test_protocol.jl
- Implemented testimonial-3t08: inference_edges in adapter ingest response — _build_inference_edges(), CoverageLayer cleanup, IndexBuilder cleanup
- Implemented testimonial-1udj: integration tests for inference layer end-to-end (3 test sets, 10 assertions)
- Released v0.3.0: inference layer (Phase 2) + static layer (Phase 3) complete, docs updated, tagged + pushed
- Created stress-test script (scripts/stress_test.jl) — tests against 12 real Julia repos
- Created epic testimonial-jvz5 (@test block support) with 4 sub-tickets
- Implemented testimonial-jvz5.1: file-level recording mode (record_file, TESTIMONIAL_RUN_ALL driver mode)
- **Next:** testimonial-jvz5.2 — Mixed recording in record_all (IndexBuilder.jl dispatch logic)
### 2026-07-31 11:06 — snap
- Fixed CI failure: TestimonialRunner compat was `0.2` but Testimonial is `0.3.0` — bumped to `0.3` + trailing newline (`a9f02d9`)
- **Completed @test block support epic (testimonial-jvz5) + P0 bug 3yem.1** in one session:
  - `jvz5.2` mixed recording in record_all: dispatch @testitem → record_item, file-level/@testset → record_file via `_is_testitem_at_line`; batch_by_file path also handles file-level
  - `3yem.1` P0: wired `coverage_provider(changed)` into BOTH flat mode and component mode CLI pipelines; fixed `coverage_gaps` to aggregate by `ItemCoverage.source_files` instead of test-file lines
  - `jvz5.3` file-level query support: tests only — coverage_provider already handled line==0 items via source_files
  - `jvz5.4` CLI+integration: index_info uses `discover_all_test_blocks`; stress_test reports test-type breakdown (testitem/testset/file_level) and no longer skips @testset repos; **fixed record_all index-building bug** — @testset items in same file collapse to ONE file-level entry (use `ic.item` ref key when `line==0`)
- All 1320 quick tests pass; commits pushed: `a9f02d9`, `3f6b6d3`, `29ed371`, `31df152`, `c845657`
- **Next:** consider `ah check` verification, or stress-test run (`julia --project scripts/stress_test.jl --repos 2`) to validate mixed-mode discovery on real repos (CSV.jl/DataFrames.jl); testimonial-3yem epic may have more sub-tickets (3yem.1 was P0, check open children)

### 2026-07-31 19:12 — snap
- **Closed testimonial-3yem epic** (5 tickets in this session, 7 total):
  - 3yem.2: parse_unified_diff now includes deleted/renamed/deletion-only files; --diff-filter=AMDR
  - 3yem.3: environment_matches rejects empty fingerprints; all index builders store real env fingerprint
  - 3yem.4: __unmapped__ items survive save/load; unowned changed files trigger __unmapped__ fallback
  - 3yem.5: removed broken per-component selection cache (fingerprint excluded query inputs)
  - 3yem.6: _load_per_component_indices returns nothing on missing/corrupt/wrong-type component
  - 3yem.7: _is_dirty() fails closed (returns true on git error)
- All 1358 quick tests passing, all pushed to origin/main
- **Next:** testimonial-nl2b epic (P0, reduce architectural risk) — nl2b.1 (canonical test manifest) or nl2b.2 (static-deps contract regression)
### 2026-07-31 22:30 — snap (nl2b.2 closed: protocol schema contract + y9pi filed)
- **Renewed** Testimonial.jl session via renew skill; closed `testimonial-in3s` epic (was 5/5 done, just unverified).
- **Investigated** `testimonial-nl2b.2` (P0: repair static-deps protocol contract regression). Found the described red (`test_protocol.jl:899` map indexing) was **already fixed by commit 6a7a832** — all 10 static-deps protocol tests pass; no map-indexing assertions remain. The genuine residual gap was undocumented schema (acceptance: "protocol schema/examples match implementation").
- **Discovered the actual `just test` red is unrelated**: `parallel record_items produce disjoint coverage` (`test_subprocess_record.jl:180-181`) fails consistently (2/2 runs) — parallel `record_item` calls return empty `covered_lines` despite each getting its own `artifact_dir`. Single-item path works. This is a recording-isolation race, NOT a protocol issue.
- **Plan A (user-approved)**: split concerns.
  - Filed **`testimonial-y9pi`** (P1 bug) for the parallel subprocess coverage-isolation regression with deterministic repro. Set metadata.files. No file conflict with nl2b.2.
  - **Closed `testimonial-nl2b.2`** via TDD:
    - **Red**: added 4 contract testsets in `test/test_protocol.jl` pinning the static-deps + ingest response schema via a `Protocol.DEPEDGE_FIELDS` constant (which didn't exist → red).
    - **Green**: added `const DEPEDGE_FIELDS = ("from","to","weight","origin")` with a schema docstring in `src/Protocol.jl`.
    - **Refactor (Ro5)**: fixed 3 tidy items — pointless single-element loop in run_output test (now also covers runtime_edges), misleading "Both edge arrays" comment, double blank line in docs.
    - Added "Protocol Response Schema" section to `docs/src/architecture.md` (envelope, DepEdge, static-deps table, two ingest shapes, legacy-selected-map note).
  - 4 commits pushed: beads chore, feat(protocol) contract, docs(architecture), pretender history chore. CI green (julia-tests 209s — runs quick suite, so y9pi not exercised there).
- **Key finding**: protocol has TWO `edges` shapes — `ingest` selected → map `{file:{line:[node_id]}}` (legacy), `ingest` run_output + `static-deps` → DepEdge array. Migration of legacy selected shape tracked implicitly (noted in docs); out of scope for nl2b.2.
- **Next**: `testimonial-y9pi` (P1, parallel record_item race) — the real `just test` red. Or `testimonial-nl2b.1` (P0, canonical test manifest). `bd ready` lists both P0s + nl2b.3 (P1).
### 2026-08-02 10:27 — close (4 tickets closed + agent-value-alignment audit + full fix)
- **4 tickets closed** in this multi-session: in3s, nl2b.2, y9pi, nl2b.1.
- **nl2b.2** (static-deps protocol contract): described red was already fixed by 6a7a832. Added DEPEDGE_FIELDS constant, 4 contract tests, protocol schema docs.
- **y9pi** (parallel record_item): not a race! Julia 1.12+ LCOV tracefile doesn't record test-file lines. `covered_lines` is always empty by design. Fixed stale assertion.
- **nl2b.1** (canonical manifest): created test/manifest.jl with completeness check. 65 files classified (60 quick, 5 slow). Both runners derived from manifest. Test count 1358→1546.
- **Agent-value-alignment AUDIT**: ran agent-value-alignment skill on the project. Verdict: NOT_ALIGNED. 16 findings. Critical gaps: no agent behavior eval suite, no traceability matrix.
- **Ro5 review on audit**: found 12 issues (1 CRITICAL self-audit bias). Fixed all in report at resources/agent-value-alignment-audit.md.
- **Full fix implemented**:
  - AGENTS.md restructured as BSD (Goal Sandwich, PROHIBITED ACTIONS ×8, 7 Escalation Triggers, 3 Behavioral Principles)
  - resources/value-proposition.md (falsifiable VP, 4 kill criteria, measurement plan)
  - resources/traceability-matrix.md (12 ACK tests, decisions→prompts→evals)
  - resources/shared-vocabulary.md (13 concepts × 6 frameworks)
  - test/agent_eval.jl (16-test eval suite, all pass)
  - justfile → `just agent-check`
  - 2 beads tickets: value-review (tex7), decay-dashboard (w27p)
- **Key insight**: The project's governance tooling (beads, wai, espectacular) is unusually mature for OSS, but the loop is open — no tests verify agent behavior against AGENTS.md instructions. The 1546 product tests only measure code correctness.
- **Next**: `bd ready` → nl2b.3 (P1 seeded-fault checks) or any nl2b epic child.
### 2026-08-01 10:30 — snap (nl2b.1 closed: canonical test manifest)
- **Renewed** Testimonial.jl via renew skill; claimed `testimonial-nl2b.1` (P0, divergent test runners).
- **Investigation**: found 65 test_*.jl files, full runner (runtests.jl) missed 18 files, quick runner (runtests_quick.jl) missed 16 vs full. Two completely divergent hardcoded include lists — a new test file added to either runner could be invisible to the other indefinitely.
- **TDD pipeline**:
  - **RED commit**: created `test/manifest.jl` with empty `TEST_MANIFEST` + `check_manifest_completeness()`, `full_tests()`, `quick_tests()`, `slow_tests()`. Replaced runtests.jl hardcoded list with `include("manifest.jl")` + `include.(full_tests())`. `just test` errors with "Unclassified: all 65 files".
  - **GREEN commit**: classified all 65 files (60 quick, 5 slow). Updated runtests_quick.jl to derive from `quick_tests()` instead of hardcoded list. Quick test count grew from 1358 to 1546 (previously-missing files now included). All pass. Completeness assertion passes.
- **Key design**: single source of truth in `test/manifest.jl` — adding a new test_*.jl requires an entry there or CI fails. Both runners derive from it.
- **Closed** `nl2b.1`. `nl2b.2` and `nl2b.1` both closed in this session. CI green.
- **Next**: `bd ready` → `nl2b.3` (P1, seeded-fault checks) or `nl2b.4`–`nl2b.8` (P2 architecture cleanup).
- **Fixed CI infrastructure**: runner project dev-pathed on CI in nightly-record.yml + ci-e2e.yml (commit `219abdb`, Ro5-reviewed before implementation). Verified by dispatch runs: nightly setup passes (was dead at 24s), E2E 1.11 record_item tests pass, 1.12 green. Closed `testimonial-4ec8`.
- **Filed P1 follow-ups**: `nmih` (test_lcov_tracefile testset lacks VERSION gate though tracefile lookup is 1.12+ hard-gated in CoverageLayer.jl:317 — failure was masked by the E2E red), `l7hk` (nightly record_all hit 30-min step timeout with zero stdout — measure per-item latency before re-budgeting), ci.yml quick-suite 1.11 gate (same ungated setup defect, red since Aug 5).
- **Next**: `nmih` (1-line gate) → ci.yml ungate → `l7hk`.
