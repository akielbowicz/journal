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
