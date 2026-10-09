- 2026-04-11 [ ] Commit or discard the remaining `.gitignore` change in `nayra` after deciding whether local artifacts should be shared repo-wide
# Inbox

Quick capture for unsorted tasks, thoughts, and follow-ups.
Process regularly — migrate items to projects, areas, or resources, or schedule them.

---

<!-- New entries go below, newest first, with date prefix -->

- 2026-10-09 [ ] charly pain/: act on toolpath autopsy verdict — design the three enforcement layers for agents (file read-lock, structured error channel, script wall-clock budget); nushell/typed pipes ruled secondary in the analysis (pain/report.org, corpus reproducible via archive-v1 pipeline)

- 2026-09-29 [ ] genesis: wire select→run loop in lefthook hooks — unblocked 2026-09-30: testaruda `exec` shipped in v0.5.0 (gh-26 closed) and multi-line feedback stdin fixed in genesis-vibes 0.8.1 (gh-27 closed, regression pinned in testaruda)
- 2026-09-29 [ ] bd upstream: 1.3.0's `bd setup --print` template still ships `bd dolt push # Sync with remote when authorized` — file issue asking bd to drop it when `no-db: true` (agents keep echoing it)
- 2026-09-29 [ ] fotos: broken pre-push hook — lint/test need leptonica/pipewire via distrobox and fail in 0.31s outside it; fix hook (or its distrobox detection) — currently every push needs --no-verify
- 2026-09-29 [ ] suite: per-repo bd stores work again post-migration — re-point cross-repo genesis edges off charly-7f5 (suite index) into the per-repo stores when convenient

- 2026-09-25 [ ] whisper workspace hygiene: legacy colon-key dirs in live `~/.whisper/repos/` (cv:charly-vibes, ak:akielbowicz, sk:sashakile) + stale mirrors in jornal `archive/whisper/` — run `turu doctor` → `turu consolidate` in the live workspace, then re-sync or prune the journal archive copy
- 2026-09-17 [ ] REPLy.jl: stale untracked `aek-analysis/` (Aug 7 progressive-eval plan, 5 waves) — commit to a branch, file in beads, or delete
- 2026-09-17 [ ] REPLy.jl infra: local/remote tag `v0.3.0` divergence makes `git pull --rebase` warn (would clobber) — retag or force-fetch
- 2026-09-17 [ ] REPLy.jl infra: `bd dolt push` broken — dolt internal error "this operation must be run in a work tree"; beads state still synced via git-committed issues.jsonl

- 2026-09-15 [ ] incitaciones: use file-headers convention in an external codebase, then promote status tested → verified (evidence needed for the final promotion)
- 2026-09-15 [ ] microdancing: choose workshop primary buyer persona (HR/L&D non-coders vs CTO engineers vs lab directors) — fork determines curriculum design
- 2026-09-15 [ ] microdancing: gather Argentina market data for workshop pricing/verticals (CONICET, universities, biotech/agtech, YPF-Tec) — corpus has no LatAm data, flagged in dossier §6/§7
- 2026-09-15 [ ] microdancing: pick concrete stack for workshop content (Claude Code / Cursor / etc.) — corpus deliberately tool-agnostic
- 2026-09-15 [ ] cleanup: delete /var/home/sasha/scratch (all committed on microdancing data/conference-analysis) or keep raw VTTs only

- 2026-09-09 [ ] fck: eval `negative` case showed glm-5.3-flash over-firing the decoder on swear-in-sentence (kit arm) — consider hardening the skill `description` boundary or accepting the false-positive rate
- 2026-09-09 [ ] fck: run full sonnet (~anthropic/claude-sonnet-latest) across all case kinds — only `trigger` was rerun after the pinned-id 404s
- 2026-09-07 [ ] microdancing: congelar un usage_report para el post y actualizar cifras citadas en `drafts/post-principal-resoluciones.md` (cita números v4 viejos: 133,819 reqs / $366.20; actuales v4.1: 135,436 reqs / $369.58 real / 9.19B cache-read). El cutoff de datos avanza solo — citar "datos al <fecha>"
- 2026-09-07 [ ] microdancing: renombrar `data/usage_report_v3.json` a `usage_report_v4.json` (script es v4.1, nombre desalineado) y actualizar el script + drafts que lo referencien
- 2026-09-03 [ ] In `phormasci.github.io`, fix broken `pr-preview.yml` deploy-preview: regenerate fine-grained PAT with access to `PhormaSci/pr-site-preview` and update the `PREVIEW_REPO_TOKEN` secret (broken since 2025-12, "could not read Username")
- 2026-09-03 [ ] In `phormasci.github.io`, add Cloudflare Pages auto-deploy to `static.yml` (`wrangler-action` + `CLOUDFLARE_API_TOKEN` secret) so merges to main ship to phorma.sh without manual `just deploy`
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
- [~] ~~microdancing: agregar workshop/ (skill_management_practices, skills_dossier, research_labs_addendum) a la tabla de contenidos del README de conference-analysis~~ — 2026-09-18: conference-analysis se extrajo al repo `tv` (raíz); hacer TOC ahí si aplica
- 2026-09-16 [ ] Run `projector-queue` for real — queue holds Ludwig 2024 S01 (6 eps) + Ted Lasso S04E07; `-- --remux` suffices for Jellyfin (direct-plays HEVC, encode only for USB-projector)
- 2026-09-17 [x] insta: anchor `base_commit` metadata on all 31 beads tickets after the first commit lands (issue-review PRE-003/004 pre-flight needs it). — done at insta 4a8c5e5
- 2026-09-18 [ ] In `wai`, run `bd bootstrap` to re-clone the diverged dolt remote (`refs/dolt/data` has no common ancestor with local history) or force-push if local is authoritative
- 2026-09-17 [ ] Email sysadmins@gnu.org asking to remove the IP block on 186.148.206.6 (gnu.org silently drops our packets; draft ready in session notes)
- 2026-09-20 [ ] pretender: sync the beads no-db commit (02d1a56) to other machines and set `no-db: true` there BEFORE running any bd command (stale dolt DB would diverge from issues.jsonl)
- 2026-09-20 [ ] Give the leverage thesis site-facing copy in `phormasci.github.io` (mission "Knowledge Multiplier" or Trainee Program hero): "AI multiplies what you have; structure converts it into quality" — talleres principle #22 + teaching-topics §0 are the source; manual sync, no status fields cross
- 2026-09-29 [ ] rbenv shims broken for lefthook (`ruby: command not found` from shims while 2.7.8 exists) — fix shims or remove the ruby-syntax hook; it blocks pre-commit/pre-push in homebrew-charly + scoop-charly (worked around with `-c core.hooksPath=/dev/null`)
- 2026-10-01 [ ] **Disk cleanup: `/var/home` at 99%** (930G, was 100% mid-session — truncated genesis src/git_hooks.rs during rustfmt; repaired). Only genesis `target/` (11G) cleared so far. Find the big consumers (du on para/areas/dev, ~/.cache, docker/podman, old toolchains) and clear
- 2026-10-01 [x] pretender-mlw filed: bump tree-sitter-rust 0.23→0.24 — DONE 10-01 (PR #39, shipped in v0.8.0; impact was worse than noise: engine.rs early-return silently lost ALL metrics for such files)
- 2026-10-01 [ ] uarup/WhatsApp: pull crypt15 backup key from Drive appdata (non-E2E backups; WhatsApp-GD-Extractor w/ app password, or clean OAuth script w/ `drive.appdata` scope), then decrypt old `msgstore.db.crypt15` with wa-crypt-tools → deep history + call logs the API never served. Playbook: `borradores/machetes/whatsapp-crypt15-backup-extraction-no-root.org`
- 2026-10-01 [ ] uarup: ~1,511 media downloads unrecoverable (404 on server + absent from phone dump); only path is a future phone backup restore or per-chat export. Re-check after any full phone backup
- 2026-10-03 [x] charly-vibes/espectacular: add the `TAP_GITHUB_TOKEN` secret (GitHub repo variable) so the Release workflow can publish the homebrew tap + scoop bucket — skipped for 8 straight releases (0.5.0 → 0.9.2); then re-run the Publish job for any release needing backfill — DONE 10-09: PAT secret set in 7 repos + tap/scoop catch-up pushed (ah 0.10.0); espectacular-c8u closed
- 2026-10-06 [ ] charly-vibes/incitaciones: push commits d73df28, e9e74b3 + tag v0.12.0 (lane×complexity scheme, published to npm but repo commits local-only) — **awaiting authorization**
- 2026-10-06 [ ] coffee: add `glm` family mapping to `usage-tracker.py` `model_details()` (~:538) — 5-min ticket, makes the incumbent baseline visible in monthly reports
- 2026-10-06 [ ] Night-lane pilot: tRAGar + REPLy.jl + XAct.jl — curate `afk/s` + `afk/m` tickets, local `codex exec --worktree` + test gate, review diffs next morning with gpt-6.1-sol
- 2026-10-06 [ ] Testimonial.jl ↔ testaruda design session (merge-or-diverge decision; Astra candidate) + cositos-40e P2 into night queue
- 2026-10-06 [ ] evallerina: add CI (8 `no-gate` tickets waiting on it); reconcile tRAGar's `[A]/[B]/[C]/[E]` title prefixes with complexity labels
- 2026-10-09 [ ] espectacular: file ticket for `no-tests-ran` execution finding on lint/mismatched-id-is-reported (stale contract filter after rev-18 rekey; confirm with user first)
- 2026-10-09 [x] espectacular-c8u: homebrew tap fix — needs TAP_GITHUB_TOKEN PAT; release.yml tap-update step silently no-ops without it — DONE 10-09 (secret set, ah formula 0.6.0→0.10.0 pushed, ticket closed)
- 2026-10-09 [ ] Rotate the fine-grained TAP_GITHUB_TOKEN PAT (pasted in chat log 10-09) — regenerate at github.com/settings/personal-access-tokens and `gh secret set` in dulce-de-leche, pretender, testaruda, espectacular, specodelic, bajan, dont, vampiro, bichos, fotos, wai
