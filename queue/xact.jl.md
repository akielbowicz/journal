# Queue: xact.jl

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-08 15:39 — xact.jl

- Fixed 5 open bugs via TDD→RO5U→fix→commit workflow: dimension-dependent vanishing (Canonical.jl), Ricci trace registration (Def.jl), SortCovDs on scalar commutator (Canonical.jl), perturb() index preservation (Pert.jl), parser silent corruption + parenthesized expression handling (Canonical.jl)
- Fixed docs CI pipeline (Qt6Base_jll version pin in docs/Manifest.toml)
- Fixed `_has_top_level_sum` to track () depth (caught by docs smoke test)
- Added `_push_chunk!` patterns for `(N/D)(expr)`, `tensor (N/D)(expr)`, `(N/D)*tensor(expr)`, and `(expr) tensor[...]` parenthesized expression parsing
- JuliaFormatter applied to all changed files

**Next:** sxAct-crfm (fresh Session() no-op symbol-validation hooks) or sxAct-zvpd (missing reset!() convenience)

---
