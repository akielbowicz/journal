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

## 2026-05-08 15:25 — dont

- Completed `improve-cli-ergonomics` OpenSpec change (16/16): human-readable default output, ANSI status colors, structured evidence rendering, stdin ID piping, spec/doc updates, full validation — archived as `2026-05-08-improve-cli-ergonomics`
- Closed stale `dont-3n8` (colour output — already implemented) and `dont-td5` (project-layout specs — already shipped as earlier OpenSpec change)
- 7 issues now ready; working tree clean at `c67b5c6`
- **Next:** `dont-3so` — validate the `improve-cli-ergonomics` milestone; then work through remaining 6 ready issues

---
