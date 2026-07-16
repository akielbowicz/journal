# Queue: reply.jl

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-15 20:32 — reply.jl

- Implemented replyc CLI auto-install: deps/build.jl with scratch-space env, overwrite guard, UUID marker, and `--project`-pinned launcher (resolves REPLy from build-time path since it's not registered)
- Created docs/src/howto-cli-install.md covering auto and manual install paths, PATH setup, troubleshooting
- Ran Rule of 5 review on the full change set; fixed all findings: spec/impl mismatch (JULIA_PROJECT → --project), guard tightened to `startswith(lines[2])`, wrong Troubleshooting section replaced, stale-path limitation documented, build_test.jl added to test suite
- All 2428 tests pass; change archived and pushed to main
- **Next:** manual validation tests (ticket 1.4) — global env drift, overwrite guard, clean rebuild, outer JULIA_PROJECT override (all confirmed working during implementation)

---

## 2026-07-15 22:34 — reply.jl

- Fixed 3 P0 bugs from evaluation reports: cap-degradation regression test added, AuditMiddleware wired into default_middleware_stack(), Base.invokelatest fix for world-age binding visibility in clone/ls-bindings
- Synced ResourceLimits field names and defaults to match spec table (max_repr_bytes→max_value_repr_bytes, 12 fields total, spec-compliance regression test)
- Added FIFO eval queue for max_concurrent_evals (spec REQ-RPL-047d): _eval_acquire_slot/_eval_release_slot with Threads.Condition, 2× limit queue capacity
- Fixed replyc spurious 'nothing' echo for println-style evals (string comparison for "nothing" instead of isnothing)
- Restricted test-pre-push hook to .jl/.toml file changes (always_run=false, files filter)
- Disabled Aqua persistent_tasks check in CI (path-based dep can't precompile cleanly)
- **Next:** P3 features — streaming stdout (REPLy_jl-3oz) or trusted-session mode (REPLy_jl-k9i)

---

## 2026-07-16 15:36 — reply.jl

- Created 17 openspec change proposals from the integrated assessment, split per Part E execution order (5 release blockers P0, 6 structural P1, 10 improvements P2+)
- Created 26 beads issues with correct dependency chains, acceptance criteria, estimates, and gate labels
- Fixed test hang: `collect_until_done` infinite loop in `test/helpers/tcp_client.jl` (empty `readline` at EOF with `isopen` always true) — added `eof(sock)` guard
- Fixed `handle_client!` handler exception crash in `src/transport/tcp.jl` — now catches handler exceptions and returns error responses instead of dropping the connection
- Updated 3 test files with 2-arg handler signatures to match `handle_client!(msg, stream)` API
- All 2496 tests pass
- **Next:** start implementing P0 release blockers — Step 1 (fix-audit-entries-race) or R1 (apply CLI installer patch upstream)

---
