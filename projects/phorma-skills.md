# phorma-skills

Skill-set monorepo at `~/para/areas/dev/gh/phorma/skills`
([github.com/PhormaSci/skills](https://github.com/PhormaSci/skills)). Sets
under `sets/`: `core`, `research` (placeholders), `investigations` (the
`inv-*` set — scientific investigation journaling: hypotheses, experiments,
evidence; append-only JSONL source of truth, generated state views).
Installs via `npx skills add PhormaSci/skills` (GitHub-only distribution, no
npm publishing) or as a pi-package
(`pi install git:github.com/PhormaSci/skills`).

## Tasks

- [ ] Run the first investigation experiment — `parallel-agent-journal-conflicts` H-1: do parallel delegated agents appending `records.jsonl` from separate checkouts merge cleanly in git? (fallback design: per-agent staging files merged by inv-renew)
- [ ] Replace placeholder skills in `sets/core` and `sets/research` with real skills

## Notes

- Gates before every commit: `just validate` (Agent Skills spec, cross-set
  name uniqueness); `just inv-validate` for the journal.
- Architecture decisions: `sets/investigations/research/design-rationale.md`.
- CHANGELOG is the change baseline (started 0.1.0, 2026-09-05).
