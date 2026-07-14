# Queue: cositos

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-14 16:52 — cositos

- Fixed Julia `send_state!` identity re-merge bug (`cositos-cvc`): on full send, now merges `model_identity`/`view_identity` into state, mirroring Python's `cositos-k43` fix
- Updated protocol spec with "Full State Send Includes Immutable Identity Fields" requirement (4 scenarios)
- Added regression test in `host_tests.jl` asserting identity fields present after full `send_state!`
- Pushed to main (55ce62c)
- **Next:** verify R tests (Rscript not available), or pick up next ticket from `bd ready`

---