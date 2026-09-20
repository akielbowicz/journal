# REPLy.jl — repo infra facts

- Beads: `.beads/` is gitignored but `issues.jsonl` is tracked; staging requires `git add -f .beads/issues.jsonl`.
- `bd dolt push` fails (2026-09-17): dolt internal error "this operation must be run in a work tree" — beads state syncs via git-committed `issues.jsonl` instead.
- Local tag `v0.3.0` diverges from origin; `git pull --rebase` emits a would-clobber warning (harmless for branch pushes).
- Tests: `julia --project=. -e 'using Pkg; Pkg.test(test_args=["<testset filter>"])'` (~3 min full run).
- Stale `.cov` files accumulate in src/ and test/ (gitignored coverage artifacts); `aek-analysis/` is untracked leftover eval-harness work (2026-08-07).
