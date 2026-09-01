
## 2026-08-05: Cross-repo evaluation round

**CI status across 9 dulce-de-leche-managed tools:**
- Green: wai, dont, espectacular, fotos, fabbro
- Red: dulce-de-leche, pretender, testaruda, vampiro

**Beads databases:** Each tool has its own isolated `.beads/` database. Cross-repo dependency links between beads DBs are not possible — use notes instead of `bd dep relate` for cross-repo tickets.

**bd create quirks:** `--metadata` (not `--set-metadata`) for JSON metadata on create. `bd close` uses `--reason` (not `--notes`). `bd update` has no `--deps` flag — use `bd dep add` / `bd dep relate` instead.

**Key untriaged bugs found in this round:**
- wai: 16 clippy errors (CI badge green but clippy fails locally)
- dulce-de-leche: clippy errors fixed since round 1 report (50→0), but CI badge still red
- pretender: flaky test `test_check_staged_first_commit_no_head` now stable (3/3 passes)

**2026-09-01: npm version tag quirk** — in incitaciones, `npm version minor`
created the commit but did NOT create the git tag (silent). Published manually
with `git tag -a && git push origin <tag>`. Watch for this in other
dulce-de-leche-managed npm packages; always `git tag -l` after `npm version`.
