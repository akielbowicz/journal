# Work Queue

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-04-23 16:27 — ruta

- Worked on `add-session-per-spec-layout` epic (`ruta-6nj`); claimed and closed cleanup task `ruta-6nj.8`
- Added missing `chavruta/` and `spec/` entries to `.gitignore` per spec §5.1
- Committed untracked openspec change files (proposals, specs, tasks for both open changes)
- All 95 tests and `npm run check` pass; epic now at 8/9 tasks complete
- **Next:** `ruta-6nj.9` (canonical spec sync) deferred to 2026-05-06 — run `bd ready` for next available work

---

## 2026-04-23 17:05 — ruta

- Marked all 25 openspec tasks complete in `openspec/changes/add-session-per-spec-layout/tasks.md`
- Archived `add-session-per-spec-layout` via `/openspec-archive`; updated `spec/ruta.md`
- Committed and pushed archive + spec changes to `main`
- **Next:** `ruta-6nj.9` (canonical spec sync) deferred to 2026-05-06; run `bd ready` for any new open work

---

## 2026-04-24 13:07 — XAct.jl

- Reviewed the new notebook-improvement bd tickets with the installed issue-review skill and ran a second pass after fixing them.
- Created the parent epic sxAct-l4xp[0m and shared infra ticket sxAct-0bua[0m for notebook smoke-test validation, then updated all notebook tickets with explicit source-of-truth files, verification commands, and tighter scope.
- Wired dependencies so all notebook tickets depend on the shared validation task; Python and Pluto onboarding also depend on the Julia basics ticket.
- **Next:** claim sxAct-0bua[0m and implement the shared notebook smoke-test workflow, then start on the highest-priority notebook fixes that depend on it.

---
## 2026-04-24 14:47 — XAct.jl

- Implemented shared notebook smoke-test infrastructure (`scripts/notebook_smoke.jl`, `just test-notebooks`) and documented the Julia-vs-Python notebook validation policy in `CONTRIBUTING.md` and `docs/src/contributing.md`.
- Added notebook smoke coverage to `test/julia/test_docs.jl`, then completed two notebook tickets end-to-end: `sxAct-d9xg` (2-sphere notebook now explicitly validates Gaussian/scalar curvature and corrects the 2D Einstein-tensor discussion) and `sxAct-js4u` (EM notebook now explicitly checks Faraday antisymmetry and the homogeneous Maxwell/Bianchi identity, while downgrading the Lorenz-gauge section to explanatory context).
- Verified with `Pkg.test()`, `julia --project=docs docs/make.jl`, and `julia --project=. scripts/notebook_smoke.jl`; committed repo changes as `8d304a4`, `a8628b8`, and `d0bb962`.
- **Next:** continue the notebook-review queue one ticket at a time, with `sxAct-eo57` (Schwarzschild) as the next highest-priority docs notebook to tighten and verify.

---
