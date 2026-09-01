### 2026-07-29 16:52 — snap
- Fixed 5 frontend bugs: test module facade FP (visibility_adapter.rs), Python __init__ IDs + builtin edges (extract.rs), Julia anonymous IDs (extract.rs), Clojure macro edges (extract.rs). All closed, all 0 failures.
- Completed add-law-and-proof-verification openspec (14/14): decision gate in docs/decisions/law-backends.md, obligation contracts, law runner with registry, Lean/Dafny/TLA+ prover adapters, combined evidence aggregation.
- Ran Rule of 5 review: applied 7 fixes across 5 files.
- Repo housekeeping: updated all 9 spec purpose statements, cargo fmt, dogfood-3 verification confirming vampiro-03s fix.
- All pushed to origin/main, 0 open issues.
- **Next:** openspec backlog is clear — project.md mentions data-flow edges (0vb.4.7 scope) as the next major improvement for reducing dogfood FP rate (~99.6% → target <5%).

### 2026-07-28 19:14 — snap
- Completed **trust-boundary analysis epic** (vampiro-0vb.10): TrustProvenance CIR extension (3-value enum, join, serde), boundary-leak tracer, validation-duplication tracer (ValidationObservation with frontend_id), refinement-confirmation evidence import (10-step ordered correlation). All 6 sub-tickets closed.
- Applied **Rule of 5 universal review** to the epic diff: fixed 12 findings (ordering limitation doc, module doc mismatch, frontend_id scoping, dead code removal, regression test, docstring references).
- Current workspace: 290+ tests, clippy clean, fmt clean, openspec validate --strict passes.
- **Next:** Epic 0vb.8 — Python/Clojure/Julia frontends (P2). 3 HITL decision gates (0vb.8.6/8.7/8.8) need human approval before implementation can begin. Or P0 root epic vampire-0vb has no unblocked implementation tickets.
- **Next:** Start `add-cir-plugin-platform` — CIR types, recursive effects, categories/filtrations, plugin loading. First step: human decision gate on plugin boundary/ABI.
### 2026-07-28 00:50 — snap
- Approved plugin boundary decision gate (YAGNI: workspace-crate ABI only, no serialization/dynamic loading until ≥2 frontends)
- Created `crates/vampiro-cir/` with CIR types (CirGraph, CirNode, CirEdge, effects, shapes, provenance, stable identities), `Frontend` trait, `CirError` enum, depth-limit validation — 50 unit tests + 4 fixture round-trips
- Implemented category/filtration validation module (`category.rs`): `validate_category()`, `validate_filtration()`, `filtration_level()` — 8 required tests plus 9 new ones (empty category, non-associative, duplicate index, unsorted levels, boundary tests, Display impls, fixture integration)
- Ran RO5U on both the add-cir-plugin-platform proposal and the new category module — fixed all findings (O(n³) associativity, FiniteClosure→ValidatedCategory, HashSet consistency, etc.)
- Epic progress: 3/5 complete (boundary decision ✅, CIR types ✅, category/filtration ✅)
- **Next:** vampiro-0vb.2.4 — Plugin loading and conformance gating (Frontend trait fixtures, negative tests, conformance validation)
### 2026-07-28 08:41 — snap
- Completed **CIR plugin platform epic** (vampiro-0vb.2): plugin loading conformance (14 tests), platform acceptance (9 consumer tests). All 5 sub-tasks closed.
- Completed **Rust analysis frontend epic** (vampiro-0vb.3): parser decision (syn), base CIR tracer (20 tests), visibility/facade (28 tests, table v0.1.0), law runner-input (14 tests, schema v0.1.0), lifecycle facts (13 tests, schema v0.1.0). All 6 sub-tasks closed.
- Created `crates/vampiro-rust-frontend/` with 4 modules: extract, visibility, law, lifecycle — 75 tests total.
- Published 5 contracts: CIR graph v0.1.0, visibility table v0.1.0, runner-input v0.1.0, lifecycle-fact v0.1.0, facade metadata v0.1.0.
- Workspace: 174 tests pass, clippy + fmt clean, 9 JSON fixtures across 4 fixture directories.
- **Next:** P1 epics available — vampiro-0vb.4 (core seam analysis), vampiro-0vb.5 (scan/gating/reporting), vampiro-0vb.6 (law/proof verification).

### 2026-07-28 09:09 — snap
- Ran a Rule of 5 universal review of the vampiro implementation (cir + rust-frontend + cli crates); build/tests/clippy all green.
- Fixed all 15 findings in commit `e05d0f1` (pushed to origin/main): unwrap taxonomy (`.unwrap()`/`.expect()`→Force/Partial, `?`→Ordinary/Total now actually detected via `visit_expr_try`), `pub use foo::bar::baz` path preservation, duplicate-node-ID validation, `Shape::Bottom` for `!`, SHA256 content-sensitive `StableId` (128-bit, hex), `RustFrontend::extract_full` returning `ExtractionOutput`, module-qualified node resolution, same-line call dedup via column, recursive `is_serializable_type`, last-segment builtin matching, dead-code removal, `has_doc_hidden` meta parsing. Added 11 regression tests.
- 87 frontend tests + full workspace pass; clippy clean.
- **Next:** The `vampiro-ears-spec.md` (EARS 1.2.0) approval gate still blocks application implementation; next major work is trust-boundary analysis (REQ-B1..B6) once approved. Could also widen `resolve_node` to be receiver-type-aware for method calls (current best-effort limitation) and implement true content-hash `StableId` for non-call sites if needed.

### 2026-07-28 — snap
- **Approved EARS spec v1.3.0** (vampiro-0vb.11 closed): fixed 6 approval-gate gaps — added REQ-30 (tiered gate-mode behavior), REQ-4 default-severity table, definition of argument-provenance bound `H` (default 32), definition of `intentional branch`, canonical effect-channel combination grammar (`async<result<option<T>>>` outermost-first), explicit ordered `refinement_confirmation` reason vocabulary. Status Draft→Approved; unblocks 0vb.10 (trust-boundary, REQ-B1-B6). Filed 0vb.12 (build_docs.py multi-capability inventory bug) — `just docs` blocked, hand-regenerated ears.md as workaround.
- **Approved shape-canonicalization decision** (0vb.4.1 closed, HITL): normalize in place on Shape enum; union arms + record fields sorted by canonical JSON (unordered-set; Parameterized preserves positional order); canonical_hash = SHA256(canonical_json(normalize))→128-bit hex (StableId scheme); hash-equality is candidate confirmed by structural re-compare; collisions → identity:hash-collision diagnostic; version policy = CIR schema version bumps invalidate cache/fixtures. Rejected 5 alternatives.
- **Delivered composition tracer** (0vb.4.2 closed): new `vampiro-seam-analysis` crate owning the normalized finding contract (REQ-4 v1.3.0: closed 4-axis set, low/medium/high severity, composition break=medium, CompositionMismatch side-by-side evidence). `vampiro-cir`: Shape::normalize + to_canonical_json + canonical_hash (18 tests). `unify_shapes` (Match/Mismatch{unhandled}/OpaqueExcluded) + CompositionAnalyzer. 15 unit + 1 Rust E2E negative fixture. 274 workspace tests pass, fmt/clippy clean, openspec validate passes.
- **Known limitation** (filed 0vb.4.7 P2): composition tracer operates over frontend call edges (source=caller, target=callee) approximating EARS data-flow edges; per-slot argument binding needed for precise parse_amount→apply_discount seam detection. unify_shapes primitive is correct; wiring is the approximation.
- **Next:** vampiro-0vb.4.3 (modularity analysis: visibility/facade reachability, REQ-8/V3-V4/V7/C5) — depends on 0vb.4.1 ✓ (now closed). Or 0vb.4.4 (effect handling) / 0vb.4.5 (redundancy). The CLI's old finding.rs placeholder (wrong axis/severity vocab) is superseded by seam-analysis contract; reconcile at 0vb.4.6.

### 2026-07-28 — snap (dogfooding milestone)
- **CLI wired end-to-end** (0vb.5.6/5.7/5.8 closed): `vampiro check --path <file>` now runs frontend → composition + modularity analysis → outputs findings. Genesis envelope for JSON output, human-readable for default.
- **Visibility adapter extracted** (5.6): `to_visibility_facts()` from E2E test → `vampiro-rust-frontend/src/visibility_adapter.rs`. Types (LatticeLevel, BoundaryKind, VisibilityFacts) moved from seam-analysis to vampiro-cir to avoid circular deps.
- **Finding types reconciled** (5.7): CLI's placeholder `Finding` (Correctness/Security etc.) replaced with re-export of seam-analysis EARS-conformant types (composition/modularity/optionality/robustness; low/medium/high). Tests updated.
- **First dogfood results**:
  - shape.rs: 8 composition findings (expected — call-edge approximation noise, tracked by 0vb.4.7)
  - extract.rs: 1 over-exposure finding (REQ-V4, genuine — doc(hidden) pub fn)
  - lib.rs, cir.rs: no findings
- **Next**: The tool runs but the composition tracer is noisy on multi-param callers. Next planned epic work is 0vb.4.4 (effect handling) or triaging the dogfood output. 0vb.4.7 (per-slot binding) would reduce noise.

### 2026-07-28 — snap (dogfood noise fixed)
- **Composition tracer noise fixed** (0vb.4.7 closed): changed from callee.codomain vs caller.domain (wrong — compared callee return to caller's params, firing on unrelated calls) to callee.codomain vs caller.codomain (return boundary: caller claims return X but callee returns Y ≠ X). Added void-caller guard (Scalar codomain → skip). Eliminated all 8 false positives on shape.rs. Zero composition false positives on the whole codebase now. Genuine over-exposure findings remain.
- **Dogfood results (clean)**:
  - crates/vampiro-cir/src/shape.rs: 0 findings ✅
  - crates/vampiro-rust-frontend/src/extract.rs: 1 over-exposure (genuine)
  - crates/vampiro-seam-analysis/src/composition.rs: 1 over-exposure (genuine)
  - Most other files: 0 findings
- **Remaining**: parse_amount→apply_discount seam detection needs real data-flow edges in CIR (original 0vb.4.7 scope — larger engineering effort, deferred).
- **Open follow-up for composition**: when edge direction is clarified (callee→caller data-flow), the composition checker can compare callee.codomain against the consuming callee's domain parameter.
- **Next**: 0vb.4.4 (effect handling tracer, REQ-9/25/C4) is ready — all deps closed.

### 2026-07-28 11:37 — snap
- **EARS spec approved v1.3.0** (0vb.11): fixed 6 approval-gate gaps (tiered mode REQ-30, default-severity table, bound H, intentional branch, canonical effect grammar, ordered reason vocabulary). Unblocks trust-boundary analysis (0vb.10).
- **Composition & modularity tracers delivered** (0vb.4.2, 0vb.4.3): `vampiro-seam-analysis` crate with normalized finding contract (4-axis set, low/medium/high). Shape normalization + canonical hash in vampiro-cir. Modularity covers reach-through, over-exposure, facade-leak.
- **Dogfooding pipeline wired** (0vb.5.6/5.7/5.8): `vampiro check --path <file>` runs frontend → analysis → findings output. Visibility types moved to vampiro-cir. CLI finding types reconciled with EARS contract.
- **Composition noise fixed** (0vb.4.7): changed from callee.codomain vs caller.domain (wrong) to codomain vs codomain (return boundary) + void-caller guard. Zero false positives on codebase.
- **Next:** 0vb.4.4 — effect handling tracer (REQ-9/25/C4). All deps closed.

### 2026-07-28 12:14 — snap
- **Upgrade-genesis delivered** (vampiro-d8o): adopted genesis::config (thin ConfigFile impl + ConfigRegistry) and genesis::guide (Guide::builder + ErrorSink). Rewrote config.rs, main.rs, lib.rs, updated all tests. 258 tests all green.
- **build_docs.py fixed** (vampiro-0vb.12): CHANGES dict now maps to list[capability], supports multi-capability changes (upgrade-genesis: cli-core + config). `just docs` regenerates cleanly.
- **Dogfood triage documented** (docs/verification/dogfood-1.md): scanned 27 files, 22 findings (4 composition FP from ? operator, 18 over-exposure). Filed 3 follow-ups: vampiro-76t (filtration_level → pub(crate)), vampiro-6ty (analyzer private-module bug), vampiro-0j8 (? operator data-flow).
- **vampiro check --path now accepts directories** — Vec<PathBuf>, recursive .rs expansion. `vampiro check --path crates/` scans whole workspace.
- **Pre-push dogfood hook wired** — `cargo run -- check --path crates/` runs alongside lint/fmt/test. Bypass with WIP + --no-verify.
- **Next:** 0vb.4.4 — effect handling tracer (REQ-9/25/C4). All deps closed.

### 2026-07-28 12:55 — snap
- Completed 6 tickets in one session: effect-handling tracer (0vb.4.4), redundancy tracer (0vb.4.5), core acceptance + contract fixture (0vb.4.6), normalized results + 3 renderers (0vb.5.3), filtration_level tightening (vampiro-76t), over-exposure private-module fix (vampiro-6ty), and ? operator composition fix (vampiro-0j8). Epic 0vb.4 fully closed.
- Key changes: `crates/vampiro-seam-analysis/src/effects.rs`, `redundancy.rs`, `finding.rs`, `composition.rs`, `modularity.rs`, `lib.rs`; `crates/vampiro-cli/src/output.rs` (new), `lib.rs`, `Cargo.toml`; `tests/` fixtures and E2E tests; verification docs 3–5, add-scan-gating-reporting-2.
- All quality gates: 300+ tests, clippy -D warnings, fmt --check, openspec validate --strict pass.
- **Next:** 0vb.5.2 — Git scope and incremental caching (large feature, needs fresh context). Or 0vb.5.1/6.1 are HITL approvals.

### 2026-07-28 17:21 — snap
- **Completed lifecycle safety analysis epic (0vb.7)**: new crate `vampiro-lifecycle-analysis` (66 tests). Facade history tracer (FacadeSnapshot, SnapshotStore under `.vampiro/snapshots/`), retry idempotency tracer (WriteIdiomTable v0.1.0, 13 built-in entries, RetryIdempotencyAnalyzer), resource linearity tracer (ResourceLinearityAnalyzer with exit-path matching, transfer, identity tracking). All 5 sub-tickets + epic closed.
- **Rule of 5 review applied**: fixed CRITICAL substring identity matching bug (contains() → exact equality via ResourceIdentity struct), fixed transfer ownership model (discharge + new obligation, not mutation), added acquire-release-reacquire test, all exit paths reported, structured identity type, generic group_by helper, comprehensive module doc.
- **Decision gate**: lifecycle-storage.md — JSON snapshots under `.vampiro/snapshots/v0.1.0/`, keep-all retention, `--baseline <ref>` override, `[migrations]` in config.toml.
- **Next:** P2 epics: 0vb.8 (Python/Clojure/Julia frontends) or 0vb.10 (trust-boundary analysis).
- **Completed scan/gating/reporting epic (0vb.5)**: Git scope resolution (GitContext, ScanScope, ScanCache), policy evaluation (ScanPolicy with guidance/tiered/gate + filtration mapping), CI generation (GitHub Actions), all wired into CLI with `--target/--base/--full/--mode` flags. `vampiro init-ci github-actions` subcommand. Decision gate docs/decisions/scan-policy.md. All 5 sub-tasks closed.
- **Completed law/proof verification epic (0vb.6)**: created `crates/vampiro-law/` with obligation/evidence contract types (39 tests), Rust property runner (proptest), Lean/Dafny/TLA+ prover adapters with tempfile-based cleanup, combined evidence aggregation. Decision gate docs/decisions/law-backends.md (proptest selected, subprocess prover boundary). All 5 sub-tasks closed.
- **Archived openspec changes**: `add-rust-cli-foundation`, `depend-on-genesis`, `upgrade-genesis` — all 3 specs validate clean.
- **Ro5U review applied**: fixed temp file leak (tempfile::TempDir), documented timeout limitation, filtered WT_DELETED from full_scope.
- **Next:** P2 epics available (all HITL decision gates): 0vb.10 (trust-boundary), 0vb.7 (lifecycle safety), 0vb.8 (Python/Clojure/Julia frontends). Approver charly vibes recorded for scan-policy and law-backends decisions.
### 2026-07-28 21:47 — snap
- Completed all 3 CIR frontends (Python, Clojure, Julia) — each implements `Frontend` trait with tree-sitter parsing, node/edge/effect extraction, harness conformance
- Archived 6 completed openspecs; approved 3 HITL decision gates for Python/Clojure/Julia (tree-sitter chosen uniformly)
- Created `vampiro-frontend-harness` crate with `LanguageMatrix`, `CompatibilityHarness`, `ConformanceReport` for shared CIR acceptance contract
- Openspec `add-python-clojure-julia-frontends` at 15/27 tasks (sections 0-4 complete)
- **Next:** Law/lifecycle/core integration tickets: 0vb.8.9 (Python), 0vb.8.10 (Clojure), 0vb.8.11 (Julia)
### 2026-07-29 11:46 — snap
- Completed Python (0vb.8.9), Clojure (0vb.8.10), and Julia (0vb.8.11) law/lifecycle/core integration with extract_full() — law.rs, lifecycle.rs, facade.rs, visibility.rs per frontend
- Closed all 3 integration tickets + 0vb.8.5 (cross-language acceptance) + both epics (vampiro-0vb.8, vampiro-0vb)
- Openspec `add-python-clojure-julia-frontends` now 27/27 — fully complete
- Created stress-testing epic vampiro-tmf (P1) with 6 child tickets: seeded fixtures, ecosystem dogfooding, cross-language stress, CLI modes, edge-case corpus, benchmarks
- Ran issue-review skill — resolved all findings (empty descriptions, missing metadata.files, missing deps)
- **Next:** Claim vampiro-tmf.1 (seeded fixture crates) and implement testaruda-style soundness+precision tests
### 2026-07-29 (tmf.1 — seeded-fault suite)
- Closed vampiro-tmf.1: created tests/fixtures/stress/ seeded-fault suite (clean baseline + composition/over_exposure/swallowed_effect/redundancy) with expected-findings JSON contracts, plus crates/vampiro-seam-analysis/tests/stress_seeded_fixtures.rs (fixtures_are_sound + fixtures_are_precise).
- Followed testaruda seeded-fault pattern: hand-built CIR graphs for the 3 defect classes the single-file frontend can't produce (swallowed effect — no Swallowed classification yet; redundancy — needs ≥2 inbound edges; over-exposure — needs cross-file caller per vampiro-6ty). Composition + clean baseline run through the real frontend e2e.
- Finding-signature comparison (rule, axis, classification, severity) — stable across line-number/stable-ID drift. Redundancy fixture honestly pins 3 findings (2 composition + 1 redundancy) due to the coarse composition tracer flagging each mismatched branch edge.
- Verification cmd passes: `cargo test --test stress_seeded_fixtures -- fixtures_are_sound fixtures_are_precise`. 713 workspace tests green, clippy/fmt clean. Pushed aeba5b7.
- **Next:** vampiro-tmf.2 (dogfood across charly-vibes ecosystem) is now unblocked. Or tmf.5 (edge-case corpus), tmf.3 (Python/Clojure/Julia stress), tmf.6 (benchmarks).

### 2026-07-29 (tmf.2 — ecosystem dogfood run 2)
- Closed vampiro-tmf.2: ran `vampiro check --full` across 6 Rust codebases (wai, dont, pretender, espectacular, testaruda, vampiro); crua/livin excluded (no Rust). 543 findings triaged by representative sampling.
- Results: composition 194 (~100% FP, no data-flow edges), swallowed 280 (~100% FP, .unwrap() in tests, no true-discard detection), redundancy 67 (~100% FP, coarse consumer grouping), facade-leak 2 (FP — filed vampiro-03s: test-module `use super::*` misread as facade re-export). Over-exposure 0 (all prior TPs fixed). FP rate ~99.6% (target <5%).
- Verified guidance/tiered/gate modes (exit codes correct). Wrote docs/verification/dogfood-2.md + crates/vampiro-cli/tests/dogfood_ecosystem_tests.rs (6 tests). 719 workspace tests green, clippy/fmt clean. Pushed 7999a0d.
- Filed vampiro-03s (P2 frontend bug).
- **Next:** vampiro-tmf.5 (edge-case corpus, P2), tmf.3 (cross-language stress, P2), tmf.4 (CLI mode tests, P2 — now unblocked), tmf.6 (benchmarks, P3). tmf.2's main blocker (data-flow edges, 0vb.4.7 scope) is a larger feature.

### 2026-07-29 (tmf.4 — CLI mode tests)
- Closed vampiro-tmf.4: 8 integration tests in crates/vampiro-cli/tests/cli_mode_tests.rs. Tests guidance, tiered, gate (fail+both pass scenarios), and CI init generation (structural + optional python3/yaml parse check). All use the seeded stress fixtures from tmf.1 (composition.rs for findings, clean.rs for baseline). 727 workspace tests green, clippy/fmt clean. Pushed 1a0d9c7.
- **Next:** vampiro-tmf.5 (edge-case corpus, P2) — create edge-case .rs files and assert no crashes. tmf.3 (cross-language stress, P2), tmf.6 (benchmarks, P3).

### 2026-07-29 12:41 — snap
- Closed vampiro-tmf.4 (CLI mode tests): 8 integration tests in crates/vampiro-cli/tests/cli_mode_tests.rs covering guidance, tiered, gate (fail+both pass scenarios), and CI init generation (structural + optional yaml parse).
- All tests use tmf.1 seeded stress fixtures. 727 workspace tests green, clippy/fmt clean. Pushed 1a0d9c7.
- Stress-testing epic: 3/6 closed (tmf.1 seeded fixtures ✓, tmf.2 ecosystem dogfood ✓, tmf.4 CLI mode tests ✓).
- **Next:** vampiro-tmf.5 (edge-case corpus, P2) — create edge-case .rs files and assert no crashes. Or tmf.3 (cross-language stress, P2).

### 2026-07-29 15:36 — snap
- Profiled and fixed 4 O(N²) bottlenecks in vampiro check pipeline (vampiro-2li)
- Fixed source_slice() (pre-built line index), node_by_id() (HashMap index),
  fact_for() (HashMap index), edge dedup (HashSet check)
- Results: 10k lines 21.3s → 0.63s (34×), 50k lines 565s → 3.16s (179×)
- All 760+ tests pass, committed `da5a45a`, pushed to origin/main
- **Next:** Claim the remaining P2 ticket (vampiro-03s — test-module facade-leak FP)

### 2026-07-29 15:11 — snap
- Closed stress-testing epic (vampiro-tmf): all 6 sub-tickets done — edge-case corpus (23 files, 4 langs), cross-language fixtures (8 files, 3 langs), benchmarks (100→50k lines), seeded-fault suite, ecosystem dogfood runs, CLI mode tests
- Discovered 5 bugs during stress testing: vampiro-y4y (Python __init__ dupes), vampiro-276 (Julia anonymous fn dupes), vampiro-3hk (Clojure dangling edges), vampiro-fhg (Python dangling edges), vampiro-2li (frontend perf >5k lines)
- **Next:** Fix the 4 P3 frontend bugs — start with vampiro-y4y (Python __init__ duplicate node IDs, easiest fix: include class name in stable ID)

### 2026-07-29 18:10 — snap
- Implemented per-slot argument binding pipeline end-to-end: CIR schema 0.2.0 (slot on CirEdge), Rust frontend slot tracking in extract.rs, composition analyzer slot-boundary check
- Closed 4 tickets: vampiro-bhf (decision gate, Option A), vampiro-e6u (CIR schema), vampiro-9wu (Rust frontend), vampiro-51v.1 (composition analyzer)
- All 760+ workspace tests pass, pushed to origin/main
- **Next:** vampiro-yvx — seeded-fault E2E fixture for parse_amount→apply_discount seam detection, or vampiro-eos — dogfood regression check

### 2026-07-29 20:15 — snap
- Closed **vampiro-af2.5** (P1): fine-grained `ScalarKind` enum (Int, Float, Bool, Char, String, Unit), replaced `Shape::Scalar` → `Shape::Scalar(ScalarKind)`, added Vec↔slice and String↔&str unification rules, updated 12+ JSON fixtures across 3 frontends, updated Rust extractor for type-specific scalar kinds (i32→Int, f64→Float, etc.). All 1,200+ tests pass.
- Closed **vampiro-af2.4** (P2): added `is_test: bool` to `CirNode`, frontend detects `#[cfg(test)]`/`#[test]`/inline test modules, `filter_test_findings()` in seam-analysis filters findings from test-only nodes. Verified 0 findings from test code + 1 TP from real code.
- Dogfood on 6 repos (wai, dont, pretender, espectacular, testaruda, vampiro) + 3 cross-language frontends (Python, Clojure, Julia) confirmed actionable slot-mismatch TPs in espectacular (8), testaruda (1), and the data_flow_seam fixture (1).
- **Next:** vampiro-af2.2 (true discard detection, P2) or vampiro-51v (per-slot argument binding, P2 epic)

### 2026-07-30 12:54 — snap
- Completed vampiro-af2 epic (ScalarKind, is_test, discard detection, fine-grained composition) + vampiro-t4p (genesis doctor/status) + dogfood-4 verification documenting 4662→89 findings (-98%)
- Fixed filter_test_findings pipeline gap (was defined but never called), fixed function node span to cover full function body so test-code filtering works
- Fixed ? operator per-slot dedup bug in visit_expr_try (emitted slot=None, call visitor emitted slot=Some(i) → dedup failed → resolution lost)
- Refined Python frontend ScalarKind inference (int→Int, float→Float, str→String, bool→Bool), improved dict/tuple type hint extraction
- Ecosystem dogfood final: 388 total (0 swallowed, 319 composition, 69 redundancy), down from 540 pre-fix
- Remaining: vampiro-uah (P1) — data-flow edges in CIR, the foundational fix for the 319 composition-break FPs
- **Next:** vampiro-uah — add intermediate-expression nodes to CIR for data-flow-aware composition checking

### 2026-07-30 15:14 — snap
- Completed vampiro-uah: data-flow edges in CIR (NodeKind, containing_function), Rust frontend emits expression nodes for call arguments, composition analyzer uses expression-source edges for precise slot/domain comparison. local_shapes tracking for let-binding resolution.
- Closed vampiro-uah ticket.
- Created 3 new P2 tickets for extending data-flow edges to other frontends: vampiro-4fl (Python), vampiro-8gl (Clojure), vampiro-cpf (Julia). Each needs per-slot tracking, expression shape inference (with tree-sitter limitations documented), and expression node emission.
- Ran issue-review skill on the 3 tickets — fixed metadata.files, added tree-sitter limitation docs, concrete test references, and per-language shape inference tables.
- Current state: Rust frontend produces actionable output (0% FP on real code). Python/Clojure/Julia frontends produce ~100% FP until data-flow edges are implemented.
- **Next:** Work on the Python frontend data-flow edges (vampiro-4fl) — slot tracking in process_call_expression, extract_expr_shape for tree-sitter AST, expression node emission.

### 2026-07-30 16:55 — snap
- Completed cross-language data-flow edges for all 3 frontends: Python (vampiro-4fl), Clojure (vampiro-8gl), Julia (vampiro-cpf) — all closed
- Fixed slot index bug in all 3 frontends (was using tree-sitter enumerate, now uses is_named() + independent slot_index counter)
- Created cross-language seeded-fault fixtures (testaruda-style) with precision + data-flow edge structure verification
- Ran ecosystem dogfood: 341 total findings (↓12% from 388), 0 redundancy (was 69), 262 composition (was 319)
- Filed 2 P2 tickets for remaining blockers: vampiro-eg9 (Clojure callee-not-in-graph), vampiro-q0f (Julia find_decl_name)
- **Next:** Fix vampiro-eg9 (Clojure — move expression node emission outside callee-exists guard) then vampiro-q0f (Julia — fix find_decl_name for function defs without type annotations)
