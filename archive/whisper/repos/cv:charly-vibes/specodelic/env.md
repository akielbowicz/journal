# specodelic — repo environment notes

## Docs site (deployed: https://charly-vibes.github.io/specodelic/)
- mdBook site, deployed artifact-based from `main` via `.github/workflows/docs.yml`
  (checkout → copy specs/ + openspec/specs into docs/src → mdbook build → upload/deploy-pages).
- `llms.txt` is the agent entry point (required by openspec `docs-site` spec,
  invariant `llms_txt_served`). Copied to book root in TWO places — keep in sync:
  `justfile:115` (`just docs-build`) and `.github/workflows/docs.yml:61-62`.
  Edit only the repo-root `llms.txt`; the copies are build-time.
- 2026-10-01: added `## Docs` link index (per-spec pages first, print.html as bulk
  fallback with ~85K-token caveat); 25 linked URLs verified 200.
- `print.html` = whole book in one page (~521 KB HTML → ~334K chars text after tag-strip;
  tables survive as pipe-delimited rows). Per-spec pages: `specs/<stem>.html`.
- No raw markdown served (`specs/*.md` → 404). Sidebar TOC lives in hash-named
  `toc-<hash>.js` — filename is NOT stable across builds; don't hardcode it.
- Repo-root `llm.txt` was an undeployed richer variant (404) — drift; tracked as
  specodelic-cke. Follow-up: version stamping = specodelic-2m7.- GOTCHA: `docs.yml` path filter must include `llms.txt` (added 2026-10-01, a32c3e9) —
  the workflow copies llms.txt into the book but previously didn't rebuild on llms.txt-only
  changes; llms.txt edits then required `gh workflow run docs.yml --ref main` to deploy.
