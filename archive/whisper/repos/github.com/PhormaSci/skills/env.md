# PhormaSci/skills — operational knowledge

- Skill-set monorepo (npm workspaces under `sets/`); GitHub is the sole
  distribution channel — `npx skills add PhormaSci/skills`, no npm publishing
  (the `charly-vibes` npm login on this machine belongs to the incitaciones
  repo; don't conflate scopes). Also a pi-package:
  `pi install git:github.com/PhormaSci/skills`.
- Gates before commits: `just validate` (Agent Skills spec: name/dir match,
  ≤64-char names, quoted descriptions, cross-set skill-name uniqueness);
  `just inv-validate` for the journal.
- Scaffolding: `just new-set <name>`, `just new-skill <set> <name> "description"`.
- The repo dogfoods its own investigations set: `investigations/` journal
  (index.md narrative + append-only records.jsonl + generated state.md).
  Dashboard: `just inv-new`, regenerate with `investigations.mjs state <slug>`.
- Architecture decisions + deliberate omissions:
  `sets/investigations/research/design-rationale.md`.
- Open (2026-09-05): first experiment of
  `investigations/parallel-agent-journal-conflicts` H-1 — parallel appends
  to records.jsonl from separate checkouts; per-agent staging files is the
  fallback if git conflicts confirmed.
