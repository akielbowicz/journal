# pretender

CLI tool for code quality metrics: cyclomatic complexity, ABC score, etc. Universal model over tree-sitter adapters for multiple languages.

## Status
implement phase — pre-commit hook functional, diff-only mode shipped

## Tasks
- [x] Bootstrap repo (wai, beads, openspec)
- [x] Ro5-Universal review on all setup docs
- [x] Issue-review + dependency graph (23 tickets, 24 edges)
- [x] `pretender-9kx` — Tracer bullet: cyclomatic complexity on Python files
- [x] `pretender-zsu` — History feedback loop for cognitive_max violations (P2)
- [x] `pretender-a80` — Diff-only mode: git2 integration for staged files and diff-base (P3)
- [ ] `pretender-b5o` — P1 wave (unblocked by tracer bullet)
- [ ] `pretender-jy9` — P1 wave
- [ ] `pretender-8ai` — 5 additional languages (Go, Java, Ruby, C, C++)
- [ ] `pretender-4eh` — ABC scoring with smell weights
- [ ] `pretender-3b5` — `pretender report` command
- [ ] `pretender-9hk` — External metric plugin wrappers (P3, now unblocked)
- [ ] `pretender-vuc` — P4: `pretender explain <metric>`
- [ ] `pretender-5rk` — Design feedback-loop signal persistence for recurring structural violations

## Notes
- Universal model: Module → CodeUnit → Block → Branch; each language adapter produces the model; metrics are language-agnostic
- tree-sitter 0.23 with matching tree-sitter-python
- cyclomatic = 1 + branch count (if/elif/for/while/except/logical/ternary)
- Fixture: `tests/fixtures/python_simple.py` with 6 callables across complexity levels
- git2 integration: staged_files() diffs index vs HEAD (None tree = empty repo safe); diff_base_files() diffs tree to tree; empty-staging short-circuits before directory walk
- Pre-commit hook uses `--staged`; `--staged` and `--diff-only` are mutually exclusive via clap conflicts_with
