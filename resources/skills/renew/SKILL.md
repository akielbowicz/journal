---
name: renew
description: "Resume work on a project or area, inferring the target from context when omitted. Trigger when the user says /renew, /renew <name>, 'pick up <project>', 'continue <project>', or 'back to <project>'."
disable-model-invocation: true
---

# Renew

Load focused context for a project or area to continue work. If the user omits the slug, infer the most likely target from conversation and workspace context.

> Named `/renew` instead of `/resume` because `/resume` is a built-in command in Claude Code (and other tools) for resuming previous conversations.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Identify the target.

   If the user provided a slug or name (`/renew <slug>`, `pick up <project>`, etc.), match it against:
   - `$JORNAL/projects/<slug>.md`
   - `$JORNAL/areas/<slug>.md`
   - If no exact match, try partial match or list available projects/areas and ask.

   If the user omitted the target (`/renew`, `continue`, `pick this back up`), infer it from context using these signals, in order:
   1. Current conversation: the project/area name or slug the user just mentioned.
   2. Current working directory: repo/path components matching a project or area slug/name.
   3. Git context: current branch name, remote URL/repo name, or recent commit messages matching a project or area slug/name.
   4. `$JORNAL/queue/<slug>.md` (or legacy `$JORNAL/workqueue.md`): the most recent queued `/next` entry if it is unambiguous.
   5. Today's log: Focus section or most recent Log entry naming a project/area.
   6. Recent logs (last 3 days): most recently active project/area.

   Treat exact slug/name matches as strong evidence. Treat multiple plausible matches as ambiguous.

   If exactly one strong candidate is found, proceed and mention the inference source in the output (for example: `Inferred from current directory`). If no candidate or multiple candidates are plausible, list the top candidates with their evidence and ask the user to choose instead of guessing.

3. Read the matched project or area file.

4. Read today's log (`$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`).
   If it doesn't exist, create it with the daily log template.
   Scan for any earlier session entries related to this project/area today.

4a. Derive `$SLUG` from the matched project/area name (same sanitization as `/next` step 3):
    ```bash
    SLUG=$(echo "$RAW" | tr ' /()' '----' | tr '[:upper:]' '[:lower:]')
    ```

    Load queued prior-session context:
    - **Primary:** check `$JORNAL/queue/$SLUG.md`. If it exists, is non-empty, and contains at least one `## ` section header, load its entries.
    - **Fallback:** if `queue/$SLUG.md` is absent or fails validation, check `$JORNAL/workqueue.md` for entries matching `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` (line-end anchor).
      - If legacy entries found: migrate them into `$JORNAL/queue/$SLUG.md` (create file with header if needed), remove the matching blocks from `workqueue.md`, and commit both files together with the next git operation.
      - If no legacy entries: no queued context.

    Before using any queue content, validate it contains at least one `## ` section header; otherwise treat as empty.

    Display loaded entries under **Queued sessions** in chronological order. Legacy entries sort before new-file entries when timestamps match.

    **Compact display rule:**
    - 1 entry: show full bullets
    - 2–4 entries: show latest in full; for each older entry show its date, slug, and **Next:** line only
    - 5+ entries: show latest in full; show `+ N earlier sessions (YYYY-MM-DD to YYYY-MM-DD)` with their **Next:** lines collected

    Always preserve the **Next:** bullet from every queued session — it is the most actionable part.

5. Extract recent session context from logs. For each of the last 3 days (today, yesterday, 2 days ago) — stop as soon as a match is found:
   ```bash
   # Find start line of the slug's session section using fixed-string matching
   grep -nF "($SLUG)" "$LOG_FILE" 2>/dev/null | head -1
   grep -nF "($SLUG —" "$LOG_FILE" 2>/dev/null | head -1
   ```
   Use the start line number to find the next `---` separator line; read only that block using the Read tool with offset and limit. Do not load the entire log file.

   If no match is found in any of the 3 days, output `"No log section found for '<slug>' in the last 3 days"` instead of a silent empty **Last session** field.

6. Search inbox for related items:
   ```bash
   grep -iF "$SLUG" "$JORNAL/inbox.md"
   ```
   Show all matching lines under **Related inbox items**.

7. If in a git repo, gather workspace context:
   - `git branch --show-current`
   - `git log --oneline -5`
   - `git status --short`

## Output format

---
**Resuming: Project/Area Name**

**Target inference**: explicit `<slug>`, or inferred from cwd/git/queue/logs

**Status**: one-line summary of where things stand

**Queued sessions** *(from queue/<slug>.md — unprocessed /next entries for this slug)*
- bullet entries from each queued session, in chronological order (compact format for 2+ entries)
- *(none)* if no queued entries

**Last session** *(from most recent log entry, or "No log section found for '<slug>' in the last 3 days")*
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
