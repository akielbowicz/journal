# Work Queue

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-05 15:16 — dont

- Completed tracer-bullet epic (`dont-9iq`): implemented all 10 phases end-to-end in one session
- Built Rust CLI with 6 commands (init, conclude, trust, dismiss, show, list), CozoDB datom store, envelope types, status lattice, and 7 integration tests
- Optimized `list_claims` from O(N+1) to O(2) Cozo queries; 75 tests passing, epic closed
- **Next:** check `bd ready` for newly unblocked work — likely label validators (`add-dont-define-label-validators`) or spec work (`dont-71y`, `dont-656`)

---

## 2026-05-05 15:31 — elegua

- Implemented `elegua/numeric/tolerance.py` (scalar tolerance types), `array.py` (array comparison with top-K diagnostics), `provenance.py`, and `verify_isolation` in `adapter.py`
- Rule of 5 review caught and fixed: ULP distance wrong for negatives (HIGH), NaN/Inf guard (MEDIUM), label mismatch silent failure (MEDIUM), plus 3 LOWs
- Implemented `elegua/numeric/layer.py` — `make_numeric_layer` LayerFn dispatching scalar/array/sample paths; registered in comparison pipeline as L3 via `NUMERIC_KEYS`
- **Next:** `elegua-jwox` (integrate top-K array disagreement reports with numeric layer) or `elegua-g5k7` (backwards compatibility tests) — both now unblocked

---

## 2026-05-05 15:32 — dont

- Ran 9 pending OpenSpec validations (all passed 23/23) and archived all 10 spec changes into `openspec/changes/archive/`
- Populated `openspec/specs/` with 21 canonical capability specs (2,527 lines); closed `dont-656` and `dont-71y`
- Marked `implement-tracer-bullet` tasks 3–41 complete, added missing test 10.4 (refusal loop end-to-end), archived the change; 76 tests green
- Created `openspec/specs/dont-build/spec.md`; `wai status` shows "all changes complete"
- **Next:** `bd ready` — all OpenSpec work for the v0.3.2 spec decomposition is done; check for newly created or unblocked implementation tasks

---

## 2026-05-05 15:51 — elegua

- Committed staged housekeeping (archived `refactor-composition-pipeline` change files)
- `elegua-06tm` (red): wrote failing tests for NPY array blob — added missing-blob contract test, checksum-corruption test, compressed round-trip, docstring fix, large-array threshold bump; closed after ro5u review
- `elegua-7ktz` (green): implemented `put_array`, `get_array`, `validate_manifest`, `ArrayManifest` in `elegua/blob_array.py`; 597 tests pass; ro5u found 2 fixes (broad except → specific exceptions, dtype string → np.dtype comparison); closed
- **Next:** `elegua-jwox` — integrate top-K array disagreement reports with numeric comparison layer (now unblocked by both 06tm and 7ktz)

---

## 2026-05-05 15:52 — XAct.jl

- Completed issues sxAct-7ulq, sxAct-7nmo, sxAct-ovpb, sxAct-xebl, sxAct-h7ks: extracted normalize/sampling layers into elegua bridge, ported adapters, migrated TOML schema validation, replaced sxact.runner.isolation with elegua IsolatedRunner
- Switched elegua dependency from local path to PyPI (`elegua 0.1.0`) after CI couldn't resolve sibling directory
- Fixed ruff, mypy CI failures post-migration; tightened pre-push hooks so mypy runs at push time and triggers on pyproject.toml changes
- **Next:** implement sxAct-rinw (end-to-end integration smoke test for elegua+sxact pipeline) and sxAct-rvzo (refactor sxact to consume elegua as external dependency)

---

## 2026-05-05 16:00 — XAct.jl

- Implemented and pushed sxAct-rinw in XAct.jl: live runner now compares expected expressions through Elegua ComparisonPipeline with sxAct L3 canonical and L4 numeric layers when an oracle is available.
- Added tests in packages/sxact/src/sxact/cli/run.py, tests/runner/test_run_live.py, and tests/integration/test_elegua_pipeline_smoke.py; closed bead sxAct-rinw.
- Verification passed: non-oracle pytest suite (1051 passed), targeted smoke skipped without oracle, ruff, and mypy; pushed commit d4336ac to origin/main.
- **Next:** start sxAct-rvzo — refactor sxAct to consume Elegua as the external dependency now that the integration smoke is in place.

---
