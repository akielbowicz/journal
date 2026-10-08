# Environment — canticos

## bin/ scripts live in-repo, symlinked into ~/.local/bin
- `bin/projector-queue` and `bin/to-projector` are symlinked from `~/.local/bin/` into this repo.
- **NOT chezmoi-managed** — do not `chezmoi add` them (they resolve to symlinks, not files); commit changes here in canticos.
- `projector-queue <dir> -- -n` for dry runs: flags before `--` are swallowed as the queue-dir arg (pre-existing quirk, 2026-10-07).

## ~/PROJECTOR library conventions (managed by these scripts)
- Layout: `Movies/` flat; `Shows/<Show Title>/Season NN/<show>-sXXEYY.mkv` (Jellyfin).
- Queue: `~/Downloads/MOVIES/`, processed entries move to `DONE/`; idempotent via to-projector skip-if-exists.
- `to-projector season_dir_subdir()` fallback (2026-10-07): bare `N.mkv` under `Show/Season NN/` derives SxxEyy from path context; 0-based numbering detected by a `0.*` sibling (Midsomer Murders Season 01 was 0-based, all other seasons 1-based).
