# REPLy.jl / replyc

Julia REPL-over-socket server (REPLy.jl) + CLI (replyc). MCP adapter included.
Repo: sk:sashakile/REPLy.jl · Branch: main · Tracked via beads (`REPLy_jl-*`).

## Tasks

- [ ] Coordinated openspec proposal for the eval-lifecycle cluster (REPLy_jl-2rv5.7 orphan evals + .8 session state machine + .12 zombie semantics) — one proposal, per 2026-09-17 review decision
- [ ] REPLy_jl-nv28 (P0, hitl): decide hard vs cooperative timeout for non-yielding evals; blocks REPLy_jl-q8dz
- [ ] P1 bug batch: 2yu2 stdin-buffer overflow, aufw message/ID limits, l92t payload bounds, nv69 socket unlink, c5vs malformed-JSON contract, mrc0 session-close serialization
- [ ] 2rv5.6 expects enforcement — DONE 2026-09-17 (c7f424a) under openspec change enforce-middleware-validation (delta extended; archive still pending)
- [ ] Headers batches 2rv5.19-.22; docstrings 2rv5.17; test gaps 2rv5.13-.16; remaining spec gaps 2rv5.9-.11
- [ ] Deferred: Lazy Test scan (/skill:test-abstraction-miner); dont CLI evidence-detach limitation

## Notes

- Whole-library review epic REPLy_jl-2rv5 closed 2026-09-17 (5 passes, 17 findings filed .6-.22)
- Workflow: TDD → ro5u → fix → commit per ticket; `ah check` noise is baseline (156 structural no-tests-declared)
- No worktree; work happens on main, conventional commits with beads ID
