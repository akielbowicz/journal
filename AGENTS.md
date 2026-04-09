# Work Journal — Agent Instructions

This repository is a personal work journal and task manager following the **PARA method** and **Bullet Journal** conventions. AI agents should proactively read and update this from any session when work context is relevant.

## Repository Path

Resolved via `$JORNAL` environment variable (default: `~/para/areas/dev/gh/ak/journal`).

## Structure

| Path | Purpose |
|---|---|
| `projects/` | Active work with a defined goal and end state |
| `areas/` | Ongoing responsibilities with no end date |
| `resources/` | Reference material, notes, links |
| `archive/` | Completed projects, inactive areas, old resources |
| `inbox.md` | Quick capture — unsorted tasks, thoughts, and notes |
| `log/YYYY/YYYY-MM/YYYY-MM-DD.md` | AI session logs (daily entries) |
| `jornal/` | Personal daily journal (org-mode, human-written) |
| `laboratorio/` | Lab/experiment notes (org-mode) |

### Projects

Each project lives at `projects/<slug>.md`. Link it from `projects/_index.md`. A project file should have:
- Goal / definition of done
- Task list (bullets)
- `## Waiting` section for tasks blocked on others
- Notes / decisions log

### Areas

Each area lives at `areas/<slug>.md`. Link it from `areas/_index.md`. An area file tracks:
- Ongoing responsibilities and standards to maintain
- `## Recurring` section for periodic tasks
- Relevant contacts

### Resources

Reference material at `resources/<slug>.md`. Not active work — things you look up, not act on.

### Archive

When a project is done or an area becomes inactive, move the file to `archive/` and update `_index.md`.

## Bullet Notation (Markdown)

| Symbol | Meaning |
|---|---|
| `- [ ]` | Open task |
| `- [x]` | Completed task |
| `- [>]` | Migrated — moved to a project/area (note destination) |
| `- [<]` | Scheduled — has a specific date (note when) |
| `- [~]` | Waiting / deferred — blocked on someone or something (note who/what) |
| `- [-]` | Cancelled |
| `- [!]` | Priority / starred |
| `- note text` | Plain note (no checkbox) |

**Migration rules:**
- When an inbox item moves to a project/area, mark it `[>]` in inbox with a note of where it went. Do not delete it — the trail matters.
- When a task is blocked on someone, mark it `[~]` with who/what it's waiting on.
- During `/migrate`, review all `[~]` items and ask "still waiting?"

## Daily Log Template

```markdown
# YYYY-MM-DD

## Focus
- what the day is about

## Log

## Tasks created

## Decisions
```

## Project File Template

```markdown
# Project Name

## Goal
What does "done" look like?

## Tasks

### Phase / Category
- [ ] task
- [~] blocked task — waiting on who/what

## Waiting
- [~] description — waiting on person/event (since YYYY-MM-DD)

## Notes
```

## Area File Template

```markdown
# Area Name

## Scope
What this area covers and why it matters.

## Recurring
- [ ] periodic task (frequency)

## Contacts
| Person | Role |
|---|---|

## Notes
```

## Session Lifecycle Skills

| Skill | Purpose |
|---|---|
| `/morning` | Start-of-day briefing: projects, areas, inbox, workspace context |
| `/capture` | Quick add to `inbox.md` |
| `/jlog` | Open or append to today's daily log |
| `/resume <slug>` | Pick up a specific project or area with focused context |
| `/park` | Snapshot current work before switching context |
| `/close` | End of session: log, commit |
| `/migrate` | Process inbox, review waiting tasks, clean up |
| `/standup` | Yesterday/today/blockers summary |
| `/weekly` | 7-day review and next-week planning |
| `/archive <slug>` | Move completed project to archive |

## How Agents Should Use This Journal

### Quick capture
When the user mentions a task, decision, or follow-up in conversation, offer to add it to `inbox.md` with today's date.

### Daily log
When starting a session with substantive work, check if today's log exists. Create it if missing using the template above. Append session summaries, decisions made, and tasks created.

### Proactive use
In any session, when the user mentions tasks, decisions, blockers, or follow-ups:
- Offer to capture them in `inbox.md`
- Offer to log context in today's daily log
- Reference active projects and areas for relevant context

## Commit Conventions

- `log: YYYY-MM-DD session notes`
- `projects: add <name>` / `projects: update <name>`
- `areas: add <name>` / `areas: update <name>`
- `inbox: capture tasks` / `inbox: migrate`
- `archive: close <name>`

## Notes

- Remote: `git@ak:akielbowicz/journal.git` (public). Push after committing session logs.
- The personal journal (`jornal/`) and lab notes (`laboratorio/`) use org-mode and are managed separately via `zk` and the `justfile`.
- The BuJo/PARA structure (`inbox.md`, `log/`, `projects/`, `areas/`) uses markdown and is managed via AI agent skills.
