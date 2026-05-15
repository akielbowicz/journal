---
name: close
description: "End-of-session wrap-up. Summarizes what was done, logs it to the daily journal, and commits. Trigger when the user says /close, 'close session', or 'wrap up'."
disable-model-invocation: true
---

# Close Session

End the current session: log what was done, update tasks, commit.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Get today's date and time (`date +%Y-%m-%d`, `date +%H:%M`).
   Derive the log path: `$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`

3. If the log file does not exist, create it with the daily log template:
   ```markdown
   # YYYY-MM-DD

   ## Focus
   - what the day is about

   ## Log

   ## Tasks created

   ## Decisions
   ```

4. Detect the project slug (same logic as `/next` step 3):
   ```bash
   RAW=$(git remote get-url origin 2>/dev/null | sed 's/.*\///' | sed 's/\.git$//')
   [ -z "$RAW" ] && RAW=$(basename "$PWD")
   [ "$PWD" = "$HOME" ] && RAW="general"
   SLUG=$(echo "$RAW" | tr ' /()' '----' | tr '[:upper:]' '[:lower:]')
   ```

5. Load queued prior-session context:
   - **Primary:** check `$JORNAL/queue/$SLUG.md`. If it exists, is non-empty, and contains at least one `## ` section header, load its entries.
   - **Fallback:** if `queue/$SLUG.md` is absent or fails validation, check `$JORNAL/workqueue.md` for entries matching `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` (line-end anchor; slug must match exactly, not as substring). Each matching block runs from that `##` line to the first `---` separator following it.
   - **Skip:** if neither source has entries for this slug, proceed as a normal single-session close.

6. Review the full conversation history (plus any queued entries from step 5) and write a concise session summary covering:
   - What was worked on (key topics, files, repos) — synthesized across all sessions if queue had entries
   - Decisions made
   - Tasks completed or created
   - Any unresolved items or next steps

7. Append the summary to the `## Log` section of today's daily log.
   If `## Log` does not exist in the file, append the section header before the entry.
   If queued entries were present (step 5), N = count of queued entries + 1 (current session). Use the multi-session heading:
   ```
   ### Sessions HH:MM (<slug> — N sessions)
   - synthesized bullet points
   - **Arc:** what changed across the sessions
   - **Next:** what to pick up next time (if applicable)
   ```
   Otherwise use the standard heading:
   ```
   ### Session HH:MM (<context>)
   - bullet point summary entries
   - **Next:** what to pick up next time (if applicable)
   ```

8. Update project/area files if tasks were completed or created:
   - Mark completed tasks `[x]`
   - Add new tasks as `[ ]`
   - Add/update `[~]` waiting items
   - Update `## Notes` with decisions

9. If any tasks or follow-ups came up that aren't in a project/area, add them to `inbox.md`.

10. If queued entries were incorporated (step 5):
    - If entries came from `$JORNAL/queue/$SLUG.md`: remove all `## ` session blocks from the file using the Write or Edit tool; preserve the file header (`# Queue: ...`).
    - If entries came from legacy `$JORNAL/workqueue.md`: remove only the matching blocks. Match `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` exactly (line-end anchor prevents substring matches). Each block ends at (and includes) the first `---` following its header. Leave all other slugs' entries and the file header untouched.
    - Commit both removals in the same commit as the log entry (step 11).

11. Commit:
    ```bash
    cd "$JORNAL" && git add "queue/$SLUG.md" workqueue.md inbox.md areas/log/ projects/ areas/ && git commit -m "log: YYYY-MM-DD session notes"
    ```
    Including both `queue/$SLUG.md` and `workqueue.md` covers both new and legacy locations during the migration period.

## Rules

- Do NOT ask the user any questions. Summarize automatically from conversation context.
- Keep the summary concise — bullet points, not paragraphs.
- If today's log already has content, append to it; never overwrite existing entries.
- If no queue file or legacy `workqueue.md` entries exist for this slug, proceed as a normal single-session close.
