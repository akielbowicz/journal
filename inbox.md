- 2026-04-11 [ ] Commit or discard the remaining `.gitignore` change in `nayra` after deciding whether local artifacts should be shared repo-wide
# Inbox

Quick capture for unsorted tasks, thoughts, and follow-ups.
Process regularly — migrate items to projects, areas, or resources, or schedule them.

---

<!-- New entries go below, newest first, with date prefix -->
- 2026-09-01 [x] incitaciones: cut npm release (`npm version minor` + push tag) so `pi install npm:incitaciones` users get the reworked cartography HTML export + fixed docs; verify `git tag -l` after versioning (fragile tag gotcha) — DONE v0.8.0, published 2026-09-02 (incitaciones-ba6)
- 2026-09-01 [ ] Upstream the 8 journal-specific skills (archive, capture, jlog, migrate, morning, standup, weekly, wrap-up) into incitaciones so `resources/skills/` can be retired
- 2026-09-01 [ ] Report incitaciones bug: `/next` mis-parses `git@host:` remotes into junk dirs (`repos/gh/`, `repos/github.com/`, `repos/ak:akielbowicz/`)
- 2026-09-01 [ ] Enforce HTTPS on GitHub Pages for `ak.saxa.xyz` once the cert provisions (`gh api -X PUT repos/akielbowicz/journal/pages --input - <<< '{"https_enforced": true}'`)
- 2026-09-01 [ ] Optionally trim `resources/skills/` deprecated snapshots to just the 4 upstream-derived ones (close/next/park/renew)
- 2026-07-28 [ ] Workflow: when implementing tickets, follow TDD → Ro5U → fix → commit → next cycle
- 2026-05-12 [ ] In `charly/espectacular`, persist the AI-dev ecosystem gap analysis as a parent document and link the `add-spec-assertions` epic plus feedback-loop tickets back to it.
- 2026-05-12 [ ] In the `charly` ecosystem, open the deferred observability work with a harness-agnostic scope covering Pi, Codex, and Claude Code trace collection.
- 2026-05-12 [ ] In the `charly` ecosystem, create placeholders for the still-deferred gaps: dependency validation and context curation.
- 2026-05-04 [ ] In `clojnder`, after Binder picks up commit `9e243ff`, verify the `/user/<session>/clay-preview/*` routes work end-to-end and consider adding explicit image/version metadata for easier in-pod debugging.
- 2026-04-30 [ ] In `clojnder`, fill in `openspec/project.md`, decide whether to configure `.wai/resources/agent-config/.projections.yml`, and create the first tracked change/task
- 2026-04-28 [ ] In `SundaeVolatility`, decide whether untracked `src/` and `tests/` should be committed, ignored, or cleaned up
- 2026-04-28 [ ] In `incitaciones`, decide whether the local `content/compiled/` output should be cleaned, gitignored, or intentionally tracked
- 2026-04-24 [ ] In `paranoid`, manually verify UsageAudit usage-access Settings handoff and overnight battery snapshot behavior on a device
- 2026-04-20 [ ] In `incitaciones`, confirm whether removing tracked `pi-package/` files was intended; if not, restore the directory and adjust ignore/local workflow instead of deleting repo content
- 2026-04-17 [ ] In `sxAct`, decide whether to clean up the tracked `.beads/backup/backup_state.json` churn (`sxAct-hk8w`) or leave it as accepted repo noise
- 2026-04-17 [ ] In `atril`, review and approve the `add-unified-repo-reader` OpenSpec change, then turn it into `bd` work items and a first implementation slice
- 2026-04-16 [ ] In `atril`, create the first `wai` project and seed initial `bd` / OpenSpec work items
- 2026-04-11 [ ] Try `amdgpu.dcdebugmask=0x10` kernel param to disable PSR — workaround for recurring DMCUB firmware crash on Framework 13 AMD
- 2026-04-11 [ ] Check Framework community forum for Phoenix1 DMCUB freeze fixes and track linux-firmware updates
- 2026-04-09 Fix `.agents/`, `.gemini/`, `.config/amp/` to symlink to `.config/agents/skills/` instead of being copies (via `incitaciones install`)
- 2026-07-27 [~] In `charly`, decide whether to adopt `bd --global` shared-server for cross-repo dependency tracking; if yes, encode the genesis critical path there and close `charly-7f5` suite-index ticket. (Suite-index ticket is the interim authoritative graph.)
- 2026-07-27 [ ] In each charly-vibes tool repo (wai/dont/pretender/espectacular/testaruda/crua/livin/vampiro/genesis), commit the uncommitted openspec proposal files for `adopt-genesis`/`depend-on-genesis`/`add-genesis-foundation`/`add-feedback-subcommand`.
- 2026-07-27 [ ] When `genesis` tags v0.1.0, unblock the 8 adopter tickets and re-point `dont-2j6o`'s child adoption issues at the per-repo `adopt-genesis` proposals before closing it.
