### 2026-10-14 13:04 — snap
- PR #40 (exec-bit release tarballs, curl install docs, LLM summaries on Pages) was blocked: CI "Smoke dogfooded tools" step — `pretender check --mode guidance` fails closed in pretender 0.7.0 without an advisory lease
- Fixed `.github/workflows/ci.yml` smoke to `--advisory-until 2026-12-31`; fixed local git (`core.bare=true` → false); verified locally (exit 0), CI green, PR #40 merged squash (2a109e9), branch deleted
- Note: merged main now has a `pretender.toml` + `.espectacular/` config from parallel work — CI lease flag may be redundant but harmless
- **Next:** optional — decide whether to keep the `--advisory-until` flag or rely on `pretender.toml` for guidance mode; consider `bd dolt remote add` repair hinted in post-merge beads warning
