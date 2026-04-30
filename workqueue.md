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


## 2026-04-29 12:26 — REPLy.jl

- Completed holistic review passes   \'REPLy_jl-umg.6\', \'REPLy_jl-umg.7\', and \'REPLy_jl-umg.11\'; added research artifacts under \' .wai/projects/holistic-review/research/\' for session invariants, failure handling, and test-suite assessment.
- Closed the three beads tickets; no runtime code changed, but the review baseline now highlights session race hazards, fragmented failure semantics, and test-suite duplication/friction.
- Wrote a session handoff at \' .wai/projects/holistic-review/handoffs/2026-04-28_23-39-58_holistic-review-state-and-failure-review.md\'.
- **Next:** continue the holistic-review epic with \'REPLy_jl-umg.10\' (formal-verification readiness) or \'REPLy_jl-umg.8\' (security/boundary review), using the .6/.7/.11 artifacts as the baseline.

---

## 2026-04-29 15:33 — REPLy.jl

- Completed holistic-review pass `REPLy_jl-umg.10` (formal-verification readiness); saved research artifact to `.wai/projects/holistic-review/research/`.
- Identified top formalization candidates: INV-3 (session lifecycle state machine) and INV-5 (per-session FIFO via eval_lock) as Phase 1 targets in TLA+.
- Filed 5 blocking bugs: `REPLy_jl-h7o` (P1 close/eval race), `REPLy_jl-na0` (P1 alias detachment), `REPLy_jl-6fh` (P1 clone publish race), `REPLy_jl-tox` (P1 bookkeeping leak), `REPLy_jl-exj` (P2 max_sessions race).
- **Next:** continue holistic-review with `REPLy_jl-umg.8` (security/boundary review) or `REPLy_jl-umg.4` (Rule of 5 broad review); or pivot to fixing the P1 bugs filed this session.

---

## 2026-04-30 10:27 — REPLy.jl

- Completed all 13 holistic-review passes (`REPLy_jl-umg`): security, modularity, performance, DX/docs, formal-verification, and synthesis passes all closed.
- Phase 1 (security floor): 6 pre-exposure vectors fixed — `LookupMiddleware` RCE, bounded message reader, `LoadFileMiddleware` deny-by-default, module field isolation, TCP connection limit, bounded stdin channel. All 1915 tests green, committed and pushed.
- 41 implementation tickets remain open (all P1/P2): Phase 2 = session lifecycle races (close/eval, clone TOCTOU, alias detachment, `clients` vector locking), Phase 3 = eval throughput + docs.
- **Next:** start Phase 2 — session lifecycle correctness: `REPLy_jl-h7o` (close/eval race), `REPLy_jl-na0` (alias detachment), `REPLy_jl-6fh` (clone publish race), then `clients`/`client_tasks` locking.

---

## 2026-04-30 10:37 — paranoid

- Implemented Slice A of usage-audit history & drill-down (PARANOID-p5i.6) via TDD: RecentDaysEnumerator, DailyHistoryPresenter, DayDetailPresenter, plus UsageAuditDayDetailActivity and layout
- Wired History list to render past days (today excluded) and tap-through to Day Detail; UsageAuditData extended with recentDays
- All unit tests green via `just test`; OpenSpec validates strict; closed PARANOID-p5i.6
- **Next:** start Slice B (PARANOID-p5i.7) — Day Detail hourly distribution + scoped Share/CSV; reuse DailyUsageAggregator with hourly bucketing (DST-aware) and add overnight summary inside Day Detail

---
## 2026-04-30 12:52 — REPLy.jl

- Fixed all 5 P1 bugs from holistic-review: na0 (alias detachment), h7o (close/eval race), 6fh (clone publish race), tox (active_eval_tasks leak), wep (TOCTOU session re-resolve)
- Fixed P2 locking bug qr9: added `clients_lock::ReentrantLock` to TCP/Unix server handles; all `clients`/`client_tasks` mutations now atomic
- All 6 commits pushed; 1933 tests green (1 pre-existing Aqua quality error unrelated)
- **Next:** Phase 3 — performance, composition, and DX bugs (19 open P2 issues); run `bd ready` to see the list

---
## 2026-04-30 14:31 — XAct.jl

- Created 9 beads tickets: migration epic (sxAct-9u7t) + 2 migration subtasks (nd7v, ltaa) + 6 unimplemented module tickets (xTerior, TexAct, Harmonics, xPrint, SymManipulator, SpinFrames)
- Ran 5-pass issue review; found CRITICAL circular epic dep and HIGH duplicate with sxAct-bsd; applied all fixes (removed circular deps, superseded bsd, rewired Spinors dep chain, added acceptance criteria and TDD entry points to all module tickets)
- **Next:** begin migration work — claim `sxAct-nd7v` (changelog audit → `docs/migration/xact-1.3.0-analysis.md`), then `sxAct-ltaa` (update oracle pin + regenerate snapshots)

---


## 2026-04-30 16:15 — REPLy.jl

- Closed `9ms` (readline OOM DoS) — already fixed in prior security commit; closed without new code.
- Fixed `65d` (mktemp IO capture → pipe-based capture): replaced `mktemp`+`EVAL_IO_CAPTURE_LOCK` in `eval.jl` and `load_file.jl` with `Base.Pipe` async readers; 1947 tests pass.
- Fixed `1i8` (Revise hook shadow-module injection): guard `_revise_if_present` with `Base.loaded_modules` identity check against `_REVISE_PKG_ID`; added security test for injected shadow modules.
- **Next:** tackle P1 `3a9` (TCP auth) — needs auth mechanism design decision — or knock out DX doc bugs (`2j0`, `hdr`, `it7`, `dx7`, `c3z`).

---

## 2026-04-30 16:51 — XAct.jl

- Claimed `sxAct-nd7v` and wrote `docs/migration/xact-1.3.0-analysis.md` auditing xAct 1.2.0 → 1.3.0.
- Identified primary migration/parity risks in `xPerm` (`RightTransversal`) and `xTensor` (`InertHeadArgumentCount`, complex inner-vbundle metrics), plus corrected the `xPert 1.1.0` assumption.
- Ran Rule-of-5 review on the analysis doc, then revised it to separate migration-critical modules from roadmap-only packages and to clarify same-version bundle-content drift (`xTerior`).
- **Next:** update `sxAct-ltaa` with the finalized breaking-change list, then begin the oracle pin and snapshot-regeneration work.

---

## 2026-04-30 16:53 — REPLy.jl

- Worked REPLy.jl docs/API DX issue REPLy_jl-2j0; updated `docs/src/howto-sessions.md`, `docs/src/howto-mcp-adapter.md`, and `docs/src/index.md`.
- Rewrote examples to stop teaching unexported internals via `using REPLy: ...`; now lower-level symbols are explicitly qualified as `REPLy.*` and documented as embedding/middleware APIs rather than the primary public surface.
- Fixed the docs environment hiccup by resolving the docs project, then verified `julia --project=docs docs/make.jl` succeeds; closed REPLy_jl-2j0 and committed `0543662` (`docs(api): stop teaching internal REPLy symbols as primary API`).
- **Next:** push `main`, then pick the next ready P1/P2 issue from `bd ready`.

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
