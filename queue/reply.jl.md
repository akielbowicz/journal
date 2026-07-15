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
