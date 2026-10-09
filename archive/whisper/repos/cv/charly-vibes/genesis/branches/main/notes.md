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

### 2026-09-28 17:15 — snap
- Built openspec change `add-git-hooks`: genesis::git_hooks module consolidating git-hook primitives from 3 donors (pretender install/uninstall, wai owner/framework detection, espectacular lefthook injection → rebuilt on managed_block). Rule-of-5 reviewed (fixed dropped requirements, D5 evidence, edge scenarios); 28 donor-grounded scenarios; validated --strict; pushed.
- Decisions: D1 parameterized ownership markers; D2 core.hooksPath respected everywhere; D7 (user) framework() reports single framework incl. Husky via hook sigil, precedence Lefthook > Prek > Husky.
- Tickets in bd (committed+pushed): genesis-7l8 (root/hooks-dir, READY entry point) → {genesis-pzz install/uninstall, genesis-3a8 detection, genesis-16c lefthook wiring} → genesis-qjg registration+hygiene guard → consumer migrations genesis-q4k/glc/orq (P3).
- **Next:** claim `bd update genesis-7l8 --claim` and implement Phase 1 (repo_root + resolve_hooks_dir) via tdd-ro5-wai pipeline; red tests from spec scenarios.
- 2026-09-28T20:38:06Z [id:9b663d3a8e95c0959c1a4ed458b55578faef00ed25dd49830b303844c2bdc818] ### 2026-09-28 17:38 — snap
  - add-git-hooks phases 1-2 implemented via tdd-ro5-wai pipeline, tickets genesis-7l8 and genesis-pzz claimed→closed→pushed (commits 725b771 + phase-2 commit): genesis::git_hooks now has repo_root()/repo_root_from(), resolve_hooks_dir() (local core.hooksPath, relative-to-root), HookName enum, install()/uninstall() with parameterized marker, shebang-preserving marker insertion, 0-byte-file-is-foreign (D6), ForeignHook error variant
  - Full suite 488 tests green, clippy -D warnings clean, ah check clean, all pre-push hooks green
  - Gotcha: bd auto-export git-add fails (.beads gitignored) — commit the export with `git add -f .beads/issues.jsonl` after every bd claim/close
  - **Next:** claim genesis-3a8 (owner()/framework() detection — wai sigil table most-specific-first, espectacular detect_hook_framework, design D3/D7), then genesis-16c lefthook wiring, then genesis-qjg registration+hygiene guard, then archive the change
- 2026-09-28T21:01:49Z [id:e20e3444178b9870f18ee08967985025d2a411c18bfab969760705b25bfbcd32] ### 2026-09-29 — snap
  - genesis-3a8 (git_hooks phase 3: owner & framework detection) implemented via red→green→commit: Owner enum + ordered OWNER_SIGILS table, owner() honoring core.hooksPath via shared hook_path; Framework enum + framework() with Lefthook > Prek > Husky precedence (design D7)
  - Design discovery worth keeping: ticket listed sigil order as (lefthook, husky, bd, pre-commit, prek) but a pure prek hook always contains "pre-commit" (exec prek run pre-commit), so Prek MUST precede PreCommit in the table; bd still precedes prek (bd-shim-chaining-prek → Bd). Wai gets this implicitly by checking hook_contains("prek") before hook_owner
  - 9 new tests, 497 total green, clippy -D warnings clean, ah check clean; commits 0859353 + 2b199cd pushed
  - **Next:** claim genesis-16c (lefthook wiring: ensure_wired/is_wired on managed_block — tasks 4.1-4.5), then genesis-qjg registration+hygiene guard, then archive the change
- 2026-09-28T21:09:58Z [id:3e27ca86c01955b165fa87a7ee701a30dfac51439a450d6acd06356ee58cc809] ### 2026-09-29 18:10 — snap
  - genesis-16c (git_hooks phase 4: lefthook wiring) done via red→green: git_hooks::lefthook submodule with Stage (PreCommit/PrePush, D5b), ensure_wired(root, stage, &BlockDef, content), is_wired() stage-scoped scan (D5); two new GitHooksError variants MissingLefthookConfig / UnanchorableLefthookConfig
  - Two RED-phase gotchas: '"pre-push":' does NOT contain 'pre-push:' (quote precedes colon) so the unanchorable check matches the bare stage key; block markers at column 0 are not YAML keys so idempotence is file-level (spec wording) not section-level
  - 10 new tests, 507 total green, clippy/fmt/ah check clean; commits 806d585 + 9c3ede8 pushed
  - **Next:** claim genesis-qjg (module registration + hygiene guard — tasks 5.1-5.4, last ticket of add-git-hooks), then archive the change via openspec-archive
- 2026-09-28T21:56:01Z [id:cbb4dcc472663f0e17a1faff9e018bb625b850500f753f4f51af9028ba9351a1] ###  — snap
  - genesis-qjg (git_hooks phase 5: registration + hygiene guard) done via red→green: guard test scans non-test portion of src/git_hooks.rs (split_once "#[cfg(test)]") for 4 gate strings (ah check, pretender check, testaruda select, just check-claims); RED came from the module's own boundary-note doc comment, fixed by rewording it without example strings
  - Gotcha: guard tests via include_str! on the module itself are self-referential — scan only production portion (before #[cfg(test)]) so the forbidden-string list in the test doesn't trip itself
  - Docs: modules.md gained git_hooks row + section (verify enum variant names against source before writing docs — first draft invented WireOutcome/NoHooksDir that don't exist); CHANGELOG [Unreleased] entry with downstream compat note
  - 508 tests green, fmt/clippy/openspec --strict/pretender/ah check clean; commits e9ce960 + 483ad68 pushed
  - **Next:** archive the add-git-hooks change via openspec-archive (expect espectacular no-toml findings → deploy .espectacular/git-hooks/<scenario-slug>.toml contracts), then consumer migrations genesis-q4k/glc/orq (P3, downstream repos)
- 2026-09-28T21:59:35Z [id:2f76e519719407d25a11bdc2e3b072819cea55b3c1b1163848469258175b0c05] ### 2026-09-30 — snap (archive)
  - add-git-hooks change archived: spec deployed to openspec/specs/git-hooks/spec.md (+9 reqs); 29 espectacular contracts deployed (.espectacular/git-hooks/ + genesis/tools-need-git-hook-primitives.toml) mapped to unit test flags; ah check --run-tests 95 passed 0 findings
  - add-git-hooks is now fully closed (genesis-7l8/pzz/3a8/16c/qjg all done); remaining follow-ups are downstream migrations genesis-q4k (pretender) / glc (espectacular) / orq (wai), all P3
  - Commits e9ce960 + 483ad68 + fe1fe4c pushed; tree clean
  - **Next:** pick genesis-dvf (P2 testaruda feedback wiring, in testaruda repo) or genesis-qlj (P3 evals AIX registration), or start downstream git_hooks migrations
- 2026-09-28T22:22:18Z [id:e045cb4661960ac2dbd716bdb10f58c98802e9f85653f791793c46697574e4ff] ### 2026-09-28 22:25 — release v0.8.0
  - Rule-of-5 release review (converged stage 4): 0 CRITICAL, 3 HIGH — all release-metadata gaps, not code: (1) CHANGELOG [Unreleased] was missing the whole add-evals-guidelines payload (shipped after the v0.7.0 tag), (2) gen-aix.rs module registry missing evals AND git_hooks so packaged llms.txt/llm.txt under-advertised 2 of 16 modules (genesis-qlj only covered evals), (3) README module table same gap
  - All fixed: gen-aix registry + aix-gen regeneration, README/getting-started pins 0.7→0.8 (doc_sync guard enforces same-commit sync), CHANGELOG stamped [0.8.0] — 2026-09-28 with evals-guidelines + git_hooks + AIX-registry entries
  - Released: tag v0.8.0 pushed, CI publish succeeded, crates.io shows 0.8.0 (22:21 UTC), just notify-downstream 0.8.0 opened issues in all 7 downstream repos
  - Gotchas: (a) bd close did NOT regenerate .beads/issues.jsonl export — needed explicit bd export -o (the git-add hint was the only symptom; check the jsonl content, not just git status); (b) just ci's aix-check fails on uncommitted regenerated AIX files — that's index-vs-tree, not drift, commit first
  - genesis-qlj closed. Remaining: genesis-dvf (P2 testaruda feedback), genesis-ntg (P0 epic), downstream git_hooks migrations q4k/glc/orq (P3)
  - Commits 1cc756d (release) + fcc451a (beads) pushed
- 2026-09-28T23:07:12Z [id:be35fd8e0c4b807ca14029019ded0ecf125c55db20cf1e2f9978d188a9c6aa0b] ### 2026-09-28 23:05 — snap
  - genesis-og6 + genesis-gle done in one red→green pass: feedback stdin now read_to_string (no more one-line truncation); multi-line stdin promotes first line to title (rest = Description body); FeedbackArgs.title: Option<String> + with_title() builder, override applied uniformly after both branches; single-line input byte-identical (echo-compat rule: trailing newline = single line)
  - Gotcha: multi-line-with-trailing-blank trims to single line — compat rule beats title promotion; struct-literal construction of FeedbackArgs is breaking for downstream (doc example in src/feedback.rs needed title: None — doc tests caught it)
  - Title precedence documented in modules.md § feedback (flag > first stdin line > auto-reported error > generic); CHANGELOG [Unreleased] compat note added
  - 515 tests green, ah check --run-tests 95 passed, clippy/fmt/pretender clean; commits + beads closes pushed (b0740a9)
  - **Next:** genesis-dvf (P2 testaruda feedback wiring — can now use --title), genesis-ntg (P0 epic), downstream git_hooks migrations q4k/glc/orq (P3); unreleased feedback changes → next release will be 0.8.1 or bundle into 0.9
- 2026-09-29T12:08:44Z [id:d2e07457721f93d674e25249c5a4c83bf0e70b1724a12327959d8ed2f3a64236] ### 2026-09-29 12:10 — release v0.8.1
  - Patch release: feedback full-stdin read (genesis-og6) + title option (genesis-gle); version 0.8.1, README git-tag example bumped (doc_sync guard requires tag = "v0.8.1" present; caret pin 0.8 unchanged), CHANGELOG stamped [0.8.1] — 2026-09-28
  - CI publish succeeded; crates.io shows 0.8.1 (12:08 UTC 2026-09-29); just notify-downstream 0.8.1 opened issues in all 7 downstream repos
  - Gotcha: first git commit attempt was silently swallowed by a lefthook pre-commit failure (tail -1 hid the error) — files stayed staged, push said up-to-date; rerun commit with full output to diagnose
  - Note for next feature release: title field addition is struct-literal-breaking for downstream → real minor bump (0.9.0) at next feature; 0.8.1 defensible because ::new callers are unaffected
  - **Next:** genesis-dvf (P2), genesis-ntg (P0), git_hooks migrations q4k/glc/orq (P3)

### 2026-09-30 19:48 — snap
- genesis-2ex phases 1-2 shipped: `genesis::update_check` feature-gated module (cached-passive, fail-silent, CI-aware), 18 hermetic tests, openspec change add-update-check + deployed spec + `.espectacular` contracts; commits 3455f1c, 62a9232 (fixed CI red on main — doc paths to docs/src/), abbea01 (tool-name agnosticism scrub). CI + Docs green on main.
- Tool-agnosticism enforced: genesis-side artifacts use neutral `mytool`; key fact — wai's crate is `wai-cli` (crates.io `wai` is unrelated), dependents must pass CARGO_PKG_NAME.
- Rule-of-5 review of the changes: READY, 0 CRITICAL/HIGH; hardening ticket filed (selection via first-element, crate_name validation, hermetic env test, clock skew, 2s/5s timeout, request-path contract test, debug signal for silent 404s).
- genesis-2ex still open: phase 3 = downstream wiring (wai/pretender/testaruda, one ticket per repo) + doctor/version pull-check reuse.
- **Next:** fix CI (verify — CI currently green on main; check for other red workflows) and release a new genesis version (v0.9.0): `just ci` → bump Cargo.toml + versions.ddl.toml → tag → `just publish` → `just notify-downstream`.
- 2026-09-30T23:02:35Z [id:05d9eaa176212ba46d0b29889f5c4d4804a71a14ae4e6299fa0fd32dcb07be53] ### 2026-09-30 23:59 — snap (genesis-4mq + v0.9.0)
  - genesis-4mq done via red→green: 7 RED tests (equal-timestamp selection, crate-name validation incl. traversal, backoff preserves known-good latest, future checked_at stale, 5s total budget via 3s-response server, request-path lock, debug stderr via subprocess --exact --nocapture pattern) then GREEN in src/update_check.rs: first-stable-entry selection (find, clippy-rejected filter().next()), is_valid_crate_name guard in cache_path+check_with, backoff_entry() preserving prior latest/published_at, TOTAL_TIMEOUT 2s→5s (consts now pub), GENESIS_UPDATE_CHECK_DEBUG debug_emit() with HTTP-status vs transport split (404 no longer mislabeled transport error)
  - Subprocess stderr test pattern that works: Command::new(current_exe()).args(["--exact", child_name, "--nocapture"]).stderr(piped); child doubles as a regular fail-silent test
  - Contract a-binary-wires-its-own-crate-name.toml now maps request_path_is_the_crate_endpoint; spec unchanged (no timeout/debug requirements pinned)
  - Released v0.9.0: just ci green, Cargo.toml 0.9.0 + README/docs pins same-commit (doc_sync guard), CHANGELOG stamped [0.9.0] — 2026-09-30, tag pushed, crates.io max_stable 0.9.0, just notify-downstream 0.9.0 → all 7 downstream repos
  - genesis-4mq closed + export committed; tree clean, main pushed
  - **Next:** genesis-2ex phase 3 (downstream update-check wiring, one ticket per repo), genesis-dvf (P2), genesis-ntg (P0 epic), downstream git_hooks migrations q4k/glc/orq (P3)

### 2026-10-01 12:36 — snap
- Mined ../tv corpus (3.5M words, direct transcript passes) → genesis feature investigation; ran Rule-of-5 reviews on the investigation and the specs; created openspec change `add-artifact-provenance` (proposal/design/tasks/5 spec deltas, `--strict` valid) covering provenance footers, ManagedBlockDrift lint, receipt terminal-outcome eval check, aix-gap feedback kind. Filed 8 beads tickets (genesis-fg3, 3xf, aii, 1mm, d6x, ihq, a3k, fkt) with deps, metadata.files + base_commit anchors, meters/anti-goals; ran issue-review → READY_TO_WORK.
- Key decision: footer hash (no timestamp) to keep generator determinism; mutating scoping stays caller-side (no AgentStep change); claims decomposition + contract-test utility + revocation explicitly deferred as future changes.
- Working tree has untracked openspec/changes/add-artifact-provenance/ + .beads updates — not committed/pushed yet.
- **Next:** pick up `genesis-fg3` (managed-block provenance footer, TDD red first); then {3xf, aii, d6x} in parallel; before closing, run session-close flow (git pull --rebase && git push) — work not yet pushed.
- 2026-10-01T16:52:25Z [id:404194805b8af8fb3044f8206e4aa79ba74f9ef9882238242e80f3e089451890] ### 2026-10-01 13:52 — snap (genesis-39r fix + v0.10.1 release + wai wiring done)
  - genesis-39r red→green: cache_path honored XDG_CACHE_HOME as HOME-like dir (appended .cache); now XDG is the cache root per spec + scratch.rs precedent; released v0.10.1 (tag pushed, crates.io max_stable confirmed, notify-downstream hit all 7)
  - wai update-check wiring DONE: wai-r3p0 closed — main.rs maybe_notify_update() after commands::run Ok, notice on stderr via env!(CARGO_PKG_NAME)/CARGO_PKG_VERSION, feature update-check enabled; hermetic tests/update_notice_test.rs seeds wai-cli.json at XDG_CACHE_HOME/genesis/update-check/; full suite 1198 passed
  - Parallel session collision in wai: another agent closed wai-uz6i (crate name is wai-cli NOT 'wai' — genesis-4mq EXCL-002 live), refined tests, committed first (28ad3d3); reconciled cleanly on top
  - Tidy: all 30 wai test helper files set GENESIS_NO_UPDATE_CHECK=1 so suite is immune to real ~/.cache state (was breaking why_no_llm integration test)
  - genesis-2ex phase-3 recipe recorded as ticket comment; **Next:** pretender + testaruda wiring (fresh sessions; create ticket per repo, then same recipe), genesis-dvf (P2), genesis-ntg (P0 epic), git_hooks migrations q4k/glc/orq (P3)
- 2026-10-01T17:13:53Z [id:a325bac74a8a1eb6cfebaada9b878a19c5d1d4a4aec152182c48dee80be9035b] ### 2026-10-01 session 2 — genesis-sci closed + genesis-fg3 done (provenance footer §1)
  - genesis-sci closed (v0.10.1 already shipped); cleaned build artifacts docs/book/ + stray docs/src/https:/; committed validated add-artifact-provenance openspec scaffold (75d958f)
  - genesis-fg3 red→green→refactor in src/managed_block.rs (7957703): RED 1.1 footer-less byte-identity golden; GREEN with_provenance(generator) writes '<!-- provenance: generator=… version=… source=… sha=… -->' inside end marker; hash = content_sha8 (DefaultHasher/hash_one, repro_hash style, 8 hex) over content excluding footer line — version bump doesn't move hash; round-trip re-inject updates sha; 29 managed_block tests green, suite 575, clippy/fmt/doc-test/pretender/ah clean
  - Beads gotcha: bd close does NOT auto-refresh .beads/issues.jsonl (embedded mode) — run 'bd export -o .beads/issues.jsonl' then 'git add -f' (.beads partially gitignored but issues.jsonl is tracked); pushed 2e05d4d
  - **Next:** §2 aix provenance (genesis-3xf/d6x family), §3 ManagedBlockDrift (genesis-aii), §4 receipt check (genesis-1mm), genesis-ntg P0 epic
- 2026-10-01T17:18:35Z [id:804bc155d079ab60e55ef75da206c60e61440d8271027f331b854e7d8854ce2c] ### 2026-10-01 session 2b — §2 aix provenance done (genesis-3xf closed)
  - RED 2.1 determinism+footer-free guard; GREEN: generate_{llms,llm}_txt_with_provenance + *_timestamped (caller-supplied RFC3339 ts, no new dep) + generate_llms_txt_bounded_with_provenance; final line '# provenance: generator=genesis version=… sha=…' blank-line separated; hash = managed_block::content_sha8 over footer-free content (version bump safe); bounded ladder degrades first, footer hashes degraded content
  - Test gotcha: stage-3 degradation renders module bullets '- `m`' not headings; aix-check live guard confirms shipped llms.txt/llm.txt unchanged
  - 580 tests green, clippy/fmt/doc-test/aix-check clean; pushed 9772333
  - **Next:** §3 ManagedBlockDrift (genesis-aii — reuse content_sha8+provenance_footer, LintCheck impl in suite_linter.rs, registry wiring), §4 receipt check (genesis-1mm), §5 aix-gap kind (genesis-d6x), §6 docs; then genesis-ntg P0 epic
- 2026-10-01T17:20:08Z [id:686dba35dca02160af8d01a2942480ec3e128a7a55ab23d54640aab9acc8f5b7] ### 2026-10-01 14:20 — snap
  - Session 2 wrapped: genesis-fg3 (managed-block provenance footer) + genesis-3xf (aix footer variants) both closed, all red→green cycles green, pushed through 9772333
  - add-artifact-provenance change progress: §1 ✓ §2 ✓ — remaining §3 ManagedBlockDrift (genesis-aii), §4 receipt check (genesis-1mm), §5 aix-gap kind (genesis-d6x), §6 docs
  - Reusable now: content_sha8 + provenance_footer (pub in managed_block.rs) for the §3 drift lint
  - **Next:** §3 ManagedBlockDrift LintCheck in suite_linter.rs (hash fast-path, full-text fallback, LinterRegistry wiring) — claim genesis-aii, TDD per tasks.md §3
- 2026-10-01T17:31:21Z [id:9851d578d22217f074a86ff1a37e95b5cf85fd727703b0db7f6c9b783f5409b4] ### 2026-10-01 session 3 — §3 ManagedBlockDrift done (genesis-aii closed)
  - RED 3.1/3.3/3.4 (7 tests) then GREEN: ManagedBlockDrift + DriftTarget in suite_linter.rs (284 lines). Per-target: file+block+expected content+caller fix command. Footer present → hash fast path (sha vs content_sha8 of footer-free body); footer-less → full-text compare. Drift=Warning (message names file+block, carries fix), block absent=Advisory
  - Gotcha: inject format is {content}\n{footer}\n — split_provenance_footer must strip the separator newline too or the hash never matches (caught by test_current_block_no_finding)
  - 480 lib tests green, clippy/fmt/doc-test/pretender/ah clean; pushed 8d56ff5 (beads export folded in)
  - Parallel session committed f28be68 (lefthook bd hooks chaining, DDL-0tp) — reconciled cleanly
  - **Next:** §4 receipt check (genesis-1mm), §5 aix-gap kind (genesis-d6x), §6 docs; then genesis-ntg P0 epic
- 2026-10-01T17:38:23Z [id:242edf162e647ecdaeeb129b82278be61d2f7ee650a370fe99b9b4815cbced81] ### 2026-10-01 session 3b — §4 receipt check done (genesis-1mm closed)
  - receipt_records_terminal_outcome(step) in evals.rs: parses /receipt/terminal_outcome inline via serde_json pointer (no EnvelopeOutcome change, design D4). Pass when receipt outcome consistent with ok; tool_fault when missing or success-over-ok:false (cites contradiction)
  - 5 RED tests then GREEN incl. composition test: Scenario with ok_envelope + receipt check — unrelated check unaffected when only receipt missing
  - 485 lib tests green, clippy/fmt/doc-test/pretender/ah clean; pushed cae2aed
  - **Next:** §5 aix-gap kind (genesis-d6x — add to VALID_KINDS in feedback.rs), §6 docs; then genesis-ntg P0 epic
- 2026-10-01T17:44:02Z [id:4325cefe7bf2b71a7ffd41862fa282d2f01adca6d44a308c57bd195c78aba7d0] ### 2026-10-01 session 3c — §5 aix-gap kind done (genesis-d6x closed)
  - 'aix-gap' added to VALID_KINDS (feedback.rs) — validation/redaction/ContextBundle routing untouched; near-misses aix_gap/aixgap get typo suggestions from the existing engine
  - E2E test: ContextBundle (sync exit 1, footer hint) → from_feedback_context → scenario.run(recorded error-envelope transcript) passes; this test was green pre-GREEN since conversion is kind-agnostic
  - Test gotcha: FeedbackArgs::new(kind, dry_run, from_last_error) — acceptance test needs from_last_error=true + write_scratch, else 'No issue content specified'
  - 488 lib tests green, clippy/fmt/doc-test/ah clean; pushed 1e217db
  - **Next:** §6 docs & validation of add-artifact-provenance, then genesis-ntg P0 epic
- 2026-10-01T17:47:47Z [id:025c3988186007e924ba5a02e56a4fc5e356dde6223cfdc047ff420b4eabec28] ### 2026-10-01 session 3d — §6 done; add-artifact-provenance COMPLETE
  - All tasks [x]: CHANGELOG [Unreleased] entry (footer, ManagedBlockDrift, receipt check, aix-gap); openspec validate --strict passed; aix-check confirms llms.txt/llm.txt current; module docs were already current from §1-§2
  - Follow-up tickets created: wai-jfc4, dont-0x6t, pretender-ivo, testaruda-p7m0 (per-repo with_provenance + DriftTarget adoption); genesis-3ps P2 (CI eval-gate recipe, deps on the four)
  - just ci green; pushed 8287faa
  - **Next:** change is archive-ready (openspec-archive); genesis-ntg P0 epic; genesis-2ex remaining repos
- 2026-10-01T17:58:28Z [id:1c6934decfbf34b7e2b9af0ebb29e6712099489699371c2d97e87d17eee28d8e] ### 2026-10-01 session 3e — add-artifact-provenance ARCHIVED + v0.11.0 released
  - openspec archive: deltas applied to 5 deployed specs (managed-block, suite-linter, evals, feedback, aix); validate --strict clean except pre-existing update-check spec failures (in-flight add-update-check change, 8/12 — fix belongs there)
  - Push was blocked by espectacular pre-push hook: 15 new deployed scenarios had no contract tomls ('no-toml'). Wrote 15 .espectacular stubs mapping each scenario to its existing cargo test (archetype PF, authored_with 0.3.0); ah check clean; pushed 78d26f2
  - v0.11.0: Cargo.toml + README/docs pins '0.10'→'0.11' + git tag pin 'v0.10.1'→'v0.11.0' (doc_sync guard catches the tag pin!) + CHANGELOG stamped; tag pushed, just publish OK, crates.io max_stable 0.11.0 confirmed, notify-downstream hit all 7
  - Known race: tag-triggered Publish workflow may fail 'crate already exists' — benign
  - **Next:** genesis-ntg P0 epic; adoption tickets wai-jfc4/dont-0x6t/pretender-ivo/testaruda-p7m0; genesis-3ps CI eval-gate; add-update-check remains 8/12

### 2026-10-09 17:49 — snap
- Audited git dependence across the charly-vibes suite (8 tools shell out or link git2), wrote it up as bd epic genesis-tpf + openspec change `add-git-interface` (proposal/tasks/spec, 19 scenarios + contract TOMLs; `ah check --changes add-git-interface` green). Two Rule-of-5 passes (audit, then proposal) with TypeSafe verification; fixes baked in: EnvPolicy opt-in env hygiene, declared failure semantics (+`*_lossy`), enumeration sets (uncommitted ⊇ untracked / changed_files excludes untracked), unborn-HEAD fallback, single-path check-ignore tri-state, tracked+content_hash requirements.
- Filed epic `genesis-tpf` (epic) with 8 tickets: `.1` implement `genesis::git` (P1, release-tag gate), `.2`–`.8` per-repo migrations, all blocked on `.1`. Created repo-local twins: testaruda-licv, espectacular-o77, pretender-4hc, dont-9gry, whisper-tlp, DDL-u8u, wai-jhut — cross-linked via external-ref both ways, lane/complexity labels + meters + anti-goals applied.
- Uncommitted: `.beads` exports across 8 repos (wai shows pending export), genesis openspec change dir. Push NOT done (needs explicit authorization). Throwaway testaruda-20nx created+closed during probing.
- **Next:** get authorization, commit+push the 8 repos' beads JSONL + genesis change dir; then start `genesis-tpf.1` (RED tests first per tasks.md 1.1).
