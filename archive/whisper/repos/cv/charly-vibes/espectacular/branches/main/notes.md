
### 2026-08-05 13:33 — snap
- Fixed 9 bugs across the board: zero_tests_ran false-positive, report archetype attribution + failing counts, configured specs root, quality_findings schema, process group timeout, README/docs JSON envelope, doctor --enable mutation writes [quality.mutation], and {} placeholder substitution in mutation runner
- All pushed to `cv:charly-vibes/espectacular.git` main
- **Next:** complete remaining bugs (P2 items), then tackle `espectacular-rmn` (remove local Doctor types → use genesis::doctor), then `espectacular-9ys`/`espectacular-3ys` (genesis v0.6.0 adoption), then release 0.5.0

### 2026-08-05 15:49 — full session
- Closed 16 tickets across 3 code pushes + 1 release
- Removed local DoctorReport/DoctorDiagnostic/DoctorRecommendation → genesis::doctor types
- Adopted genesis v0.6.0 envelope API (cli_version required)
- Added quality-composability/cost/boundary-coverage signals (suite-trio integration)
- Fixed Windows build: gated killpg, process_group, PermissionsExt behind `#[cfg(unix)]`
- **Released v0.5.0**: crates.io publish ✓, GitHub Release ✓, Homebrew skipped (token)
- **Remaining tickets:** espectacular-c9v (P0 pi extension), espectacular-djw (P2 mutation boundary)

### 2026-09-05 17:47 — snap
- Wrote research doc from machine-verifiable spec framework (`~/Downloads/Verifiable Software Specification Framework.md`): 7 improvement opportunities incl. spec-quality lint, entanglement lint, `property_class` metadata, dont-style unstructured-verification skill (#7) — committed to main (0753e24)
- Key discovery: existing draft `add-spec-quality-checks` already covers improvement #1 (research had missed it — `openspec list` beats `wai search` for change inventory); amended it with archetype-gated `entangled-spec` check (f5fb9c0)
- Created + Rule-of-5-hardened proposal `add-contract-property-class`: owns the first warning-severity finding in `ah check` (severity field didn't exist — verified in report.rs/check-output.schema.json); both changes pass `openspec validate --strict` (8788f28)
- Note: `.beads/issues.jsonl` has a pre-existing staged modification not from this session — left uncommitted
- **Next:** start TDD cycle 1.1 on `add-contract-property-class` (red test for `property_class` parsing in `src/contracts.rs`) via `bd ready` claim; also consider `ah explain` playbook ticket for BP blind spots
