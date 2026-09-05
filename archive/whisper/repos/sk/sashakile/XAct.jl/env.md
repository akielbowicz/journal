# XAct.jl — Environment & Infrastructure Notes

### 2026-09-04 12:55 — CI: Dependabot replaces CompatHelper
- The `juliaregistries/compathelper` action repo was **deleted upstream** (404). CompatHelper is deprecated upstream: "migrate to Dependabot", which now supports Julia natively.
- As of commit `f5fd1a8` (2026-09-04): `.github/workflows/CompatHelper.yml` deleted; `.github/dependabot.yml` has a `julia` ecosystem entry (weekly) handling `Project.toml` `[compat]` updates, alongside existing `github-actions` and `pip` entries.
- Caveat: Dependabot does not support custom/private registries yet. XAct.jl currently uses only the General registry (the `path = "."` entry in Manifest.toml is just the package self-reference) — if a custom registry is ever added, revisit the dependabot julia entry.
