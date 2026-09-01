# journal

A personal work journal combining [PARA](https://fortelabs.com/blog/para/) (Projects, Areas, Resources, Archive) with [Bullet Journal](https://bulletjournal.com/pages/learn) conventions, designed to be used by both humans and AI coding agents.

## Why

Context gets lost between sessions. Whether it's a conversation with Claude, a Gemini session, or just switching between projects during the day, the "what was I doing and why" fades fast. This repo is the single source of truth for that context — a place where every AI tool and every work session can read from and write to.

It blends two proven productivity systems:

- **PARA** organizes *what* you're working on into four categories by actionability
- **Bullet Journal** provides the *rhythm* — daily logs, quick capture, periodic review, and migration

The result is a plain-text system that works from the terminal, renders on GitHub, and is readable by any AI tool.

## Structure

```
journal/
├── inbox.md                          # Quick capture — unsorted tasks and notes
├── workqueue.md                      # Legacy `/next` queue (superseded by ~/.whisper/)
├── projects/                         # Active work with defined goals
│   └── _index.md
├── areas/                            # Ongoing responsibilities (no end date)
│   ├── _index.md
│   └── log/                          # Daily session logs
│       └── YYYY/YYYY-MM/YYYY-MM-DD.md
├── resources/                        # Reference material and notes
│   ├── _index.md
│   └── skills/                       # AI agent skills (slash commands)
│       ├── morning/    capture/    jlog/
│       ├── renew/      park/       next/
│       ├── close/      wrap-up/
│       ├── migrate/    standup/    weekly/
│       └── archive/
├── archive/                          # Completed projects, inactive areas
│   ├── _index.md
│   ├── queue/                        # Archived pre-whisper `/next` snapshots
│   └── whisper/                      # Knowledge store (~/.whisper → symlink here)
├── bin/
│   ├── build                         # Static site build (pandoc)
│   ├── doctor                        # Self-test of the journal chain
│   ├── generate-indexes              # Site: directory listings
│   ├── generate-search-index         # Site: lunr search index
│   ├── convert-org                   # Org → markdown helper
│   └── sync                          # (deprecated stub) skills install via npm:incitaciones
├── AGENTS.md                         # Instructions for AI tools
├── CLAUDE.md -> AGENTS.md            # Symlink for Claude Code
├── .mise.toml                        # Tool versions + task runner
└── .zk/                              # Zettelkasten config for org-mode notes
```

The top level is pure PARA: `projects/`, `areas/`, `resources/`, `archive/`, plus `inbox.md` as the entry point. Everything else nests inside those four categories — daily logs are an ongoing area (`areas/log/`), skills are a resource, and session snapshots/knowledge live in `archive/whisper/` (which `~/.whisper` symlinks to). The old `queue/` directory of `/next` snapshots is superseded by whisper notes and kept at `archive/queue/`.

## PARA in brief

| Category | What goes here | Example |
|---|---|---|
| **Projects** | Has a goal, has an end | "Ship feature X", "Set up CI for repo Y" |
| **Areas** | Ongoing standard to maintain | "Dev tooling", "Learning", "Health" |
| **Resources** | Topics of interest, reference material | "Architecture decisions", "Paper notes" |
| **Archive** | Inactive items from the above three | Completed projects, retired areas |

Items flow naturally: an inbox capture becomes a project task, a completed project moves to archive, a useful finding becomes a resource.

## Bullet notation

Tasks in markdown files use extended checkbox syntax:

| Symbol | Meaning |
|---|---|
| `- [ ]` | Open task |
| `- [x]` | Completed |
| `- [>]` | Migrated — moved elsewhere (note where) |
| `- [<]` | Scheduled — deferred to a date |
| `- [~]` | Waiting — blocked on someone/something |
| `- [-]` | Cancelled |
| `- [!]` | Priority / starred |
| `- text` | Plain note |

The key BuJo practice is **migration**: periodically reviewing open items and deciding whether to keep, move, schedule, or cancel them. The trail of `[>]` markers tells you where things went.

## Daily log

Each day gets a file at `areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`:

```markdown
# 2026-04-23

## Focus
- Refresh journal docs for the latest session workflow

## Log

### Sessions 17:40 (journal — 2 sessions)
- Updated README.md to document the new `/next` and `/wrap-up` skills
- Added `workqueue.md` to the documented repo structure and clarified that it is agent-managed
- **Arc:** moved the docs from a direct-log-only model to a direct-log + queued-handoff model
- **Next:** keep examples in sync as skills evolve

## Tasks created

## Decisions
- `/park` writes directly to today's log
- `/next` queues work for later synthesis by `/close` or `/wrap-up`
```

Sessions are appended throughout the day. `/park` writes a quick snapshot directly to today's log, `/next` stashes a fast handoff into `~/.whisper/`, `/close` wraps up the current slug and folds in any whisper notes queued for it, and `/wrap-up` processes any remaining queued sessions across projects.

## AI agent skills

Shared session-lifecycle skills (`close`, `next`, `park`, `renew`) come from [incitaciones](https://github.com/akielbowicz/incitaciones) (npm), managed by its installer into `~/.agents/skills/`. Journal-specific skills live in `resources/skills/`, symlinked into `~/.agents/skills/`. `bin/sync` is a deprecated stub.

| Skill | When to use |
|---|---|
| `/morning` | Start of day — briefing with open tasks, inbox, workspace context |
| `/capture` | Quick-add a task or note to `inbox.md` |
| `/jlog` | Append a note to today's daily log |
| `/renew [slug]` | Pick up a project or area — infers the target from context when omitted (`/resume` is taken by built-in conversation resume in most tools) |
| `/park` | Switching context — snapshot what you were doing directly into today's log |
| `/next` | Quick handoff to `~/.whisper/` when you need to stop without a full close |
| `/close` | End of session — summarize, log, commit, and fold in queued `/next` notes for the same slug |
| `/wrap-up` | End of day — process queued `/next` notes across projects, update logs, and commit |
| `/migrate` | Review inbox and waiting tasks, decide what to do with each |
| `/standup` | Generate yesterday/today/blockers from recent logs |
| `/weekly` | 7-day review with accomplishments, status, next-week focus |
| `/archive <slug>` | Move a completed project or inactive area to archive |

### How the handoff commands relate

- Use `/park` when you're switching context and want an immediate note in today's log without committing the journal.
- Use `/next` when you need a fast checkpoint; it snapshots an agent-managed note to `~/.whisper/` for later synthesis.
- Use `/close` when you're done with the current slug; it can fold in queued `/next` entries for that same slug, even from earlier dates.
- Use `/wrap-up` at the end of the day to process any remaining queued sessions across all slugs.

Whisper notes are normally agent-managed state. Edit them manually only for recovery or cleanup.

### Typical flow

```
/morning            → see what's open, set focus
  ... work ...
/capture fix the CI → add to inbox
  ... work ...
/next               → stash a quick handoff in ~/.whisper when you need to pause fast
/renew              → infer and load context for the next thing
/renew other-proj   → explicitly load context for a project/area
  ... work ...
/close              → log this session, folding in any queued notes for the same slug
/wrap-up            → end-of-day sweep across all queued sessions
```

`/close` can fold in queued `/next` entries for the current slug across dates, while `/wrap-up` processes whatever remains in the queue across all slugs.

### Installing skills

Shared skills install with the incitaciones installer; journal skills are symlinked from `resources/skills/` — see `resources/skills/README.md`.

## Tasks (via mise)

All tasks are defined in `.mise.toml` and run with `mise run <task>`:

| Task | What it does |
|---|---|
| `mise run build` | Build the static site locally |
| `mise run serve` | Build and serve at localhost:8000 |
| `mise run whisper-sync` | Commit + push new whisper entries |
| `mise run jrn` | Create/edit today's journal entry (org-mode via zk) |
| `mise run lab [name]` | Create/edit a resource note |
| `mise run edit [query]` | Interactive note search and edit |
| `mise run save [msg]` | Commit pending journal changes |
| `mise run list` | List recent notes |
| `mise run search <query>` | Search across all notes |
| `mise run clean` | Remove build artifacts |

## Setup

### Environment variable

Set `$JORNAL` to the repo path so skills can find it from any directory:

```fish
# Fish
set -gx JORNAL $HOME/para/areas/dev/gh/ak/journal

# Nushell
$env.JORNAL = $"($env.HOME)/para/areas/dev/gh/ak/journal"

# Bash/Zsh
export JORNAL="$HOME/para/areas/dev/gh/ak/journal"
```

If unset, skills default to `~/para/areas/dev/gh/ak/journal`.

### Install tools and deploy

```bash
cd $JORNAL
mise install          # installs pandoc, zk
mise run whisper-sync # commit + push new whisper entries
```

### Dependencies

Managed by [mise](https://mise.jdx.dev/) (`.mise.toml`):

- [pandoc](https://pandoc.org/) — document conversion (org→md, md→html)
- [zk](https://github.com/zk-org/zk) — note management (optional, for org-mode journal)

No dependencies are required for the AI skills — they're plain markdown files.

## License

[CC0 1.0 Universal](LICENSE) — public domain.
