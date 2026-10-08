## wild repo facts (seeded 2026-10-05)

- Seeded from `~/Downloads/wild-bundle.zip` (bundle of wild design/specs/prototypes/experiments). Layout: `specs/` (9 specodelic specs), `docs/` (manual, 2 integration-failures files), `prototype/` (4 Python sims), `experiments/`, `results/`, `superseded/`.
- specodelic 0.5.1: `specodelic lint specs` → 9 files, 0 issues/warnings; `specodelic graph specs` → no dangling refs. README last-run claim (v0.4.0, clean) still holds.
- Pre-push hook runs CI gates on changed files only (49 for the seed commit) — exit 10 steady-state with Static-only witnesses is by design (confidence < 0.5 → FULL_RUN).
- HEAD after seed: 958b594 (`testaruda gate: exec loop with CI exit-code contract`), pushed to git@cv:charly-vibes/wild.git. Uncommitted leftover: `testaruda.toml` modified — commit it next session.
- Not yet specified (from bundle README): Contract IR schema/canonical form, consumer manifest/lockfile formats, sidecar record format.
