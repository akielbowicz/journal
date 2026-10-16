# bajan — repo env facts

## Release flow (verified 2026-10-01, v0.1.0)
- crates.io publish token is configured; `cargo publish` just works (dry-run first, then real).
- Tag push triggers a `Release` workflow building Linux/macOS/Windows in parallel (~4-5 min); `gh run view` shows per-OS job checkmarks.
- crates.io API returns 403 to bare curl (bot protection) — pass a User-Agent header to verify.
- docs.rs/crates.io README renders the **published tarball** — README fixes land on crates.io only at the next version bump.

## Gate stack (lefthook pre-commit + pre-push)
- dont-gate, espectacular (contract tests), pretender (advisory tiers), specodelic lint (7 spec files), testaruda-doctor. `just ci` is the local parity gate.
- Pre-existing pretender advisories: complexity hotspots in src/review.rs::run_er_pass, src/extract.rs::run_extract_with, src/store/sqlite.rs (file_lines). Advisory-only, don't block.

## CLI surface gotchas (docs-accuracy, learned via Rule-of-5 review)
- `adopt`, `contradict` require 1+ claim keys (num_args=1.., required).
- HITL surfaces: `review list|approve|reject` (ER) and `proposal list|approve|reject` (LLM contradictions) — approve/reject take a **pair** (from, to), not one key. `Er` itself only takes --budget.
- Global `--db` flag, default `bajan.db` in cwd.
- Only 4 BAJAN_* env vars exist (EXTRACTOR/_MODEL/_BASE_URL/_API_KEY_ENV) — no spend cap (ticket bajan-8cc).
