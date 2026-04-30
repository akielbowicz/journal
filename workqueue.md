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

## 2026-04-30 16:38 — clojnder

- Designed a detailed implementation plan for a full-featured JupyterLab Clay Preview: in-Lab panel, backend control API, explicit file render flow, active-file follow, save-triggered rerender, recovery UX, and Binder packaging.
- Translated the plan into 10 Beads issues with tracer-bullet vertical slices, including 2 HITL decision tickets and 13 dependency links.
- Key first execution path is now clear: settle preview defaults/UX policy, then start   `clojnder-6kq` (extension scaffolding).
- **Next:** review and resolve   `clojnder-s2i` and   `clojnder-6gq`, then claim   `clojnder-6kq` to begin implementation.

---
