# incitaciones — repo-wide environment facts

## 2026-09-01: Skill/packaging notes (v0.5.0 session)

**Beads metadata convention:** implementation tickets carry
`metadata.files` + `metadata.base_commit` (HEAD SHA at creation).
Freshness = `git diff base_commit..HEAD -- <files>`; touched files ⇒ ticket
stale (PRE-003). Documented in distilled `create-issues` / `issue-review` skills.

**bd dolt push:** no remote configured — prints provider suggestions. Beads data
currently syncs only via git (`issues.jsonl` export). Pending fix.

**check-links recipe:** now a frontmatter-aware python parser in justfile
(both flow `related: [a.md]` and block-list styles; resolves repo-root docs
like AGENTS.md). The old sed-range version produced ~88 false positives —
don't reinstate it.

**Validation gates:** lefthook pre-commit runs `just check-links` +
`just validate`; pre-push runs validate-distilled + validate-pi-package.
Zero-warning baseline as of 2026-09-01.

**Publishing:** CI (`.github/workflows/npm-publish.yml`) publishes on `v*`
tags. 2026-09-01: `npm version minor` created the commit but silently skipped
tag creation — after `npm version`, verify `git tag -l` before pushing.
npm README is rendered from repo README.md — never commit a truncated/placeholder
README before a release.
