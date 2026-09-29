

## Migrated from charly-vibes

# dulce-de-leche env

## Genesis adoption (v0.2.0+)

Uses these genesis v0.4.0 modules:
- guide (CliVerbosity progressive -v/-vv/-vvv, CliFormat auto-detect --json for pipes)
- cli (generate_completions, maybe_print_version_json)
- config (DdlConfig implementing ConfigFile trait)
- fixture (in tests/)
- aix (agents_block generation)
- envelope, doctor, status, suggestions, suite_linter (pre-existing)

## Important CLI behaviors

- Output format auto-detects: TTY → human, piped/redirected → JSON envelopes
  Use `--human` to force human output in non-TTY contexts
- Verbosity uses counts: `-v` = verbose, `-vv` = debug
- All commands support `--json` except `completions` (always plain shell text)
- `ddl scope` also supports `--json` (returns `{"ddl_dir": "...}"}`)

## Windows install-path gotchas (DDL-71i/DDL-2rb, smoke-verified 2026-09-15)

- LockFileEx byte-range locks (fs2 lock_exclusive) block EVERY other handle on
  Windows, including one in the same process — never reopen a file you hold a
  lock on; do all I/O through the locking handle (read_manifest_from /
  write_manifest_to in dot_ddl.rs). Deterministic os error 33, invisible on
  Unix. with_sharing_retry (exponential, 6 attempts) covers genuine AV locks
  on open/lock only.
- secrets.GITHUB_TOKEN is NOT auto-exposed as an env var in Actions steps —
  set `GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}` at job level for ddl's
  github_client() (DDL-2rb) to activate; otherwise shared-runner IPs exhaust
  the anonymous 60 req/hr quota and installs 403 intermittently.
- Workflow events from the default GITHUB_TOKEN do not trigger other
  workflows: release-published smoke never auto-fires for releases created by
  the release workflow — dispatch manually (ddl_version input) or give the
  release workflow a PAT.
- Expand-Archive requires a .zip extension; Git Bash's GNU tar cannot read
  zip. macOS tar.gz extraction drops the exec bit — chmod +x after untar.
## bd / beads (updated 2026-09-28)
- `bd dolt push` requiere **bd ≥1.3.0**: 1.0.4 tiene un bug upstream en embedded mode (`git rev-parse --show-toplevel` en contexto bare → exit 128). Schema migrada v32→v66 el 2026-09-28 (esta máquina = migrador designado). Otras máquinas: `bd bootstrap`, NO `migrate`.
- El wrapper ICU `~/.local/bin/bd` fue eliminado (apuntaba a Cellar/bd/1.0.4, borrado por el upgrade). `bd` = brew 1.3.0.
- `bd init --from-jsonl` importa el JSONL **commiteado**, no el working tree. Borrar `.beads/embeddeddolt` a mitad de sesión + re-init = pérdida silenciosa de issues no exportados; el auto-export posterior registra la regresión en git. Borrar el DB solo con export explícito previo.
- `no-db: true` en `.beads/config.yaml` NO es un storage mode en bd 1.x (solo "no abrir la DB por invocación"); Dolt es el único backend. Corregido con nota en el config.
- `issues.jsonl` está gitignoreado como `.beads` pero trackeado → `git add -f` necesario.
- Registry ddl v0.6.0: bd + openspec agregados (bd: binary assets `beads_*` con binario `bd`, sin cargo fallback — `beads` en crates.io es crate no relacionado; openspec: npm scoped `@fission-ai/openspec`).
- Arquitectura decidida (evaluada y descartada): NO importar los CLI tools como libs en ddl — orchestrator + subprocess; la única frontera lib correcta es genesis. Release = `git tag vX.Y.Z && git push --tags` (GHA: 3 builds + crates.io + tap/scoop; TAP_GITHUB_TOKEN sigue sin configurar → tap falla, ver DDL-2um).
