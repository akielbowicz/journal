

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
