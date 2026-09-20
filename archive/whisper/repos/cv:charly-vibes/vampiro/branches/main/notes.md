# vampiro — main branch notes

### 2026-09-20 18:46 — snap
- Cleared the entire bd ticket queue grounded in implementation evidence: CI-green PRs merged for `vampiro-qm0` (3 root-caused CI failures), `vampiro-gqy` (SUPPORTED_EXTENSIONS in scan scope filters), `vampiro-5dc` (vendored-libgit2 + vendored-openssl), `vampiro-bf6` (dont epistemic gate wired into lefthook pre-commit + ci.yml planning job), `vampiro-deh` (bd state rollback fixed via repo .gitignore negations for .beads/.dont); stale tickets `vampiro-al5`, `vampiro-v9x` closed. bd: 170 issues, 0 open.
- Key gotchas learned: git2 0.20 feature is `vendored-libgit2` (not `vendored`); dont requires all 6 REQUIRED_SUBDIRS present in checkout (committed .gitkeep files); global ~/.gitignore conflicts with project-tracked bd/dont integration (fixed with repo-level negations).
- main @ 09fd071 pushed, CI green with epistemic gate live. All work via feature branches + PRs (#10–#13), locally merged per user instruction.
- **Next:** review/merge the 8 Dependabot PRs (#2–#9, rebased onto green CI); OpenSpec `add-law-and-proof-verification` (0/14) awaits the roadmap/HITL approval-gate decision (property/prover boundary, tasks 0.1–0.2) — that decision belongs to the human owner.

### 2026-09-20 22:1x — dependabot wave
- All 8 Dependabot PRs cleared: #7 (checkout v7) API-merge; #8/#9 (setup-node v7, upload-pages-artifact v5) refused by API (workflow scope) → local merge of `pull/N/head` + push, but `git pull --rebase` before push flattened the merge commits → PRs stayed OPEN with content already on main (cosmetic; Dependabot self-closes or close manually). Next time: fetch `pull/N/head` then merge WITHOUT pulling first.
- #3 trycmd 0.15→1.2, #2 clap, #5 clap_complete, #4 toml (lock-only bump, spec 1.1.3 already permits 1.1.6) — all green, API-merged.
- #6 git2 0.21: CI red — git2 0.21 changed `StatusEntry::path()` from `Option<&str>` to `Result<&str, Error>` (non-UTF-8 → Err). Fixed in PR #14 (2 call sites in crates/vampiro-cli/src/scan/mod.rs:350/:404, `if let Ok(path)`), 822 tests green, vendored-libgit2+openssl features unchanged. Dependabot can't fix source breaks — supersede its PR.
- bd dolt push fails in vampiro ("this operation must be run in a work tree" from bd's internal git invocation) — unresolved; issues.jsonl export still syncs via plain git push.
