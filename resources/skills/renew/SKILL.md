---
name: renew
description: "Resume work on a specific project or area. Trigger when the user says /renew <name>, 'pick up <project>', 'continue <project>', or 'back to <project>'."
disable-model-invocation: true
---

# Renew

Load focused context for a specific project or area to continue work.

> Named `/renew` instead of `/resume` because `/resume` is a built-in command in Claude Code (and other tools) for resuming previous conversations.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Identify the target. The user says `/renew <slug>`. Match `<slug>` against:
   - `$JORNAL/projects/<slug>.md`
   - `$JORNAL/areas/<slug>.md`
   - If no exact match, try partial match or list available projects/areas and ask.

3. Read the matched project or area file.

4. Read today's log (`$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`).
   If it doesn't exist, create it with the daily log template.
   Scan for any earlier session entries related to this project/area today.

4a. Check `$JORNAL/workqueue.md` for any queued `/next` entries matching this slug (any date).
    Match lines of the form `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` (line-end anchor).
    If entries exist, display them in the output under a **Queued sessions** section so the user has the full prior context before continuing.

5. Search recent logs for context (last 3 days):
   ```bash
   grep -rl "<slug>" "$JORNAL/areas/log/" 2>/dev/null | sort -r | head -3
   ```
   Read any matches to understand recent session history.

6. Search inbox for related items:
   ```bash
   grep -i "<slug>" "$JORNAL/inbox.md"
   ```

7. If in a git repo, gather workspace context:
   - `git branch --show-current`
   - `git log --oneline -5`
   - `git status --short`

## Output format

---
**Resuming: Project/Area Name**

**Status**: one-line summary of where things stand

**Queued sessions** *(from workqueue.md — unprocessed /next entries for this slug)*
- bullet entries from each queued session, in chronological order
- *(none)* if no queued entries

**Last session** *(from most recent log entry)*
- what was done last time

**Open tasks**
- [ ] task list from the project/area file

**Waiting**
- [~] any blocked items

**Related inbox items** *(if any)*
- items that mention this project

**Workspace** *(if in a relevant git repo)*
- Branch, status, recent commits

**Suggested next step**
- what makes sense based on task list and last session

---

Then ask: *"Ready to continue, or want to adjust the plan?"*
