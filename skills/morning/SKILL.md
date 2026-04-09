---
name: morning
description: "Start-of-day routine for the work journal. Trigger when the user says /morning, 'good morning', 'start my day', or begins a new work session."
disable-model-invocation: true
---

# Morning Routine

Start the work day by reviewing context and setting focus.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Get today's date and derive the log path: `$JORNAL/log/YYYY/YYYY-MM/YYYY-MM-DD.md`

3. Read yesterday's log for context (find the most recent log file before today).

4. Check if today's log exists. If not, create it with the daily log template from `$JORNAL/AGENTS.md`.

5. Read `$JORNAL/inbox.md` — flag any items sitting unprocessed for more than 2 days.

6. Read all active project files under `$JORNAL/projects/` (skip `_index.md`).
   Collect all open tasks: `- [ ]`
   Collect all waiting tasks: `- [~]`

7. Read all area files under `$JORNAL/areas/` (skip `_index.md`).
   Collect recurring tasks: `- [ ]`

8. Gather workspace context from the current working directory:
   - `pwd` — which project/repo are we in?
   - `git branch --show-current` — what branch?
   - `git log --oneline -5` — recent commits
   - `git status --short` — uncommitted work?

## Output format

Present a morning briefing:

---
**Good morning — YYYY-MM-DD**

**Yesterday's wrap-up** *(from yesterday's log)*
- brief summary of what was done

**Open tasks** *(grouped by project)*
- [ ] task — project name

**Waiting on others** *(from [~] items across projects)*
- [~] task — waiting on who (since when) — project name

**Areas** *(recurring duties due)*
- area name: items due or worth noting

**Inbox** *(items to process, if any)*
- items older than 2 days get flagged
- suggest migrating to projects/areas or cancelling

**Current workspace** *(from pwd + git)*
- Repo, branch, status, likely next action

**Suggested focus for today**
- top 2-3 priorities

---

Then ask: *"What would you like to set as today's focus?"* and update the `## Focus` section of today's log once the user responds.
