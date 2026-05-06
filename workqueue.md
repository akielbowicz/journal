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

## 2026-05-05 17:09 — elegua

- Implemented and committed `elegua-jwox`: numeric layer now surfaces array max/argmax/failing-count/top-K diagnostics through `ComparisonResult.diagnostics`, with diagnostics preserved when later layers mismatch.
- Added and committed red-phase coverage report CLI contract tests for `elegua-29d1` in `tests/cli/test_coverage_report.py`; confirmed RED because `python -m elegua coverage` is not implemented yet.
- Validation for implementation passed: ruff, pyright on `src`, full pytest (600 passed), and strict OpenSpec validation; pre-commit passed on both commits with existing Vale warnings only.
- **Next:** pick up `elegua-kaqt` — add failing tests for `--full-pipeline` diagnostic mode and concordance reporting.

---
## 2026-05-06 11:01 — mibilioteca

- Scaffolded repo with wai, beads (bd), and openspec based on `bookshelf-pwa-requirements.md`
- Ran Rule of 5 review on the scaffold; identified 1 critical, 5 high, 6 medium, 6 low issues
- Fixed all issues: projections→slash commands, baseline OpenSpec specs (data-model + api-contracts), session close protocol, research artifacts (4 entries), CLAUDE.md structure, justfile, `.editorconfig`, `_typos.toml`
- wai way score improved from 10/21 to 14/21
- **Next:** advance to design phase (`wai phase set design`), add design artifacts for capture pipeline and data model, begin Vite + TypeScript project init

---

## 2026-05-06 13:00 — miblioteca

- Rule of 5 review on specs (data-model, api-contracts, project.md): found 1 critical + 9 high issues; fixed all 23 in one pass (IMU field count 13→14, shortCode format, blobRef identity contract, uploadState FSM, idempotency header, error codes, storage budget, quality thresholds, DB version history)
- Created all 33 implementation tickets across 7 layers (infra, IDB, camera, sensors, image processing, scan/session/upload, UI) with full dependency chain
- Fixed git remote URL typo: `mibilioteca` → `miblioteca` (pointing to correct GitHub repo)
- Issue-review (5-pass Ro5): found priority inversion, artificial dep, missing deps, iOS null-sensor gap — all 11 fixes applied
- **Next:** start implementation from `mibilioteca-ocf` (Vite scaffold, the only unblocked ticket); `bd ready` shows correct state

---
## 2026-05-06 15:24 — dont

- Closed `dont-zal`: duplicate CURIE redefinition now returns structured `curie-conflict`; added store/unit and CLI coverage to preserve the existing term unchanged.
- Closed `dont-1od`: `trust` and `dismiss` now work for `term:...` IDs, including term status transitions, evidence persistence, and regression coverage.
- Closed `dont-x5c`: `conclude --depends-on` now canonicalizes CURIEs to stored `term:...` IDs, accepts existing term IDs without false unresolved warnings, and keeps genuine unresolved refs as warnings/refusals.
- Validation stayed green after follow-up expectation fixes in `tests/dismiss.rs` and `tests/lock.rs`: `just test` and `cargo clippy --all-targets --all-features -- -D warnings` passed.
- **Next:** pick the next ready bug one-by-one — likely `dont-e6m` (stale `dont help --tutorial` hint) or `dont-cnb` (empty claim statement accepted).

---
