# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-07 15:57 — dont

- Created 5 new `improve-cli-ergonomics` tickets: `dont-ehv` (spec sync), `dont-9xa` (human output), `dont-08l` (evidence rendering), `dont-fb1` (CURIE/short-ULID resolution), `dont-khn` (universal flags); plus `dont-72t` (hypothesis/atom subcommands) and `dont-3so` (milestone validation).
- Ran two rounds of `issue-review`: first pass split `dont-08l`, added "Done when:" criteria to all tickets, folded task 1.3 into `dont-ehv`, created validation milestone `dont-3so`.
- Second pass caught missing `dont-72t` → `dont-08l` dependency (payload types need entities first); added it with `bd dep add dont-08l dont-72t`.
- Patched `dont-3so` with a formal "Done when:" criterion using verified `openspec validate --all --strict` syntax.
- **Next:** Start `dont-ehv` — sync OpenSpec spec files to shipped `trust`/`flag`/`undoubt` semantics; also verify `openspec validate --help` syntax before closing.

---
