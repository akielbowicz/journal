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
## 2026-05-06 09:15 — dont

- Continued dont implementation: completed dont-79o (init strict mode, locked seed snapshot, init audit event, minimal prime) and dont-m0v (define term creation, TermView, term show).
- Added follow-up dont-do3: repo and dont init now ignore .dont/; added just install for local CLI testing.
- Validation stayed green: just test and cargo clippy --all-targets --all-features -- -D warnings; commits pushed through f9d9b67; beads Dolt pushed.
- **Next:** pick one ready issue: dont-i1v label validators, dont-2p6 strict/permissive references, or lifecycle verbs (ignore, reopen, lock, verify-evidence).

---
## 2026-05-06 11:01 — mibilioteca

- Scaffolded repo with wai, beads (bd), and openspec based on `bookshelf-pwa-requirements.md`
- Ran Rule of 5 review on the scaffold; identified 1 critical, 5 high, 6 medium, 6 low issues
- Fixed all issues: projections→slash commands, baseline OpenSpec specs (data-model + api-contracts), session close protocol, research artifacts (4 entries), CLAUDE.md structure, justfile, `.editorconfig`, `_typos.toml`
- wai way score improved from 10/21 to 14/21
- **Next:** advance to design phase (`wai phase set design`), add design artifacts for capture pipeline and data model, begin Vite + TypeScript project init

---
## 2026-05-06 12:34 — dont

- Implemented `dont-i1v`: five label validators for `dont define --label` — indefinite article, sentence punctuation, compound-undeclared, sentence verb, and proper noun checks; added `--label` flag to CLI, `label` field to `TermRecord` and store; 75 tests pass (13 new).
- Rule of 5 review (Stage 4): no CRITICAL/HIGH; 3 actionable findings — misleading `term-shape-indefinite` remediation string, missing arity-mismatch test ("a triple (x, y)"), missing doc-extraction-skips-compound test.
- ro5u findings pending: fix remediation string in `validate_label`, add 2 test cases; implementation itself is correct.
- **Next:** apply the 3 ro5u fixes to `dont-i1v`, commit, close `dont-i1v`, then pick `dont-6d9` (ignore lifecycle verb) or `dont-2p6` (strict/permissive enforcement).

---
