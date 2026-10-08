
## beads (bd) infra gotchas — learned 2026-10-03
- `bd export` writes to **stdout by default**; the embedded-Dolt store and `.beads/issues.jsonl` (git source of truth) drift silently. Always sync after ticket work: `bd export -o .beads/issues.jsonl`, then commit.
- `bd update` has **no `--deps` flag** — dependencies are `bd dep add <dependent> <blocker>` (or `--deps` at create time only).
- Epics: `bd create -t epic …`; children via `bd create --parent <epic>` or `bd update <id> --parent <epic>`; tree via `bd children <epic>`.
- acset.zip adoption: epic `specodelic-84i` (S1+S2 = openspec change `add-acset-core`; S3 writer `specodelic-p5b`; S4 pushout `specodelic-9um`; views re-point `specodelic-hya` — all blocked-by `84i.1`). Resolution tables live in `openspec/changes/add-acset-core/design.md`.

## more bd/infra gotchas — learned 2026-10-03 (evening, external-review triage session)
- `bd create` has **no `refactor` type** (custom types need `types.custom` config) — use `-t task` + `--label refactor`.
- `bd update` **cannot combine** `--metadata` with `--set-metadata`/`--unset-metadata` — put keys+values in one `--metadata` JSON string.
- The ah-check pre-commit gate **rewrites `.espectacular/<capability>/*.toml` contract test flags** (placeholder like `write_observability_pair` → real test names). Gate-authored, sanctioned (its own config dir, not the read-only `openspec/`); commit separately with a provenance note.
- External-review corpus for specodelic (4 AI design reviews, 2026-10-03) is triaged in-repo: `.wai/resources/research/2026-10-03-external-architecture-reviews.md` (findings register; tickets 3a8/mlc). Raw packages still in `~/Downloads/cv/` — copy into repo only if asked.

## docs build + pretender gate interaction — learned 2026-10-08
- mdBook does NOT render mermaid natively: ```mermaid fences ship as plain code unless mdbook-mermaid (preprocessor + additional-js) is wired in book.toml AND installed in CI (docs.yml). Symptom: deployed graph-views.html showed unrendered blocks.
- **pretender `--staged` bypasses the `exclude` list** — role is detected from path (vendor/ → role vendor) and the file is linted anyway; only walk scans honor exclude. `[thresholds.vendor]` is NOT a supported thresholds block (only test/script/library). Consequence: vendored minified bundles (e.g. mermaid.min.js) must stay UNTRACKED and be fetched at build time — pattern here: `just docs-mermaid` (pinned CDN fetch, only-if-missing), wired into `just docs-build` and docs.yml. Hand-sized init scripts can stay tracked.
- graph-easy is NOT a homebrew formula; `perl -MCPAN -e 'CPAN::Shell->install("Graph::Easy")'` works (lands in ~/.cpan/build/Graph-Easy-<ver>-/; needs PERL5LIB + PATH for the bin). Renders `spk graph --format dot --view wiring` nicely as boxart.
- Wiring view scale: full corpus graph is ~743 nodes / 1008 edges — never render whole; `--view wiring` collapses to a ~17-node star that survives ASCII. Wiring TSV is consumer-first 6-col (consumer,consumer_kind,field,producer,producer_kind,count) vs base edges TSV producer-first — awk recipes differ.

## core.fsmonitor silent-data-loss incident — learned 2026-10-08
- `core.fsmonitor = true` (from /etc/gitconfig) served a stale cache after scripted bulk rewrites (python migration over 24 archived files): `git status`/`git diff`/`git add` all reported CLEAN while the working tree differed from HEAD. Consequence: a `git add openspec/` commit silently dropped 24 file edits, and the discrepancy only surfaced when `cargo publish` (libgit2, no fsmonitor) refused with "22 files uncommitted".
- Rule: after scripted bulk file rewrites, verify with `git -c core.fsmonitor=false status --porcelain` before trusting a clean status — or before any commit that must carry those files.
- Fixed 2026-10-08: fsmonitor disabled for this repo (`git config core.fsmonitor false`), strips landed in 397684c; `bd remember` holds the universal rule.
