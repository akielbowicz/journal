### 2026-07-28 00:12 — snap
- Created genesis shared crate (v0.1.0 tagged): envelope, suggestions, managed_block, aix, feedback modules — 93 tests
- Created openspec change proposals: add-config (shared config management), add-guide (CLI scaffold for guiding tools), add-test-fixture (scratch test environments)
- Updated suite_linter design: from hardcoded tool-specific checks to LintCheck trait + LinterRegistry (decoupled)
- Opened/reviewed per-repo adoption proposals across 8 downstream repos (wai, dont, pretender, espectacular, testaruda, crua, livin, vampiro)
- Fixed Ro5U findings across all three new proposals
- **Next:** implement the proposals (add-config, add-guide, add-test-fixture) — suggest starting with add-config since add-guide depends on it
### 2026-07-28 00:42 — snap
- Implemented config module (genesis-mu5): ConfigFile trait, ConfigRegistry, ConfigStore, ConfigError with AIX self-healing — 38 tests. Ro5U review fixed TypeMismatch variant, validate_all(), dead code, empty file handling.
- Implemented suite_linter module (genesis-4pa.4): LintCheck trait, LinterRegistry, LintResult with severity/fix — 26 tests. Ro5U review fixed double-prefix in run_filtered.
- Closed dont-2j6o as superseded (genesis-4pa.1.4): re-pointed testaruda-8zq→testaruda-3bj and espectacular-lwl→espectacular-73s at per-repo adopt-genesis proposals.
- Verified Appendix A compliance matrix (genesis-4pa.5.2): found 4 inaccuracies; filed genesis-9o5 (P3) for charly-monorepo doc update.
- Fixed pre-existing flaky test in feedback::scratch (accumulated scratch files across runs).
- **Next:** The remaining P3 ticket genesis-9o5 (update charly-monorepo tool-craft.md matrix) requires cross-repo access. Or pick up the add-guide or add-test-fixture openspec proposals.
### 2026-07-28 01:23 — snap
- Implemented guide module (Verbosity, Output, ErrorSink, GuideBuilder, Guide) — 37 tests across genesis-qhz and genesis-e02
- Implemented fixture module (Fixture builder, assertions, Fixture::run, CommandOutput) — 22 tests across genesis-d4a and genesis-ndg
- All 4 implementation tickets closed, 209 total tests (from 157), clippy clean
- Tagged v0.2.0 (config, guide, fixture modules added since v0.1.0)
- Created per-repo `upgrade-genesis` proposals in all 8 downstream repos (config + guide adoption)
- Ran Ro5U review on proposals, fixed all findings (optional/SHALL, stale blocker, config.rs wording)
- All 8 proposals committed, pushed, and `openspec validate --strict` clean
- Updated genesis proposals (add-config, add-guide) to mark downstream migration tasks done
- **Next:** implement the `upgrade-genesis` proposals in downstream repos, or close genesis-oxj/genesis-9o5

### 2026-07-28 09:03 — snap
- Fixed all 14 Ro5U findings on `src/fixture.rs`: Result contracts, `with_config` round-trip via `ConfigFile::path()`, `Fixture::new()`, `path(relative)`, `FixtureError` type, `cfg(unix)` guards, `.gitkeep` seed, `DeserializeOwned`, `signal` field, `tempfile::keep()`.
- Created 39 espectacular scenario contracts across all 4 pending changes (add-test-fixture, add-config, add-guide, add-genesis-foundation) — probed `ah` source in `espectacular/src/contracts.rs` to decode the `[tests] cargo = [{ flags = "...", ... }]` format.
- Pushed 2 commits (`57fcc1d`, `489b4bb`) to `main`.
- **Next:** the pre-existing unstaged `openspec/changes/add-config/tasks.md` and `test.md` are still pending; `add-genesis-foundation` has 3 architectural scenarios with `no-tests-declared`.

### 2026-09-01 15:09 — snap
- Created agent-evals deep-research prompt (`research/cli-agent-evals-prompt.md`), reviewed it Rule-of-5, imported both the prompt and the returned comprehensive report as wai research artifacts
- Wrote `docs/how-to/evals.md` (agent-eval methodology: fixtures, contrived-failure injection, deterministic checks, failure taxonomy, AIX A/B, model-tier knobs) — Rule-of-5'd, incl. correcting a false exit-code claim in both doc and bd issue
- Filed + issue-reviewed two tickets: `genesis-zxv` (evals module core slice, P2) and `genesis-u40` (exit-code contract, P3); both have MUST/METER/anti-goals, AFK, base_commit anchored; dep removed as artificial serialization
- All committed and pushed (`2300424`); `ah check` clean
- **Next:** `bd ready` → pick up `genesis-zxv` with the "Anatomy of a complete scenario" sketch in docs/how-to/evals.md as the target API; optionally split zxv follow-ups + file CI-wiring ticket per issue-review recommendations

## Migrated from cv:charly-vibes/genesis.git (branches/main)


### 2026-07-28 11:01 — session close
- Published genesis-vibes v0.2.0 to crates.io (renamed from genesis, name was taken)
- All 8 downstream repos switched from git dep to crates.io dep
- Config + guide adoption complete in wai, dont, pretender, espectacular, testaruda
- Vampiro (vampiro-d8o) is the only repo needing actual config/guide implementation
- CI pipeline set up with GitHub Actions: ci.yml (push/PR), publish.yml (tag push → crates.io)
- Openspec status: add-config 23/23, add-guide 30/30, add-test-fixture 26/26, add-genesis-foundation 27/29
- Remaining: genesis-9o5 (Appendix A matrix), vampiro-d8o (config/guide adoption), crua-o1c/livin-8vc (spec-stage)

### 2026-09-20 18:54 — snap
- Reviewed + revised `openspec/changes/add-evals-guidelines`: 5-pass spec review fixes (bound-stopped trial status, ERR-code routing key, v1 contract home = docs/fixture-normative, precision items) and alignment with Hamel/Shreya AI Evals FAQ (new D8; scenario provenance, prevalence bounding, battery maintenance requirements).
- `openspec validate add-evals-guidelines` passes; committed `0ee8b94` and pushed to origin/main; working tree clean.
- Implementation not started — tasks.md unchecked: ActionFormatViolation taxonomy variant + tests (§2), report contract reference page + fixtures (§3), 4 mdBook pages (§4), adoption tickets (§6).
- **Next:** implement tasks §2 (ErrorTaxonomy::ActionFormatViolation + round-trip tests, TDD) and §3 (report contract docs/fixtures), then §4 docs, then archive the change.

### 2026-09-20 19:27 — close (implementation + archive)
- **`add-evals-guidelines` fully implemented (TDD) and archived** — all 19 tasks done; commits `828cb63` (implementation) + `2c9dbbe` (archive/deploy) pushed. Spec deployed: `openspec/specs/evals-guidelines/spec.md` (13 reqs, 32 scenarios); evals spec gained the ActionFormatViolation requirement + verbatim-id attribution wording.
- Shipped: `ErrorTaxonomy::ActionFormatViolation`; report contract v1 (`docs/reference/eval-report.md` + normative fixtures `tests/golden/eval_report_{tier2,replay}.json` + round-trip/no-nulls/vocabulary tests); book pages (`evals.md` live cadence + `how-to/evals-ci.md` + `explanation/why-weak-readers.md`); `EvalsGuidelinesAdoption` advisory linter; 5 adoption tickets (genesis-eiq/o1j/lmv/6ky/fsp for dont/wai/espectacular/pretender/testaruda); 2 wai records (design decisions + D8 FAQ alignment).
- **espectacular deployment pattern (repeatable)**: archiving a change with Scenario deltas trips pre-push `ah check` no-toml findings. Fix = deploy contracts under `.espectacular/<spec>/<scenario-slug>.toml`. For machinery scenarios map to real test flags; for **doc-normative** scenarios (design D4: book is the normative home) write normative-doc guards — `tests/evals_guidelines_docs.rs` pattern: one test per requirement asserting normative phrasing in the deployed pages, with whitespace + markdown-noise (`\`*`) normalized matching. Guards double as doc-drift catchers (they caught 2 wording drifts vs spec).
- **Noted, not fixed**: `evals` module missing from `examples/gen-aix.rs` AIX module list — llms.txt/llm.txt don't advertise the evals module (pre-existing gap).
- **Next:** `genesis-dvf` (P2 testaruda feedback wiring) or `add-config`/`add-guide`/`add-test-fixture` openspec changes; 5 adoption tickets parked until per-repo batteries start.

### 2026-09-20 19:27 — close (implementation + archive)
- **`add-evals-guidelines` fully implemented (TDD) and archived** — all 19 tasks done; commits `828cb63` (implementation) + `2c9dbbe` (archive/deploy) pushed. Spec deployed: `openspec/specs/evals-guidelines/spec.md` (13 reqs, 32 scenarios); evals spec gained the ActionFormatViolation requirement + verbatim-id attribution wording.
- Shipped: `ErrorTaxonomy::ActionFormatViolation`; report contract v1 (`docs/reference/eval-report.md` + normative fixtures `tests/golden/eval_report_{tier2,replay}.json` + round-trip/no-nulls/vocabulary tests); book pages (`evals.md` live cadence + `how-to/evals-ci.md` + `explanation/why-weak-readers.md`); `EvalsGuidelinesAdoption` advisory linter; 5 adoption tickets (genesis-eiq/o1j/lmv/6ky/fsp); 2 wai records (design decisions + D8 FAQ alignment).
- **espectacular deployment pattern (repeatable)**: archiving a change with Scenario deltas trips pre-push `ah check` no-toml findings. Fix = deploy contracts under `.espectacular/<spec>/<scenario-slug>.toml`. For machinery scenarios map to real test flags; for **doc-normative** scenarios (design D4: book is the normative home) write normative-doc guards — `tests/evals_guidelines_docs.rs` pattern: one test per requirement asserting normative phrasing in deployed pages, whitespace + markdown-noise normalized. Guards double as doc-drift catchers (caught 2 wording drifts vs spec).
- **Noted, not fixed**: `evals` module missing from `examples/gen-aix.rs` AIX module list — llms.txt doesn't advertise the evals module (pre-existing).
- **Next:** `genesis-dvf` (P2) or `add-config`/`add-guide`/`add-test-fixture`; 5 adoption tickets parked until per-repo batteries start.
