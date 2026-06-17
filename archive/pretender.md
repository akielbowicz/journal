# pretender

CLI tool for code quality metrics: cyclomatic complexity, ABC score, etc. Universal model over tree-sitter adapters for multiple languages.

## Status
implement phase — mutation testing wrapper shipped; 149 tests passing; 1 open issue

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

## Notes
- Universal model: Module → CodeUnit → Block → Branch; each language adapter produces the model; metrics are language-agnostic
- tree-sitter 0.23 with matching tree-sitter-python
- cyclomatic = 1 + branch count (if/elif/for/while/except/logical/ternary)
- Fixture: `tests/fixtures/python_simple.py` with 6 callables across complexity levels
- git2 integration: staged_files() diffs index vs HEAD (None tree = empty repo safe); diff_base_files() diffs tree to tree; empty-staging short-circuits before directory walk
- Pre-commit hook uses `--staged`; `--staged` and `--diff-only` are mutually exclusive via clap conflicts_with
- install/uninstall are symmetric: both refuse to touch hooks not installed by Pretender (PRE_COMMIT_HOOK_MARKER check)
- pre_commit_hook_contents() is built from PRE_COMMIT_HOOK_MARKER constant — cannot drift
