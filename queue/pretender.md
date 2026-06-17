# Queue: pretender

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-06-17 15:32 — pretender

- Implemented `pretender mutation` command (pretender-238): wraps mutmut/cargo-mutants/stryker/pitest per language
- New `mutation.rs` module — language detection, pure parsers for all 4 tool output formats, tree-sitter operator enumeration for `--dry-run` on non-Rust languages
- `--dry-run` lists planned mutation sites; `--score-min 60` gates on mutation score; `--format json` for CI
- 31 unit tests + 1 CLI integration test (149 total, all green); pushed to `main`; issue pretender-238 closed
- **Next:** only `pretender-vuc` remains open — `pretender explain <metric>` (P4)

---
