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

## 2026-04-30 18:22 — clojnder

- Implemented `clojnder-dnh`: `Clay Preview: Open` command opens a split panel in JupyterLab main area using `@jupyterlab/coreutils` for URL handling
- Fixed editable-install packaging bug (dropped `-e` from Binder Dockerfile); extension now loads as `clay-jupyter-proxy v0.1.0 enabled OK`
- 15/15 pytest tests green; bundle built and committed; `clojnder-dnh` closed and pushed
- **Next:** `clojnder-lni` (status + restart controls in the preview panel) or `clojnder-a2e` (render a selected `.clj` source file)

---
## 2026-04-30 18:23 — tRAGar

- Completed slice-5: browser smoke test (`tests/browser/tracer-bullet.spec.ts`) with Playwright + Chromium headless
- Built `dist/js/tragar.js` via Bun browser bundle; wired `just build-js` and `just test-browser` recipes
- `just test-browser` works from cold state (build + 1 browser test in ~2s); all 59 unit tests still pass
- Closed `tRAG-lll`; committed and pushed `f4b7451`
- **Next:** `tRAG-x83` — OPFS/IndexedDB persistence slice (TDD, same pattern as previous slices)

---
