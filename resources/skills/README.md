# Skills (DEPRECATED)

**This directory is documentation-only. Do not install or deploy from here.**

As of 2026-09-01 the journal depends on
[incitaciones](https://github.com/akielbowicz/incitaciones) (npm: `incitaciones`)
for shared skills — `close`, `next`, `park`, `renew` — installed via `pi install npm:incitaciones`
(project dependency in `.pi/settings.json`) and managed by its installer into `~/.agents/skills/`.

- `close/`, `next/`, `park/`, `renew/` — stale snapshots of the incitaciones v0.5.0 skills, kept for reference. Live versions come from the incitaciones package.
- `archive/`, `capture/`, `jlog/`, `migrate/`, `morning/`, `standup/`, `weekly/`, `wrap-up/` — journal-specific skills that still exist only here. They run at runtime via symlinks from `~/.agents/skills/` and are candidates to be upstreamed into incitaciones.

**Do not run `bin/sync`; it is deprecated.** This repo is the source of truth for
*records* (daily logs, inbox, projects, areas), not skills.
