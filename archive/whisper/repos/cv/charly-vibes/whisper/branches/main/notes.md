### 2026-09-05 17:51 — snap
- Scaffolded whisper-vibes v0.3.0 end-to-end: deterministic workspace CLI (key/resolve/append/init/status/check), turu rename (aliases turututu+whisper), doctor with fix hints, turu sync managed block in AGENTS.md, skill_pack shipping the whisper skill (11 files, content-hashed)
- Incitaciones whisper skill converted to thin pointer; DDL registration filed in dulce-de-leche; dogfooded .turu/skills + AGENTS.md block in this repo
- All pushed: whisper (f090323, 0948e2a), incitaciones (395a15e), dulce-de-leche (41a51d3)
- **Next:** implement 'turu consolidate' (detection already in doctor); then DDL/homebrew registration; verify incitaciones npx skill install picks up the thin pointer

### 2026-09-16 — ci.yml shipped (whisper-bez closed)
- Added `.github/workflows/ci.yml` on push/PR to main + workflow_dispatch; runs `just ci` for local/CI parity (genesis pattern)
- Justfile gained `ci: fmt-check lint test build-locked` and `build-locked` — the `--locked` build verifies Cargo.lock sync before release.yml's `cargo publish --locked` would trip on it
- `just ci` green locally (14 tests, clippy -D warnings); committed `1664c56`, pushed, ticket closed
- **Next:** `whisper-ae0` — implement `turu consolidate` (legacy repo-key dir migration; detection already in doctor); optionally port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s release workflow

### 2026-09-16 16:0x — turu consolidate shipped (whisper-ae0 closed)
- Implemented `workspace::consolidate()` (TDD, 5 new tests): wholesale rename when canonical dir absent; per-entry move without conflict, else text merge by extending with trimmed-line dedup; legacy dirs removed after
- New `Consolidate` subcommand emits moved/merged manifest + hint `turu doctor — the legacy-keys check must pass`; doctor fix hint now real
- **Safety fix folded in:** `legacy_variants` colon rule matched any dir with a colon — real false positive in this very workspace (`ak:akielbowicz`, a multi-repo legacy root with other repos' knowledge). Detection now requires the post-colon path to equal the bare repo name; regression test added. Detection that warns can be loose; detection that moves data cannot
- End-to-end verified against a synthetic workspace: check → consolidate → doctor pass
- Cargo quirk hit twice: `cargo build` claims fresh but target/debug/turu is stale after src changes (hardlinked bins); `cargo clean -p whisper-vibes` before smoke-testing binaries
- Committed `e217adf`, pushed; both whisper tickets now closed
- **Next:** optionally port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s release workflow; consider version bump v0.4.0 (consolidate + ci.yml) via tag push

### 2026-09-15 15:57 — snap
- Shipped both whisper tickets: `whisper-bez` (ci.yml + `just ci` with build-locked, commit `1664c56`) and `whisper-ae0` (`turu consolidate` — move/merge migration with line-dedup, commit `e217adf`)
- Folded-in safety fix: `legacy_variants` colon rule tightened (colon dir must end in bare repo name) after finding real false positive `ak:akielbowicz` in ~/.whisper holding other repos' knowledge
- All gates green, both repos pushed, tickets closed, knowledge routed
- **Next:** port `bins/`/`dist/` gitignore + darwin-triple fixes to `dont`'s failed release workflow; consider tagging v0.4.0 (consolidate + CI) to exercise release.yml end-to-end
- 2026-09-17T16:22:03Z [id:7adb4b097bc0d7e1fbdeedb68f0af1e3dac365f8d798d53eef537855121279ed] (#session) ### 2026-09-17 13:21 — snap
  - Fixed GH #1 (relative repo workspace_root anchors to config dir) + whisper-122 follow-up (doctor/check shadowed-global warning); shipped v0.5.0
  - Wired `turu feedback` via genesis::feedback (whisper-1ug) incl. error-scratch contract + genesis compat fixture; Rule-of-5 fixes; shipped v0.6.0
  - **Next:** whisper-kt5 — decide shared-bundle transport (in-repo dir vs git-refs vs remote); tag creation should be a separate step from `git pull --rebase` (vanished twice in && chains)
- 2026-09-25T16:30:31Z [id:3b2c0f97af7d94ede5a2013b520c6e602fa51f64a794fd39a0d0382e9910b557] (#self-improvement) Self-improvement architecture comparison (hermes-agent vs turu): Hermes runs an LLM-autonomous loop — memory tool with frozen prompt injection + char budget, skill_manage procedural memory, post-turn background review fork, and a curator (usage telemetry → active/stale/archived, opt-in LLM umbrella consolidation, archive-never-delete). We run a deterministic substrate: agent proposes via CLI verbs only, binary owns routing/merge/commit (pure-function repo keys, two-phase distill with immutable revisions, supersede-never-delete). Four stealable ideas: (1) usage telemetry — recall should track use_count/last_recalled so doctor/distill get staleness signal, the curator's core insight that self-improvement without usage tracking is a landfill; (2) advisory lint on append/distill-begin for incident-log-shaped entries (lessons not logs); (3) encode Hermes' umbrella rubric in distill guidance — 'would a maintainer write N entries or one with N sections?'; (4) enforce search-before-append like Hermes' read-before-write refusal. We're ahead on: pure-function keys vs machine-local flat files, immutable distill revisions vs tar rollback, scope routing as published contract, no LLM in write-critical paths.
- 2026-09-28T17:07:56Z [id:d0befac836a914bbd8cb73d18fae53cbcad85c8a8f21145aef10347eb6686676] (#session) ### 2026-09-28 — usage telemetry shipped (whisper-t6j closed, commit 57e1586)
  - New usage.rs: append-only machine-local sidecar (<stem>.usage.jsonl next to scope file), one {id, ts} JSONL record per served recall via single O_APPEND write; tolerant readers skip corrupt lines, append-only keeps them
  - recall records ONLY entries actually served (filtered/budget-skipped never recorded); --no-usage escape; sidecar write best-effort (telemetry failure never fails recall); TURU_NOW respected via parse_or_now(env)
  - doctor gains turu.usage-staleness (Ro5 gates: last_recalled >90d stale; never-used beyond 30d grace; superseded exempt; absent sidecar = pass)
  - distill --begin envelope now exposes per-entry recency {use_count, last_recalled} so the rewrite pass can prune dead entries; omitted when no telemetry
  - Sidecar excluded from bundles by construction (bundles carry scope files, never siblings); follows consolidate moves automatically
  - Gotchas: clippy cloned_ref_to_slice_refs fires on &[e.id.clone()] (use std::slice::from_ref); doctor test counts pass:N — new check made it 9
  - **Next:** whisper-4xl (append lint, now unblocked) or inbox workspace-hygiene pass (legacy colon-key dirs + journal archive mirrors)
- 2026-09-28T17:15:36Z [id:f5d65e38898142d5005ed35a6c935c770c03f9798e95c9c6abdc3609c670b681] (#session) ### 2026-09-28 (2) — incident-log lint shipped (whisper-4xl closed)
  - entry::incident_log_density: advisory lint, ≥3 date/id-like tokens per 500 chars (divisor floored at 500, tunable consts LINT_TOKENS/LINT_WINDOW/LINT_ID_MAX); token classes: ISO dates (digits≥6 + seps, bare times like 10:00 stay quiet), hex ids ≥8 incl. a digit (deadbeef/cafe stay quiet), #123 issue refs
  - Wired into append (lints the incoming text) and distill --begin (lints snapshot ENTRY TEXTS, never raw file — [id:...] markers would false-positive every well-formed file); both via envelope warnings[], advisory only
  - Trim gotcha of the day: trim_matches strips # itself (non-alphanumeric) so is_issue_ref saw no prefix — trim_end_matches keeps the #; also if-let chains collapsed for clippy 2024
  - **Next:** inbox workspace-hygiene pass (turu doctor → consolidate on live ~/.whisper, prune journal archive mirrors) or bump v0.7.0 (t6j + 4xl) via tag push
- 2026-09-28T18:06:56Z [id:370252b0e654454007eadc9d2e028a55afd147e8f480eb5df69b9507f7c910e8] (#session) ### 2026-09-28 15:06 — snap
  - Shipped whisper-t6j (usage telemetry: usage.rs O_APPEND sidecar, recall --no-usage, doctor turu.usage-staleness 90d/30d gates, distill --begin recency) commit 57e1586, and whisper-4xl (advisory incident-log lint: entry::incident_log_density ≥3 date/id-like tokens per 500 chars, wired into append + distill --begin warnings[], trim_matches-ate-the-# bug caught by red phase) commits e01ec53 + b6e6e48 — all pushed, both tickets closed
  - just ci green (105 tests); gotchas routed: trim_matches strips # (use trim_end_matches), clippy cloned_ref_to_slice_refs, doctor pass-count tests shift when checks are added
  - **Next:** tag v0.7.0 (git tag v0.7.0 && git push --tags) to exercise release.yml with both features; then inbox workspace-hygiene pass (turu doctor → turu consolidate on live ~/.whisper, prune journal archive mirrors)
- 2026-09-28T19:50:19Z [id:516b6f51d169fba6cbf16ab6bd5886c55a3e4c605df89a55099d536fa2df8d4a] (#session) ### 2026-09-28 16:50 — snap
  - kt5 decided: option A (in-repo .whisper/) with deterministic private zone (.whisper/private/, gitignored) — privacy is a path, not a policy; scaffolded add-repo-private-scope (proposal/design/3 spec deltas/tasks), validated strict, pushed e25478c
  - Ro5 review applied (commit 8011f5a): store-major recall composition, git check-ignore as effective-ignore truth, pack refuses private-resolved scopes, consolidate guard reworded, worktree stays global + terminology block
  - Implementation tickets filed via create-issues: whisper-6fv (repo-local root, READY) -> whisper-eiy (private zone) -> {whisper-4xo (transport guards), whisper-7eo (init/doctor/docs)}; all AFK, deps wired, base_commit 8011f5a anchored
  - Note: .beads is gitignored here — no dolt remote configured, local Dolt is the store; git tree clean/pushed
  - **Next:** approve proposal -> close whisper-kt5 -> openspec archive add-shared-bundle --yes -> claim whisper-6fv (its precondition is the archive step)
