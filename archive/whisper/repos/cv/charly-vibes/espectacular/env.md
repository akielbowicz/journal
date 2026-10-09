

## Migrated from espectacular

# espectacular environment

## genesis crate integration
- genesis v0.4.0 at https://github.com/charly-vibes/genesis.git (bumped from v0.2.0 on 2026-07-31)
- Cargo.toml: `genesis-vibes = "0.4"` (crates.io package name)
- All 14 genesis v0.4.0 modules adopted as of 2026-07-31:
  - **Directly used in code:** envelope, config, guide, managed_block, suggestions, feedback
  - **Adopted via cli:** generate_completions, maybe_print_version_json
  - **Adopted via suite_linter:** LintResult/Severity in DoctorDiagnostic
  - **Adopted via doctor:** 9 DoctorCheck impls + DoctorRunner orchestrates all checks
  - **Adopted via discovery:** discovery::register() during ah init → .genesis/tools.toml
  - **Adopted via fixture:** Fixture builder in integration tests
  - **Adopted via scaffold:** Scaffold builder for init scaffolding
  - **Adopted via status:** StatusSection from doctor output
  - **Adopted via aix:** agents_block helper in init tests

## doctor module architecture (post-genesis adoption)
- `run_doctor()` builds a Vec<Box<dyn DoctorCheck>> via `build_checks(repo_root)`
- Checks are: ConfigCheck, VersionDriftCheck, SpecsDirCheck, ChangesDirCheck,
  CollisionCheck, OrphanContractCheck, UnknownArchetypeCheck,
  ManagedBlockCheck (per file), HookCheck
- Framework detection (pytest/cargo/vitest/property) is domain-specific — NOT in genesis
  - These produce FrameworkDetection and DoctorRecommendation types
- genesis::doctor::DoctorEntry status maps to DoctorDiagnostic severity
- `run_doctor_enable()` is tool-specific (config surgery) — NOT in genesis

## release process
- Tag-driven: `git tag vX.Y.Z && git push --tags` triggers .github/workflows/release.yml
- Builds cross-platform binaries (Linux, macOS, Windows)
- Publishes to crates.io
- Updates homebrew-charly tap and scoop-charly bucket
- CI runs pre-push hooks: lint + testaruda test ingestion

## genesis v0.2.0 adoption (2026-07-28, ticket espectacular-p10)
- `src/config.rs`: thinned to struct + `ConfigFile` impl; `load(repo_root)` goes through `ConfigStore`/`ConfigRegistry`; domain validation in `Config::validate` returns `ConfigValidation` records; `load()` surfaces Error-severity results as a hard anyhow failure. Config *writes* remain tool-owned (doctor --enable / upgrade do surgical text edits, not `Config::write`).
- `src/main.rs`: assembles `Guide::builder("ah", ...)` at startup (command registration for typo detection, `.config::<Config>()` intent marker — **no-op in v0.2.0**, reserved for future Guide-driven config wiring). Top-level error path uses `guide.error_sink()` instead of hand-rolled eprintln + scratch + footer.
- `src/suggestions.rs` deleted — typo detection now uses the guide's `CommandRegistry` via `SuggestionEngine::suggest_typo(bad_cmd, guide.registry())`.
- `chrono_now()` removed from main.rs — genesis ships its own timestamp in `ErrorSink`.

## CRITICAL: ErrorSink exit-code invariant
 genesis's `ErrorSink::handle_message` (guide.rs) **hardcodes `exit: 1`** in the `ErrorRecord` it writes to scratch. Tools using `ErrorSink` for the top-level error path MUST `std::process::exit(1)` on handler errors (NOT 2) so `feedback --from-last-error` reports a truthful exit code. The typo-subcommand path keeps exit 2 (matches clap's invalid-subcommand convention). This applies to any suite tool adopting `genesis::guide`.
- Drift guard: `AH_COMMANDS` const must stay in sync with the clap `Command` enum; a test (`ah_commands_match_clap_subcommands`) diffs both directions so typo detection can't silently drop a new subcommand.

## v0.4.0 release notes (2026-07-31)
- All 14 genesis modules adopted: cli, suite_linter, discovery, fixture, scaffold, status, aix, doctor (plus 6 previously: envelope, config, guide, managed_block, suggestions, feedback)
- Doctor refactored: 9 individual DoctorCheck impls using genesis::doctor::DoctorRunner
- Release tagged: `git tag v0.4.0` → CI builds binaries + publishes to crates.io


## Migrated from gh

# espectacular repo knowledge

## Architecture notes

### `detect_slug_collisions` — two-pass count approach

The function in `src/openspec.rs` now uses a two-pass approach: first count
occurrences per `(spec_path, id)` key, then return ALL scenarios whose key
appears more than once. Previously it only returned the 2nd, 3rd+ duplicates,
leaving the first scenario unflagged — its tests would run while colliding
scenarios were blocked, masking the collision.

### `doctor.rs` collision diagnostic

The `for (slug, _spec, _id)` destructuring was misleading: `slug` was bound
to the spec_path (e.g. "compiler"), not the actual slug. Fixed to
`(spec, slug, _heading)` with a clearer message.
## bd embedded no-db workflow (2026-09-29)
- Embedded bd does NOT auto-export `.beads/issues.jsonl` on writes (close/claim/update). Before committing tracker state, run `bd export -o .beads/issues.jsonl` or the git-committed JSONL goes stale. Hit twice in one session.
- `bd update <id> --claim` prints a stale "repair: bd dolt remote add…" hint — ignore (no dolt remote by design).
- `dont ground` in this repo fails with an internal Cozo `parser::pest` error on any claim (its generated datom-put query is malformed) — do not retry twice; embed evidence inline in tickets and flag the dont bug upstream.

## release workflow infra facts (2026-10-03)
- Docs deploy on tag refs FAILS by design: the github-pages environment protection rules only allow `main` — tag-triggered docs.yml runs get rejected ("not allowed to deploy to github-pages"). Benign; always dispatch docs.yml on main manually after a tag release.
- gh OAuth token in agent context lacks the `workflow` scope → cannot merge PRs touching .github/workflows (GraphQL refusal) — push workflow changes via git-over-SSH instead.
- dependabot Cargo PRs mutually conflict on Cargo.lock once one lands; fix-forward (apply bump on main, close PRs as superseded) is faster than @dependabot rebase rounds.
- jsonschema 0.58 resolves external $refs eagerly over HTTP — schemas cross-referencing by absolute URL need a referencing::Registry registered locally (tests/check_cli.rs).

## stale-fsmonitor hazard — verify before committing (2026-10-09)
- The repo's git fsmonitor daemon can serve STALE status: `git status`/`git diff` show clean while the worktree diverges from HEAD (recurred twice: 62cec4b "lost to a stale index blob", and the rev-18 rekey 7b2311c silently omitted 6 archive spec.md files). Masked the drift from status, pre-commit hooks, and CI triage for hours — local `spk lint` passed (worktree content) while CI lint failed (committed blobs).
- Verification habit: `git -c core.fsmonitor=false status --short` (and diff) before committing spec-corpus or generated-artifact changes; restart the daemon (`git fsmonitor--daemon stop`) when divergence is suspected.

## local spk is a dev build — corpus-drift blind spot (2026-10-09)
- `spk` on PATH is `cargo install`ed from the local path `~/para/areas/dev/gh/charly/specodelic` (v0.7.0), NOT crates.io — its lint semantics can diverge from the pinned CI release, masking corpus drift locally. Verify corpus gates with a scratch crates.io build: `CARGO_INSTALL_ROOT=/tmp/spkXXX cargo install specodelic --locked --version <pinned>`.

## CI spk pin (2026-10-09)
- ci.yml pins `specodelic 0.7.0` (bumped from 0.4.0, which was red since the rev-18 rekey). Three install steps — keep them in sync when bumping.

## testaruda integration facts (espectacular-0k8 Layer 2, 2026-10-09)
- `testaruda init` resolves the project root by walking UP for `.git` — the git repo must exist BEFORE any testaruda step; `init -q` in a non-git dir silently landed the store at /tmp (parent), making later `select` fail with "Store has not been initialized".
- Seed stores via `testaruda init` + `testaruda import graph.json` + `testaruda fingerprint` (refreshes blake3 fingerprints from disk). Graph JSON: content_units/test_items/edges/run_history, format `testaruda-graph-v1`.
- Stores NEED passing run_history entries (outcome "passed", environment "default") or SAFE-007 no-history always_run puts every test in the fallback set — selection becomes vacuous.
- `testaruda select --agent` output carries `node_id` per selected test; plain `--json` only carries integer ids (no names). EMPTY selection = exit_code 20 (data.exit_code; also process exit in CI mode).
- ah Layer 2 (released v0.10.0): consults `testaruda select --agent --files` when `.testaruda/store.db` exists; prunes non-shell contract bindings whose flags match no selected node_id; guards: select/parse failure, exit-20 EMPTY (skip refinement only), unresolved changed files, anchor guard (≥1 binding must match) — all conservative.

## Selection semantics (GH#42, 2026-10-09)
- `ah check --run-tests` selects from WORKTREE diff only (`changed_files_from_git` = `git diff --name-only HEAD`, src/main.rs:725). Empty diff → no selection signal → ALL declared contracts run (asserted by test `selection_absent_changed_files_run_everything` in src/check.rs). Pathological for pre-push: clean worktree at push time ⇒ every contract runs every push.
- Measured (tambor .gate-timing.log): espectacular-contracts 790–894s/push (~97%); wanna first measurement 522s (~87% of 9m push). SSH handshake to cv 1.6s; network not a factor.
- Fix filed: GH#42 `--base/--head` range selection, precedent = testaruda `ChangeSet::from_diff(base, head)` (testaruda-jdw5). Complementary: GH#40/bm2 batches runner spawns per (runner, test file). Deep follow-up (needs design round): delegate contract tests to testaruda — tension between ah per-contract attribution/no-tests-ran and testaruda store batching.
- ah↔testaruda coupling is zero in src/ (contract [[tests.vitest]]/[[tests.shell]] run via ah's own runner); "testaruda integration facts" above concerns Layer 2 refinement only.
- Consumer workaround pending GH#42: lefthook `--files` from push range; tambor/wanna benchmarks: espectacular's own pre-push (range-based via testaruda) = 23s median.
