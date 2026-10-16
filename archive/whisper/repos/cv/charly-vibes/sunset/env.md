# sunset — specification corpus

- Run `just spec-check`: strict baseline/proposal OpenSpec validation, isolated
  archive-composition regression, and the 11 frozen DSC 0.2 descriptor fixtures.
- `spec/document-model-specodelic-v3/` is preserved research provenance. Never
  change its validator or claim it validates 0.3. Known limitations are in
  `docs/src/baseline-limitations.md`.
- Active 0.3 requirements live in `openspec/changes/add-dsc-03/specs/`; they
  supersede conflicting details in the preserved draft. The implementation is
  still absent. Changing baseline behavior requires MODIFIED deltas, not ADDED.
- The composition regression uses the actual OpenSpec archive command only in
  a temporary workspace; it does not promote the working repository proposal.
