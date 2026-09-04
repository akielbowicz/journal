

## Migrated from Testimonial.jl

# Testimonial.jl — Repo-wide conventions and gotchas

## Documentation
- All doc source files have YAML front matter: `title`, `description`, `category`
- Every page starts with a `**TL;DR:**` summary line for AI-readiness
- `docs/llms.txt` provides LLM-oriented index of all documentation pages
- Documenter.jl cross-reference checker (`CrossReferences` pass) rejects links that resolve relative to source files, not rendered URLs. Use `warnonly = [:cross_references]` in makedocs() and links like `[text](page/)` will work correctly in the built HTML.
- `just docs-build` runs Pkg.develop + Pkg.instantiate before makedocs

## CI
- Testimonial is **unregistered** and all Manifests are git-ignored — every workflow that spawns the driver subprocess (ci.yml, ci-e2e.yml, nightly-record.yml) must `Pkg.develop(path=<repo-root>)` into `scripts/TestimonialRunner/` + resolve + instantiate before recording. Without it: `Pkg.instantiate()` dies with "expected package Testimonial to be registered" (nightly), or `record_item` silently returns nothing (driver exit 3 rejected by `_recording_succeeded`, per in3s.3)
- `record_all()` covers ~185 testitems with **no progress output**; nightly's 30-min step timeout is marginal — see testimonial-l7hk before adjusting
