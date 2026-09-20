# pretender

CLI tool for code quality metrics: cyclomatic complexity, ABC score, etc. Universal model over tree-sitter adapters for multiple languages.

## Status
maintained/healthy — CI green (toolchain pinned), all deps current, bd backlog 0 open; 312 tests

## Tasks
- [x] Bootstrap repo (wai, beads, openspec)
- [x] Ro5-Universal review on all setup docs
- [x] Issue-review + dependency graph (23 tickets, 24 edges)
- [x] `pretender-9kx` — Tracer bullet: cyclomatic complexity on Python files
- [x] `pretender-zsu` — History feedback loop for cognitive_max violations (P2)
- [x] `pretender-a80` — Diff-only mode: git2 integration for staged files and diff-base (P3)
- [x] `pretender-hay` — Native pre-commit hook generator (install/uninstall with safety guards)
- [x] `pretender-b5o` — Implement universal code model types
- [x] `pretender-jy9` — Implement pure metric functions
- [x] `pretender-8ai` — 5 additional languages (Go, Java, Ruby, C, C++)
- [x] `pretender-4eh` — ABC scoring with smell weights
- [x] `pretender-3b5` — `pretender report` command
- [x] `pretender-9hk` — External metric plugin wrappers (eslint, ruff, clippy, staticcheck)
- [x] `pretender-xgn` — Structural duplication detection (pretender duplication)
- [x] `pretender-238` — Mutation testing wrapper (pretender mutation)
- [x] `pretender-vuc` — P4: `pretender explain <metric>`
- [x] 2026-09-20 — CI unbroken: PR #12 (clippy 1.98 lints + walk filter), 4 P1s closed; beads → no-db mode
- [x] `pretender-hrw` — CI toolchain pinned to `dtolnay/rust-toolchain@1.98` (PR #13)
- [x] 2026-09-20 — Dependabot wave 11/11 merged (tree-sitter 0.25 grammars + actions majors; PR #14 fixed python queries)
- [x] `pretender-x3p` — flaky feedback test isolated via private XDG_CACHE_HOME (PR #15)

## Notes
- tree-sitter grammars now 0.25 (python/go/js); python 0.25 folds `except*` into `except_clause` — behavior preserved
- CI toolchain pinned to `@1.98` minor branch; bump alongside local `rustup update`
- Merging PRs that touch `.github/workflows/*`: gh token lacks `workflow` scope (SSH auth, can't re-auth) → local `--no-ff` merge + push over SSH (see whisper env.md)
- beads no-db mode: issues.jsonl is the source of truth; sync = plain git push
- bd close's JSONL write can be reverted by a git autostash — re-grep status after staging before trusting the commit
- Known flaky surface eliminated (x3p); remaining advisories in cli_test.rs are pre-existing shape (file >400 lines)
- Universal model: Module → CodeUnit → Block → Branch; each language adapter produces the model; metrics are language-agnostic
- tree-sitter 0.23 with matching tree-sitter-python
- cyclomatic = 1 + branch count (if/elif/for/while/except/logical/ternary)
- Fixture: `tests/fixtures/python_simple.py` with 6 callables across complexity levels
- git2 integration: staged_files() diffs index vs HEAD (None tree = empty repo safe); diff_base_files() diffs tree to tree; empty-staging short-circuits before directory walk
- Pre-commit hook uses `--staged`; `--staged` and `--diff-only` are mutually exclusive via clap conflicts_with
- install/uninstall are symmetric: both refuse to touch hooks not installed by Pretender (PRE_COMMIT_HOOK_MARKER check)
- pre_commit_hook_contents() is built from PRE_COMMIT_HOOK_MARKER constant — cannot drift
