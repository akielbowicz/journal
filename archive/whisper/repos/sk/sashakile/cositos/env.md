# cositos — repo environment facts

### Quarto toolchain (resolved 2026-09-03)
Quarto is now **mise-managed and pinned**: `mise.toml [tools]` has `"aqua:quarto-dev/quarto-cli" = "1.10.18"` — the aqua backend-qualified key is required (bare `quarto = ...` fails, "not found in mise tool registry"). CI pins the same version via `quarto-dev/quarto-actions/setup@v2` in both workflows. **Caveat:** a Homebrew cask quarto may shadow mise's on PATH (`which quarto` → linuxbrew); if brew upgrades past the pin, `brew uninstall quarto` and let mise own it. Onboarding for docs builds: `mise install`, then `mise run docs`. (Earlier: quarto was absent entirely and docs changes were verified structurally only — anchor existence + `#anchor` link resolution via rg, which remains a good fallback.)

### OpenSpec CLI JSON quirk
`openspec instructions <artifact> --json` prepends a log line before the JSON (`- Generating instructions...`); parse with `raw[raw.index('{'):]`, and `validate` takes a positional change name, not `--change`. (2026-09-03, CLI 1.5.0-era)
