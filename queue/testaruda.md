# Queue: testaruda

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-15 09:31 — testaruda

- Fixed 4 bugs from cositos usage report: static-deps directionality (P0), .venv pollution (P1), --files flag removed (P1), full project tree in adapter pipeline (P1)
- Set up lefthook with pre-commit/pre-push hooks (beads + fmt + clippy + 107 tests)
- Fixed pre-existing clippy warnings across the codebase to make CI gates pass cleanly
- **Next:** continue P2 backlog — `testaruda-16f` (relative imports), `testaruda-j5k` (ingest disconnect), `testaruda-zot` (agent output fields)

---

## 2026-07-15 11:19 — testaruda

- Closed 10 P2/P3 issues in one session: relative imports (16f), ingest disconnect (j5k),
  agent output fields (zot), JUnit XML runtime edges (bmm), discover exclusion config
  (sse), init language detection (1ps), --json/--pre-edit conflict (56o), CI result
  ingestion (m2z), flaky test detection (78d), metrics/observability (nfu), local mode
  working tree select bugfix (b03)
- All tests green: 96 lib, 29 adapter-python, 7 main, 2 integration
- Key changes touched: adapter-python.rs (JUnit XML parser, runtime edges,
  relative imports), store.rs (flaky detection methods), main.rs (--ci, --json
  conflicts, metrics, JSON logs), config.rs (discover exclude, language detection),
  agent.rs (fallback_reason), change.rs (git status parser fix)
- **Next:** P4 backlog — `testaruda-5q1` (engine scale-up), `testaruda-cwu`
  (composability), `testaruda-vz4` (justfile fix)

---
## 2026-07-15 15:29 — testaruda

- Implemented predictive ranking (testaruda-bb8): `TestOrdering::Predictive` variant + `Store::load_failure_rates()` + test scenario 6
  - Frequency-based ranking: sorts selected tests by descending historical failure rate from run_history
  - Always-run tests preserved in selection (never removed by ranking, per TIA-SEL-007)
  - No-history tests sorted last, ID tiebreaker for equal rates
- TDD flow: wrote failing test → implemented → RO5U review → commit → push
- Created testaruda-92j for deferred VER-005 calibration gate
- All 134 tests green, pre-commit/pre-push hooks clean
- Pushed to main (672de8b)
- **Next:** openspec changes at 0% — `add-agent-output-fields` (8 tasks) or `add-init-language-detection` (9 tasks); or P4 backlog

## 2026-07-15 15:29 — testaruda (completed 2 openspec changes)

- Archived `add-agent-output-fields` (8/8 tasks): node_id and fallback_reason already implemented in agent.rs/main.rs, spec delta applied to agent-mode/spec.md
- Archived `add-init-language-detection` (9/9 tasks): detect_project_language() already implemented in config.rs, spec delta (TIA-CHG-009) applied to change-detection/spec.md
- Both changes were pre-existing code work; this session marked tasks complete, updated specs, and archived
- **Next:** P3 deferred (testaruda-92j calibration gate) or P4 backlog (5q1 engine, cwu composability, vz4 tracking)

## 2026-07-15 15:29 — testaruda (completed calibration gate)

- Implemented testaruda-92j (verification calibration gate, TIA-VER-005):
  - CalibrationMetrics struct + Store::evaluate_ranking_calibration()
    - Temporal hold-out split: last run = test, all previous = training
    - Computes recall@k from held-out failures vs training-based ranking
    - Returns empty metrics for <2 distinct runs
  - `testaruda calibrate --threshold` CLI command (default threshold 0.8)
  - `--ordering` flag for `select` (default|deterministic|duration|predictive)
    - Agent mode still forces Deterministic per TIA-AGENT-007
  - 3 new tests: recall computed, empty history, no hold-out
  - 99 lib tests + 7 main + 29 adapter-python + 2 integration = 136 total
- **Next:** P4 backlog — testaruda-5q1 (engine scale-up design), testaruda-cwu (composability design), testaruda-vz4 (justfile tracking)
