# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 09:33 — dont

- Implemented `dont atom define <claim> --text ...` and `dont atom dismiss <claim> <idx> --evidence ...` in `src/cli/atom.rs`
- Added atom persistence to `dont.db` and `ClaimView` rendering in `src/lib/atom.rs`
- Added CLI integration tests in `tests/atom.rs`; marked OpenSpec task 3.1 complete; closed `dont-72t`
- Committed and pushed: `42ab037 feat(cli): add atom management subcommands`
- **Next:** Pick up next OpenSpec `improve-cli-ergonomics` task (2/16 complete); run `bd ready` and check `openspec status`

---
