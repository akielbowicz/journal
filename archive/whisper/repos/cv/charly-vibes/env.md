# Environment — charly-vibes

## TypeSafe (System One) available
- TypeSafe skill installed at `~/.pi/agent/skills/typesafe-ai/` and `~/.agents/skills/typesafe-ai/`
- API key `TYPESAFE_API_KEY` configured via chezmoi template (`dot_bashrc.tmpl`, `dot_config/nushell/env.nu.tmpl`) sourced from `~/.config/chezmoi/chezmoi.toml [data.typesafe.api_key]`
- Jev model (jev-latest) endpoint: `POST https://api.typesafe.ai/v1/systemone`
- Jev chosen wai as highest-need repo (2026-09-30): 3 issues + 7 TODOs, core infra, 0.97 confidence


## Org-wide project listings taxonomy (2026-09-01, session close)

- 4 listing artifacts must stay in sync when projects change: `charly-vibes/README.md`, `charly-vibes/llms.txt` (es), `charly-vibes.github.io/llms.txt` (en), `charly-vibes.github.io/index.html`
- Taxonomy (user-decided): **El ecosistema** = Rust CLIs + fabbro + shared infra (wai, fabbro, dont, espectacular, testaruda, pretender, vampiro, crua, livin, genesis, dulce-de-leche); **La palabra** = writing/prompt repos; **El laboratorio** = apps split by platform (web/mobile/desktop/otros experimentos); **Distribución** = homebrew-charly, scoop-charly
- Meta repos (`charly-vibes`, `charly-vibes.github.io`) intentionally excluded from listings — exclusion note lives at the end of the README list
- `dulce-de-leche` (ddl) stays in ecosystem per user's rust-CLI rule, cross-linked from Distribución description
- Sync pattern that worked: python script extracts existing bullets/cards by name regex, rebuilds the `## Mapa`/`## Proyectos`/`## Projects` sections + `<h3 class="group-title">` blocks from a name→content dict — no hand-transcription of HTML entities
