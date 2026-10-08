## 2026-10-05 — pre-push conformance scans sibling repos
`tests/standard_conformance.rs` iterates ALL_REPOS = org siblings resolved as `../<name>` next to the ddl repo. If any sibling misses a required artifact (e.g. specodelic missing `llm.txt`), the local pre-push gate fails even though GitHub CI passes (siblings absent in CI checkout). Fix belongs in the sibling repo, not ddl.
Confirmed 2026-10-05 17:58: fixing the sibling (specodelic-mvl: llm.txt at root) cleared the local pre-push gate — pending ddl commit pushed. Don't patch ddl's conformance test to skip siblings.
