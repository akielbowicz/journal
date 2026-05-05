# Work Queue

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-05 15:31 — elegua

- Implemented `elegua/numeric/tolerance.py` (scalar tolerance types), `array.py` (array comparison with top-K diagnostics), `provenance.py`, and `verify_isolation` in `adapter.py`
- Rule of 5 review caught and fixed: ULP distance wrong for negatives (HIGH), NaN/Inf guard (MEDIUM), label mismatch silent failure (MEDIUM), plus 3 LOWs
- Implemented `elegua/numeric/layer.py` — `make_numeric_layer` LayerFn dispatching scalar/array/sample paths; registered in comparison pipeline as L3 via `NUMERIC_KEYS`
- **Next:** `elegua-jwox` (integrate top-K array disagreement reports with numeric layer) or `elegua-g5k7` (backwards compatibility tests) — both now unblocked

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

## 2026-05-05 16:28 — XAct.jl

- Continued sxAct-rvzo in XAct.jl: removed obsolete local `sxact.runner.isolation` and its tests now that live execution uses `elegua.IsolatedRunner`.
- Refactored `packages/sxact/src/sxact/oracle/client.py` to delegate HTTP transport to `elegua.oracle.OracleClient` while preserving sxAct `Result` compatibility; removed direct `requests` dependency and updated `uv.lock`.
- Added migration boundary tests in `tests/unit/test_elegua_migration_boundary.py`; verification passed (ruff, mypy, non-oracle pytest 1021 passed) and pushed `812ef80` to origin/main.
- **Next:** continue sxAct-rvzo by deciding whether local snapshot/compare/loader compatibility layers should be thinned further or kept as sxAct-specific adapters; run `bd show sxAct-rvzo --json` first.

---
