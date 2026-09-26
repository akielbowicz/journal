

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
