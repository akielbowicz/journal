### 2026-10-13 10:44 — snap
- Ecosystem-map SVG diagram in docs/ecosystem-map.md (+ generated copy): color-coded responsibility bands, clickable cards → tool mdBooks/GitHub, hover affordance, wai `matrix` subcommand noted.
- Added wild / bajan / gently to map + tables; genesis foundation bar now lists `git` + `git_hooks` modules and provenance-footer format for `managed_block`; exclusion table removed; incitaciones relabeled "non-Rust" not "external".
- scripts/sync-github-meta.py (new): syncs description/homepage/topics for 14 fleet repos via gh; all now carry `charly-vibes` + `dulce-de-leche` topics; idempotent, applied and verified.
- Fleet search URL pinned in README + ecosystem-map: topic:charly-vibes topic:dulce-de-leche (AND query — lone topic matches unrelated dessert project Antonela89/humaya).
- **Next:** wild/bajan/gently not in ddl's install registry (src/platform.rs) — needs its own ticket (manifest entries, 5-target releases, conformance fixtures). Uncommitted docs/script changes in ddl working tree; consider commit.
