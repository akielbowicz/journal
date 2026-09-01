

## Migrated from Testimonial.jl

# Testimonial.jl — Repo-wide conventions and gotchas

## Documentation
- All doc source files have YAML front matter: `title`, `description`, `category`
- Every page starts with a `**TL;DR:**` summary line for AI-readiness
- `docs/llms.txt` provides LLM-oriented index of all documentation pages
- Documenter.jl cross-reference checker (`CrossReferences` pass) rejects links that resolve relative to source files, not rendered URLs. Use `warnonly = [:cross_references]` in makedocs() and links like `[text](page/)` will work correctly in the built HTML.
- `just docs-build` runs Pkg.develop + Pkg.instantiate before makedocs
