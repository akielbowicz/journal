## 2026-10-05 — pre-push conformance scans sibling repos
`tests/standard_conformance.rs` iterates ALL_REPOS = org siblings resolved as `../<name>` next to the ddl repo. If any sibling misses a required artifact (e.g. specodelic missing `llm.txt`), the local pre-push gate fails even though GitHub CI passes (siblings absent in CI checkout). Fix belongs in the sibling repo, not ddl.
Confirmed 2026-10-05 17:58: fixing the sibling (specodelic-mvl: llm.txt at root) cleared the local pre-push gate — pending ddl commit pushed. Don't patch ddl's conformance test to skip siblings.

## 2026-10-13 — generated docs surfaces & llm-file pair
`docs/src/release.md` and `docs/src/ecosystem-map.md` are **gitignored and generated** by `.github/workflows/docs.yml` pre-build steps ("Generate release-status page from Cargo.toml" / "Generate ecosystem landing page") — never hand-edit; local stale copies (e.g. release.md saying v0.7.0) are not deployed bugs. Enforced by `tests/standard_conformance.rs` §6.
Both `llms.txt` (machine index) **and** `llm.txt` (narrative summary) are required at repo root by §3 — deleting either fails `s2_llms_txt_at_root`; both now carry role cross-reference headers (edit both or neither).
fotos-mcp and the `fotos` desktop-app cask are **out of ecosystem scope** since v0.8.0 — keep them out of current-facing docs (README, ecosystem map, llm files); historical mentions only in CHANGELOG/design/archives (precedent: openspec 2026-09-29-update-spec-tool-tables).
