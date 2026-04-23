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

4. Detect the project slug from the current working directory (same logic as `/next`):
   ```bash
   git remote get-url origin 2>/dev/null | sed 's/.*\///' | sed 's/\.git$//'
   ```
   Fall back to `basename $PWD`, or `general` if in `$HOME`.

5. Check `$JORNAL/workqueue.md` for entries matching the detected slug across **all dates** — not just today.
   Match lines of the form `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` (line-end anchor; slug must match exactly, not as substring).
   Each matching block runs from that `##` line to the next `---` separator.
   If entries exist, load them as prior-session context for the synthesis in step 6.

6. Review the full conversation history (plus any workqueue entries from step 5) and write a concise session summary covering:
   - What was worked on (key topics, files, repos) — synthesized across all sessions if workqueue had entries
   - Decisions made
   - Tasks completed or created
   - Any unresolved items or next steps

7. Append the summary to the `## Log` section of today's daily log.
   If `## Log` does not exist in the file, append the section header before the entry.
   If workqueue entries were present (step 5), N = count of workqueue entries + 1 (current session). Use the multi-session heading:
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

10. If workqueue entries for this slug were incorporated (step 5), remove them from `$JORNAL/workqueue.md`.
    **Removal algorithm:**
    - Match blocks whose header line matches `^## \d{4}-\d{2}-\d{2} \d{2}:\d{2} — <slug>$` exactly (line-end anchor prevents `journal` from matching `journal-redesign`).
    - Each block ends at (and includes) the first `---` separator following the header.
    - Remove only those blocks. Leave all entries for other slugs untouched.
    - The file's top-level header (`# Work Queue`) and its description + opening `---` are **never** removed.

11. Commit:
    ```bash
    cd "$JORNAL" && git add workqueue.md inbox.md areas/log/ projects/ areas/ && git commit -m "log: YYYY-MM-DD session notes"
    ```

## Rules

- Do NOT ask the user any questions. Summarize automatically from conversation context.
- Keep the summary concise — bullet points, not paragraphs.
- If today's log already has content, append to it; never overwrite existing entries.
- If `workqueue.md` does not exist or has no entries for this slug, proceed as a normal single-session close.
