# Queue: pretender

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-06-16 18:47 — pretender

- Implemented `pretender duplication` command (pretender-xgn): within-file structural clone detection via normalised AST subtree hashing
- New `duplication.rs` module — walks tree-sitter CST, normalises identifiers→`$VAR` / literals→`$LIT_<type>`, groups subtrees ≥10 nodes by hash
- Added `tests/fixtures/python_duplicates.py` fixture; 5 unit tests + CLI integration test updated; all 116 tests green
- Wired `--min-nodes` and `--cross-file` flags; committed and pushed to `main`
- **Next:** 2 issues remain ready — `pretender-238` (mutation testing wrapper, P3) or `pretender-vuc` (explain command, P4)

---
