# Queue: pretender

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-06-18 08:26 — pretender

- Set up GitHub Actions CI (`ci.yml`: fmt/check/clippy/test + coverage via tarpaulin) and mdBook Pages deploy (`docs.yml`)
- Fixed pre-existing `cargo fmt` drift that broke CI on first push; moved fmt check to pre-push lefthook hook
- Ran `/review-documentation` → 16 quality issues fixed across all doc files (prerequisites, ACC-001 JSON contradiction, section reorder, 9 language README orientation blocks)
- Addressed all `wai way` recommendations: CONTRIBUTING.md, llm.txt, docs/status.md, .vale.ini, .devcontainer, `just book`/`book-serve`, openspec specs wired into SUMMARY.md, tarpaulin coverage job
- **Next:** `wai phase next` or `wai move pretender-mvp archives` to close the project; check tarpaulin coverage baseline from CI run and add `--fail-under` threshold if appropriate

---

## 2026-06-19 11:08 — pretender

- Closed TDD pipeline (`wai close`), then fixed all 12 open P1–P3 bugs via implement→ro5u→fix→commit loop
- Key fixes: binary file crash, config-missing warning (command-layer only), `⚠ ADVISORY` vs `✗ VIOLATION` by mode, duplicate `--defaults` removed, `fmt_metric` for clean float display, `--verbose` flag for check output, staged/diff-only empty-result message, `complexity` multi-path + threshold markers, `junit`/`markdown` removed from `--format` enum
- Each fix reviewed with `/rule-of-5-universal`; caught test assertion bugs, doc drift (openspec + status.md), and a silent UX regression (unintended indentation) before commit
- 12 beads closed, 13 commits pushed; all 173 tests green
- **Next:** `wai phase next` or `wai move pretender-mvp archives` to close the MVP project; consider `add-doctor-command` OpenSpec implementation (0/18 tasks)

---

## 2026-07-07 12:25 — pretender

- Fixed `--version` flag (pretender-bdv): added version attribute to clap derive macro; now consistent with `wai`/`dont`/`ah`
- Fixed silent failure on unsupported-language paths (pretender-4uh): `pretender check <dir>` now emits stderr warning when no files match a supported grammar
- Both fixes TDD: wrote failing test first, then implementation — all 72 integration tests green
- 2 beads closed, 2 commits pushed to main
- **Next:** the next ready issue from `bd ready`, or `wai phase next` / `wai move pretender-mvp archives`

---
