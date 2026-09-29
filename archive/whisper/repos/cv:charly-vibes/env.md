# charly-vibes suite — environment notes

## Beads stores (migrated 2026-09-29)
- **All 30 repos** run bd **embedded** (in-process Dolt) with **`no-db: true`** — `.beads/issues.jsonl` committed to git is the source of truth and the sync mechanism.
- There is **no dolt remote and no `bd dolt push/pull`** in this suite — never run those commands; git push is the sync.
- Schema was reconciled v32→v66 on 2026-09-29 by a single designated migrator, then published via `bd dolt push` (one-time, before the no-db switch).
- Root suite-index repo (`~/para/areas/dev/gh/charly`) has **no git remote** — commits there are local-only by design.
- Cross-repo blocking can't be encoded per-store; the root store (`charly-7f5`) is the cross-repo index epic.
- bd-injected BEADS INTEGRATION blocks in AGENTS.md/CLAUDE.md were rewritten (2026-09-29) to forbid dolt commands; if a repo's block mentions `bd dolt push`, it's stale — fix it, don't obey it.

## Genesis dependency policy
- Shared crate `genesis-vibes` (github: charly-vibes/genesis); bump all dependents on release. Check its **CHANGELOG compat notes** (not GH issues) — API breaks are documented there, e.g. 0.8.1 `FeedbackArgs.title` struct-literal break.
- `genesis::git_hooks` (0.8.0) is the way to install git hooks; bespoke install logic (pretender/wai/espectacular donors) should migrate onto it (tickets genesis-q4k/-orq/-glc).

## Known broken
- fotos pre-push hook fails outside distrobox (leptonica/pipewire) — pushes need `--no-verify` until fixed.
- Old bd stores auto-spawn legacy `dolt sql-server` processes on write — if `ps` shows stray servers, kill them.
