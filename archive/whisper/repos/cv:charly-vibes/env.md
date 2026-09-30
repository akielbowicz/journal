# Environment — charly-vibes

## TypeSafe (System One) available
- TypeSafe skill installed at `~/.pi/agent/skills/typesafe-ai/` and `~/.agents/skills/typesafe-ai/`
- API key `TYPESAFE_API_KEY` configured via chezmoi template (`dot_bashrc.tmpl`, `dot_config/nushell/env.nu.tmpl`) sourced from `~/.config/chezmoi/chezmoi.toml [data.typesafe.api_key]`
- Jev model (jev-latest) endpoint: `POST https://api.typesafe.ai/v1/systemone`
- Jev chosen wai as highest-need repo (2026-09-30): 3 issues + 7 TODOs, core infra, 0.97 confidence