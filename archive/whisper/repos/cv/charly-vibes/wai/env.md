

## Migrated from wai


## 2026-07-28: genesis adoption

wai now depends on the `genesis` shared crate (git tag v0.1.0):
- `genesis::suggestions` — SuggestionEngine, CommandRegistry (was local src/suggestions.rs)
- `genesis::managed_block` — BlockInjector, BlockRegistry, InjectResult (was local injector mechanics)
- `genesis::envelope` — Envelope, EnvelopeKind, ErrorResult (replaces bare JSON output)

Key files: src/lib.rs (re-export), src/managed_block.rs (thin wrapper), src/output.rs (print_envelope helpers)

## 2026-08-05: tracker authority

The local and remote wai Dolt databases have unrelated histories, and a fresh
remote bootstrap lacks the `issue_prefix` metadata required for ticket creation.
Per project-owner direction, do not force-push, bootstrap over, or attempt to
repair Dolt during routine issue work. Treat `wai/.beads/issues.jsonl` as the
authoritative local export and refresh it explicitly with:

```bash
bd export -o .beads/issues.jsonl
```

## 2026-09-25: pre-push hook + flaky test

The lefthook pre-push hook runs the full lib test suite and blocks pushes on
any failure. `plugin::tests::execute_hook_no_deadlock_on_fast_command` is
timing-flaky: it can fail under parallel load while passing in isolation and
in full re-runs (filed as wai-z25x). If a push is blocked by it, re-run the
push rather than reaching for --no-verify. Cosmetic noise: `git add` prints
ignored-path hints for `.beads/backup/*` — harmless, commits land fine.
# wai — repo environment notes
## docs/cartography (2026-09-02)
- Cartography reports live in `docs/cartography/`: 12 markdown artifacts of record + self-contained HTML views + `index.html` + `assets/` (vendored `mermaid.min.js` v9.4.3 IIFE, shared `cartography.css`).
- Regeneration path is re-running the codebase-cartography skill — there is deliberately NO build pipeline or render script (skill v0.8.0 invariant; a pandoc-based `scripts/render-cartography.sh` existed briefly and was deleted as superseded).
- Reports are evidence snapshots: counts (fan-in, file sizes, check counts) drift with `src/`; every claim carries file:line so drift is visible on re-run.
- 2026-10-03T18:11:01Z [id:57014b754115dfa35b37bb7d787886cc9d21a48d7974c5fabf1d48d93f4fad25] 
  ## 2026-10-03: docs deploy conventions (mdbook 0.5 fallout)
  - book.toml build-dir = "docs/_book" (root book.toml, src = docs/src) — the upload-pages-artifact path must be docs/_book, not book/.
  - Archived openspec specs (spec.md.archived, e.g. bead-lifecycle) are skipped by the spec-copy loop; a spec dir without spec.md used to hard-fail docs.yml.
  - docs.yml paths filter covers only docs/** and Cargo.toml — workflow-file changes (.github/workflows/*) do NOT trigger docs; dispatch manually (`gh workflow run docs.yml --ref main`).
  - Tag-ref docs runs: v2026.10.3 tag run failed at build stage (predates fixes). Versioned snapshots per tag need workflow_dispatch-with-input or similar (filed wai-35zh).
