# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-06-18 19:52 — dont

- Evaluated the `dont` tool UX end-to-end: tested all commands, output formats, error messages, and lifecycle flows; registered 11 issues (P1–P3 bugs and UX/semantics) in beads
- Ran `/issue-review` on the UX/semantics subset; found 3 tracker quality gaps (empty description on `dont-cd0b`, missing `dont-dq2f ↔ dont-kxg` dependency link, under-specified recommendations); applied all 4 tracker fixes
- Fixed 6 code bugs in one commit (pushed to main): `dont why/list --all/stats` human formatters were not implemented; `list --status locked` was rejected; `verify-evidence` showed `[fail]` for unchecked URIs; mode baseline warning fired on every command
- Also surfaced `--doc` required constraint and `a/an` label rule in `dont define` help text
- **Next:** `dont-dq2f` (trust naming confusion) is blocked on `dont-kxg` (dt binary alias, P2 open since May); that's the natural next issue — implement the `dt` alias with positive-framing vocabulary

---
