# Queue: elegua

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-08 12:02 — elegua

- Fixed F18 (CRITICAL): Wolfram oracle server auth — changed default bind to 127.0.0.1, added `@app.before_request` Bearer token auth, `OracleClient` token forwarding, Docker Compose port scoped to loopback
- Fixed F17 (CRITICAL): SympyAdapter RCE — restricted `parse_expr` namespace via `local_dict=_SAFE_LOCALS`, `global_dict={}`, 6 new security tests
- Fixed F5: `just test` bootstrap — added `pytest.importorskip("sympy")` to sympy test files so `just test` works on clean checkout without `--extra sympy`
- Fixed CI: vale-action `files` input accepts only a single folder name; narrowed scope to `docs/`

**Next:** elegua-3v4l (F12 — NaN treated as agreement, p1 correctness hole) or elegua-2e4f (F8 — SympyAdapter timeout leaks daemon thread, p1)

---

## 2026-07-08 15:39 — elegua

- Fixed F12 (elegua-3v4l, P1 correctness hole): non-finite NaN/Inf now included in `numeric_samples` with `non_finite: True` flag instead of silent drop; L4 comparator treats both-NaN as agreement, one-NaN-one-finite as mismatch
- Fixed F8 (elegua-2e4f, P1 thread leak): replaced daemon-thread timeout with `multiprocessing.Process` — subprocess terminated/killed on timeout, verified no leaked threads via `threading.enumerate()`
- Fixed CI lint: moved `import pickle` to module top, removed quotes from type annotation

**Next:** P2 issues remain — elegua-c3p9 (F23: CLI + __all__), elegua-a89j (F21: deprecated API in docs), or openspec changes