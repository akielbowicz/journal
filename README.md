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
├── inbox.md                  # Quick capture — unsorted tasks and notes
├── projects/                 # Active work with defined goals
│   └── _index.md
├── areas/                    # Ongoing responsibilities (no end date)
│   └── _index.md
├── resources/                # Reference material and notes
│   └── _index.md
├── archive/                  # Completed projects, inactive areas
│   └── _index.md
├── log/                      # Daily session logs
│   └── YYYY/
│       └── YYYY-MM/
│           └── YYYY-MM-DD.md
├── skills/                   # AI agent skills (slash commands)
│   ├── morning/
│   ├── capture/
│   ├── jlog/
│   ├── close/
│   ├── park/
│   ├── resume/
│   ├── migrate/
│   ├── standup/
│   ├── weekly/
│   └── archive/
├── bin/
│   └── sync                  # Deploy skills to agent tools
├── AGENTS.md                 # Instructions for AI tools
├── CLAUDE.md -> AGENTS.md    # Symlink for Claude Code
├── justfile                  # Human commands (just jrn, just lab, etc.)
└── .zk/                      # Zettelkasten config for org-mode notes
```

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

Each day gets a file at `log/YYYY/YYYY-MM/YYYY-MM-DD.md`:

```markdown
# 2026-04-09

## Focus
- Main theme or priority for the day

## Log

### Session 15:45 (journal repo — BuJo/PARA setup)
- Built the PARA structure and 10 lifecycle skills
- Deployed skills to all AI agent tools
- **Next:** start using skills in daily workflow

## Tasks created

## Decisions
- Journal skills are tool-agnostic (AGENTS.md)
- No beads integration — keep systems separate
```

Sessions are appended throughout the day. `/park` snapshots mid-session; `/close` wraps up and commits.

## AI agent skills

This repo includes 10 lifecycle skills that work with any AI coding tool (Claude Code, Gemini CLI, Codex, Amp, OpenCode). Skills are defined in `skills/` and deployed to `~/.config/agents/skills/` via `bin/sync`.

| Skill | When to use |
|---|---|
| `/morning` | Start of day — briefing with open tasks, inbox, workspace context |
| `/capture` | Quick-add a task or note to `inbox.md` |
| `/jlog` | Append a note to today's daily log |
| `/resume <slug>` | Pick up a project or area — loads focused context |
| `/park` | Switching context — snapshot what you were doing |
| `/close` | End of session — summarize, log, commit |
| `/migrate` | Review inbox and waiting tasks, decide what to do with each |
| `/standup` | Generate yesterday/today/blockers from recent logs |
| `/weekly` | 7-day review with accomplishments, status, next-week focus |
| `/archive <slug>` | Move a completed project or inactive area to archive |

### Typical flow

```
/morning            → see what's open, set focus
  ... work ...
/capture fix the CI → add to inbox
  ... work ...
/park               → switching to another project
/resume other-proj  → load context for the next thing
  ... work ...
/close              → log everything, commit
```

### Deploying skills

```bash
# From the repo root
./bin/sync

# Or via justfile
just deploy
```

This copies each skill's `SKILL.md` to `~/.config/agents/skills/<name>/SKILL.md` with a provenance comment containing the git commit hash and date.

## Human commands

The repo also includes a `justfile` for non-AI workflows using [zk](https://github.com/zk-org/zk) and org-mode:

| Command | What it does |
|---|---|
| `just jrn` | Create/edit today's journal entry (org-mode via zk) |
| `just jrn-ai "stream of thought"` | Create a journal entry structured by AI |
| `just lab "project name"` | Create/edit a resource note |
| `just edit [query]` | Interactive note search and edit |
| `just deploy` | Deploy skills to agent tools |
| `just save [msg]` | Commit pending journal changes |
| `just list` | List recent notes |
| `just search query` | Search across all notes |

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

### Deploy skills

```bash
cd $JORNAL && ./bin/sync
```

This deploys to `~/.config/agents/skills/`. AI tools that read from that location (or symlink to it) will pick up the skills automatically.

### Dependencies

- [git](https://git-scm.com/) — version control
- [just](https://github.com/casey/just) — command runner (optional, for human commands)
- [zk](https://github.com/zk-org/zk) — note management (optional, for org-mode journal)

No dependencies are required for the AI skills — they're plain markdown files.

## License

[CC0 1.0 Universal](LICENSE) — public domain.
