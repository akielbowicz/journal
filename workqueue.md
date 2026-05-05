# Work Queue

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-04-23 16:27 — ruta

- Worked on `add-session-per-spec-layout` epic (`ruta-6nj`); claimed and closed cleanup task `ruta-6nj.8`
- Added missing `chavruta/` and `spec/` entries to `.gitignore` per spec §5.1
- Committed untracked openspec change files (proposals, specs, tasks for both open changes)
- All 95 tests and `npm run check` pass; epic now at 8/9 tasks complete
- **Next:** `ruta-6nj.9` (canonical spec sync) deferred to 2026-05-06 — run `bd ready` for next available work

---

## 2026-04-23 17:05 — ruta

- Marked all 25 openspec tasks complete in `openspec/changes/add-session-per-spec-layout/tasks.md`
- Archived `add-session-per-spec-layout` via `/openspec-archive`; updated `spec/ruta.md`
- Committed and pushed archive + spec changes to `main`
- **Next:** `ruta-6nj.9` (canonical spec sync) deferred to 2026-05-06; run `bd ready` for any new open work

---

## 2026-04-30 10:37 — paranoid

- Implemented Slice A of usage-audit history & drill-down (PARANOID-p5i.6) via TDD: RecentDaysEnumerator, DailyHistoryPresenter, DayDetailPresenter, plus UsageAuditDayDetailActivity and layout
- Wired History list to render past days (today excluded) and tap-through to Day Detail; UsageAuditData extended with recentDays
- All unit tests green via `just test`; OpenSpec validates strict; closed PARANOID-p5i.6
- **Next:** start Slice B (PARANOID-p5i.7) — Day Detail hourly distribution + scoped Share/CSV; reuse DailyUsageAggregator with hourly bucketing (DST-aware) and add overnight summary inside Day Detail

---
## 2026-04-30 14:31 — XAct.jl

- Created 9 beads tickets: migration epic (sxAct-9u7t) + 2 migration subtasks (nd7v, ltaa) + 6 unimplemented module tickets (xTerior, TexAct, Harmonics, xPrint, SymManipulator, SpinFrames)
- Ran 5-pass issue review; found CRITICAL circular epic dep and HIGH duplicate with sxAct-bsd; applied all fixes (removed circular deps, superseded bsd, rewired Spinors dep chain, added acceptance criteria and TDD entry points to all module tickets)
- **Next:** begin migration work — claim `sxAct-nd7v` (changelog audit → `docs/migration/xact-1.3.0-analysis.md`), then `sxAct-ltaa` (update oracle pin + regenerate snapshots)

---

## 2026-04-30 16:51 — XAct.jl

- Claimed `sxAct-nd7v` and wrote `docs/migration/xact-1.3.0-analysis.md` auditing xAct 1.2.0 → 1.3.0.
- Identified primary migration/parity risks in `xPerm` (`RightTransversal`) and `xTensor` (`InertHeadArgumentCount`, complex inner-vbundle metrics), plus corrected the `xPert 1.1.0` assumption.
- Ran Rule-of-5 review on the analysis doc, then revised it to separate migration-critical modules from roadmap-only packages and to clarify same-version bundle-content drift (`xTerior`).
- **Next:** update `sxAct-ltaa` with the finalized breaking-change list, then begin the oracle pin and snapshot-regeneration work.

---

## 2026-04-30 17:00 — tRAGar

- Scaffolded OpenSpec change `add-tracer-bullet-vertical-slice` (proposal, tasks, design) with minimal/dev-first strategy
- Created 6 tracer-bullet implementation beads tickets (tRAG-5ip → tRAG-lll plus 3 follow-ons) with dependency chain
- Implemented `tRAG-5ip` (Bootstrap skeleton): TDD — 10 TS tests (bun) + 8 C++ doctests all green; TS types/wrapper, C++ core, Embind scaffold, CMake preset
- **Next:** claim and implement `tRAG-32j` — deterministic in-memory ingest/query slice (Embind bridge gets real, `ingest()` + `query()` with memory store + custom embedder)

---
## 2026-04-30 17:28 — tRAGar

- Reviewed tRAG-32j (Slice 2: deterministic ingest/query); closed 3 pending decisions: tRAG-kiw (markdown-only ingest), tRAG-gmr (chars/4 tokenizer), tRAG-36t (main-thread async, v0.3 Worker forward-compat)
- Confirmed Slice 2 was already committed (`1f38d48`) — all 32 tests green, types/impl/demo updated, `tRAG-32j` closed
- **Next:** pick up the newly unblocked follow-ons — `tRAG-6to` (queryStream bridge), `tRAG-jzo` (transformers.js embedder), `tRAG-lll` (shipped browser smoke test), or `tRAG-x83` (OPFS persistence)

---
## 2026-04-30 17:52 — tRAGar

- Closed tRAG-9eb (model decision): keep `Xenova/all-MiniLM-L6-v2` as English default; multilingual as explicit opt-in
- Implemented tRAG-jzo (transformers.js embedder seam): lazy-load on first `embed()`, per-config pipeline cache, `TRAGarError("EmbedderLoadFailed")`, `embedders.transformers()` public API, `TRAGarError` extracted to `js/errors.ts`; 46/46 tests green, pushed
- **Next:** claim and implement `tRAG-6to` — `queryStream()` async iterator + `std::generator` → Embind bridge with early-break cleanup

---

## 2026-04-30 18:02 — tRAGar

- Implemented `tRAG-6to`: `queryStream()` async iterator on `TRAGarMemoryInstance` (embed → score → sort → yield k hits)
- Added `queryStream(text, opts?): AsyncIterable<Hit>` to `TRAGarInstance` interface in `js/types.ts`
- 13 TDD tests in `js/tests/slice-querystream.test.ts` (surface shape, hit fields, ordering, k cap, empty corpus, early break, close-after-break, InstanceClosed/InvalidConfig errors); 59/59 green
- Closed `tRAG-6to`; pushed `b3ec1ed feat(slice-4): queryStream() async iterator over scored hits`
- **Next:** pick up `tRAG-x83` (OPFS/IndexedDB persistence slice) or `tRAG-lll` (browser smoke test)

---

## 2026-04-30 18:23 — tRAGar

- Completed slice-5: browser smoke test (`tests/browser/tracer-bullet.spec.ts`) with Playwright + Chromium headless
- Built `dist/js/tragar.js` via Bun browser bundle; wired `just build-js` and `just test-browser` recipes
- `just test-browser` works from cold state (build + 1 browser test in ~2s); all 59 unit tests still pass
- Closed `tRAG-lll`; committed and pushed `f4b7451`
- **Next:** `tRAG-x83` — OPFS/IndexedDB persistence slice (TDD, same pattern as previous slices)

---

## 2026-05-02 20:00 — paranoid

- Committed leftover Slice A code (PARANOID-p5i.6) as `09a34b1` — bead was closed two sessions ago (2026-04-30 morning) but the code never landed on `main`; resume noticed and recovered
- Implemented Slice B of usage-audit history & drill-down (PARANOID-p5i.7) via TDD; committed as `d9b9403`:
  - **Domain:** `HourlyBucket` model + `DailyUsageAggregator.hourlyDistribution(...)` walking the window in 1h real-time steps; produces 23/24/25 buckets on spring-forward / normal / fall-back days
  - **Presentation:** `DayDetailScreenState` extended with `hourlyBars` + `overnightSummary`; `DayDetailPresenter` accepts hourly buckets and an optional `OvernightAudit`, rendering the overnight panel only when its `windowStart` is inside the selected day
  - **UI:** Day Detail layout adds hourly-bars container, overnight summary panel, Share Summary / Export CSV buttons; activity renders bars and overnight panel and wires the buttons
  - **Data layer:** `UsageAuditData.recentDayHourlyBuckets` precomputes per-day buckets keyed by day-start; matching overnight from existing `recentNights`
  - **Share/CSV:** reuses `TodaySummaryFormatter` / `CsvExporter.exportToday` on the selected day's summary — v1 schema preserved (no hourly/interval columns)
- 5 new tests in `HourlyDistributionTest`, 4 new in `DayDetailPresenterTest`, 2 new in `UsageAuditExportTest`. All unit tests green via `just test`; OpenSpec strict-validates; bead PARANOID-p5i.7 closed
- **Decisions:** hourly walk uses `+= 3_600_000` (real-time) rather than `Calendar.add(HOUR_OF_DAY, 1)` — equivalent under DST given 23/24/25h day windows, avoids the spring-forward "phantom hour" ambiguity. Did not add hourly buckets to `DailyUsageSummary` (kept the domain model render-shape-free); precomputed at the data provider instead
- **Next:** Slice C (PARANOID-p5i.8) — App Detail drill-down: `UsageStatsManager.queryEvents` adapter for per-app foreground intervals, App Detail screen, no-activity + uninstalled-package states, Day Detail row → App Detail navigation. Tail tickets PARANOID-p5i.9 (manual device verification + functionality.md update) and tasks 3.7 (unify Today/Day Detail render paths) + 1.10 (tidy day-window helpers) still open

---

## 2026-05-04 17:02 — XAct.jl

- Researched existing sxAct benchmark infrastructure for Wolfram-vs-Julia/Python comparisons: `xact-test benchmark`, `sxact.benchmarks.runner`, adapters, oracle server, and TOML benchmark candidates.
- Created valid OpenSpec proposal `add-cross-adapter-benchmark-suite` with proposal/design/tasks/spec delta for lightweight cross-adapter benchmarking.
- Captured key decision: primary benchmark medians must discount adapter init, oracle health checks, xAct loading, context creation, and file setup; these are reported as setup/cold-start metadata.
- Created bd issue `sxAct-w9b2` to implement the approved proposal later.
- **Next:** review/approve the OpenSpec proposal, then implement runner tests for setup-time discounting and skip/tag handling first.

---


## 2026-05-05 09:40 — paranoid

- Closed the three remaining agent-doable tasks in OpenSpec change `add-usage-audit-history-drilldown` (1.2 DST/past-day aggregator tests, 1.10 extracted `RecentDaysEnumerator.startOfLocalDay()`, 3.7 extracted `DailyUsageSummary.toAppRows()` to unify Today/Day Detail rendering)
- `just test` green, `openspec validate add-usage-audit-history-drilldown --strict` passes; change is now 30/30 ✓ Complete
- Committed `9b5a19c` and pushed to `origin/main`; pre-staged `.beads/issues.jsonl` and unstaged `.claude/settings.local.json` left untouched (not authored this session)
- **Next:** create a new release/version of `paranoid` — likely involves bumping versionCode/versionName, tagging, building signed APK via `just`, and updating CHANGELOG.md

---


## 2026-05-05 10:15 — paranoid

- Cut release **v0.7.0** for paranoid covering usage-audit history & drill-down
- Archived OpenSpec change `add-usage-audit-history-drilldown` → `2026-05-05-add-usage-audit-history-drilldown`; spec applied to `openspec/specs/usage-audit/spec.md` (+3 requirements)
- Added `[v0.7.0]` CHANGELOG entry (UsageAudit History/Day Detail/App Detail/scoped Share+CSV; internal tidy + ProGuard + CI tests + package move)
- `just test` green; `just build-release` fails locally (no signing env) — CI `release.yml` handles signing on tag push
- Committed `59b0f3f`, tagged `v0.7.0` (annotated), pushed `main` + tag to `cv:charly-vibes/paranoid.git`
- CI workflow `Release APK` should now build & publish split APKs (arm64-v8a, armeabi-v7a, x86_64) to a GitHub Release
- `.beads/issues.jsonl` (staged) and `.claude/settings.local.json` (unstaged) left untouched per prior session
- **Next:** verify the GitHub Actions release run succeeded & APKs uploaded; then handle the 2026-04-24 inbox item (manual on-device verification of UsageAudit usage-access handoff + overnight battery snapshot)

## 2026-05-05 11:14 — dont

- Evaluated the full spec set: domain model, envelope, error taxonomy, tracer bullet design all strong; gaps identified in glossary, test strategy, split define spec, and thin MCP interface
- Deferred olog/label-validator work (`add-dont-define-label-validators`) — added explicit deferral note to tracer bullet proposal and canonical pointer in `dont-cli-core` spec
- Wrote `implement-tracer-bullet/test-strategy.md` covering envelope schema conformance, cross-process persistence, project discovery, hedge pattern, and perf seed
- Added tasks 10.6–10.10 to `implement-tracer-bullet/tasks.md` derived from test strategy
- **Next:** begin `implement-tracer-bullet` — core is fully specced and pre-tracer gaps are resolved; start with CozoDB datom schema validation (Phase 1)

---
## 2026-05-05 11:33 — dont

- Reviewed OpenSpec readiness for `dont`, then applied stale-model fixes across status lifecycle, payloads, rule engine, lifecycle verbs, derived queries, and error-code specs.
- Committed and pushed `f56a14b spec: clarify stale as derived assessment`; validation passed with `openspec validate --changes --strict` and `just ci`.
- **Next:** continue by archiving/rebasing foundational OpenSpec changes or start the scoped tracer-bullet implementation from the clarified derived-assessment model.

---
## 2026-05-05 12:36 — dont

- Implemented  tracer-bullet Phase 1 scaffold: Rust binary crate with /, clap subcommand stubs in , and CLI scaffold tests in .
- Added Available recipes:
    bd-status
    build
    ci
    default
    docs-build
    doctor
    lint
    prime
    ready
    reflect
    run *args
    show
    status
    sync
    test
    way recipes for , , , and ; wired clippy into lint and ignored .
- Marked OpenSpec tasks 1.1/1.2 complete, closed bead , advanced WAI phase to implement, and committed/pushed .
- **Next:** pick up one unblocked tracer core slice — preferably  storage datom layer, or parallel-friendly  envelope types /  status lattice.

---
## 2026-05-05 12:36 — dont

- Corrected checkpoint for the prior malformed `/next` entry: implemented `dont` tracer-bullet Phase 1 scaffold with Rust binary crate (`Cargo.toml`/`Cargo.lock`), clap subcommand stubs in `src/main.rs`, and CLI scaffold tests in `tests/cli_scaffold.rs`.
- Added `just` recipes for `build`, `test`, `lint`, and `run`; wired clippy into lint and ignored `target/`.
- Marked OpenSpec tasks 1.1/1.2 complete, closed bead `dont-s21`, advanced WAI phase to implement, and committed/pushed `5a05824 feat: scaffold Rust tracer CLI`.
- **Next:** pick up one unblocked tracer core slice — preferably `dont-82l` storage datom layer, or parallel-friendly `dont-3am` envelope types / `dont-cnw` status lattice.

---
## 2026-05-05 14:40 — dont

- Continued  tracer-bullet storage work: completed , adding , , and  for Cozo-backed datom persistence at .
- Hardened the new store after Rule-of-5 review: structured , typed /, schema-version mismatch rejection, write locking around tx allocation/writes, reopen persistence coverage, and tempdir cleanup.
- Updated  OpenSpec tasks/design to mark storage complete and document SQLite as the tracer backend; validation and CI passed.
- Committed/pushed repo changes through ; beads state pushed after closing .
- **Next:** continue tracer bullet with  JSON envelope/error types (recommended before wiring real CLI command behavior), or  status lattice.

---
