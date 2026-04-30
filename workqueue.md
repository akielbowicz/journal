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

## 2026-04-29 18:30 — tRAGar

- Ran Rule of 5 universal review on `SPEC.md` + 8 OpenSpec capability specs; found 2 critical, 10 high, 8 medium, 7 low issues.
- Fixed all 27 issues: OPFS SyncAccessHandle contradiction, namespace path injection, int8 dot product accumulation width, tombstones encoding, RegExp filter boundary, ingest atomicity, concurrency serialization, and 20+ clarity/edge-case gaps.
- All 8 capability spec files received frontmatter headers and mirrored fixes; changes committed and pushed.
- **Next:** run `openspec validate add-initial-capabilities --strict` (task 2.1) and `openspec archive` (task 3.1) to close out the proposal lifecycle; then begin implementation.

---
## 2026-04-30 10:27 — REPLy.jl

- Completed all 13 holistic-review passes (`REPLy_jl-umg`): security, modularity, performance, DX/docs, formal-verification, and synthesis passes all closed.
- Phase 1 (security floor): 6 pre-exposure vectors fixed — `LookupMiddleware` RCE, bounded message reader, `LoadFileMiddleware` deny-by-default, module field isolation, TCP connection limit, bounded stdin channel. All 1915 tests green, committed and pushed.
- 41 implementation tickets remain open (all P1/P2): Phase 2 = session lifecycle races (close/eval, clone TOCTOU, alias detachment, `clients` vector locking), Phase 3 = eval throughput + docs.
- **Next:** start Phase 2 — session lifecycle correctness: `REPLy_jl-h7o` (close/eval race), `REPLy_jl-na0` (alias detachment), `REPLy_jl-6fh` (clone publish race), then `clients`/`client_tasks` locking.

---
