
### vampiro repo-wide infra facts
- `bd dolt push` fails with "this operation must be run in a work tree" (bd's internal git invocation chokes; 2026-09-20, unresolved) — issues.jsonl passive export still syncs via plain git push.
- gh token lacks `workflow` scope: PRs touching `.github/workflows/*` can't merge via API. Workaround: `git fetch origin pull/N/head` then `git merge --no-ff FETCH_HEAD` + `git push` (SSH not scope-bound). Do NOT `git pull --rebase` between merge and push — it flattens merge commits and the PR stays OPEN despite content being on main.
- CI runs serialized (concurrency group) — back-to-back pushes queue; check `gh run list --branch main` before judging pending status.
- git2 0.21 API break: `StatusEntry::path()` returns `Result<&str, Error>` (non-UTF-8 → Err) instead of `Option<&str>` (2026-09-20, fixed in PR #14).
