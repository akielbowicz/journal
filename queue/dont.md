# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 15:39 — dont

- Evaluated codebase completeness: ~60% done (63/105 issues closed); three in-progress specs (rule engine, spawn/harness, import system) each block large clusters
- Claimed and implemented `dont-8os` — `.dont/` directory layout validation in `Project::open()` with `LayoutInvalid` error variant, exit code 3, and `dont init` remediation hint
- Ran Rule of 5 review; found `REQUIRED_SUBDIRS` divergence (HIGH), misleading error message (LOW), and inconsistent test teardown (LOW) — all three fixed
- Committed `feat(layout): validate .dont/ subdirectory layout on project open`
- **Next:** push the commit, then pick up next unblocked issue — shell completions (`dont-8h2`) or config.toml sections (`dont-2tl`, `dont-h8c`, `dont-gl0`) are all ready

---
