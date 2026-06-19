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

## 2026-06-19 11:09 — dont

- Implemented `dont-kxg`: `dt` binary alias with strictly-separated positive-framing vocabulary — single binary detects `argv[0]`, routes `dt record/challenge/lock` to `conclude/trust/forget`, and errors cross-vocab calls with suggestions ("unknown command 'conclude' for dt. Did you mean 'dt record'?")
- Cargo.toml: added `[[bin]] name = "dt"` pointing at same `src/main.rs`; `active_interface()` checks basename of argv[0]; `cross_vocab_refusal()` builds the structured error
- `dont lock` is now `dt`-exclusive (errors in `dont` mode); updated 3 existing tests (`glossary_alignment`, `lock`, `invocation_flags`) to use `dont forget`
- 10 new acceptance tests in `tests/dt_alias.rs`; all 77 test suites green; pushed to main as `6362d4a`
- **Next:** `dont-dq2f` (P3) — `dont trust` semantics are counterintuitive; improve help text to make the double-negative framing explicit and less surprising; verify resolution against `dont-cli-surface/spec.md`

---
