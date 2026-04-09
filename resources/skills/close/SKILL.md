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

3. If the log file does not exist, create it with the daily log template.

4. Review the full conversation history and write a concise session summary covering:
   - What was worked on (key topics, files, repos)
   - Decisions made
   - Tasks completed or created
   - Any unresolved items or next steps

5. Append the summary to the `## Log` section of today's daily log:
   ```
   ### Session HH:MM (<context>)
   - bullet point summary entries
   - **Next:** what to pick up next time (if applicable)
   ```

6. Update project/area files if tasks were completed or created:
   - Mark completed tasks `[x]`
   - Add new tasks as `[ ]`
   - Add/update `[~]` waiting items
   - Update `## Notes` with decisions

7. If any tasks or follow-ups came up that aren't in a project/area, add them to `inbox.md`.

8. Commit:
   ```bash
   cd "$JORNAL" && git add inbox.md areas/log/ projects/ areas/ resources/ archive/ && git commit -m "log: YYYY-MM-DD session notes"
   ```

## Rules

- Do NOT ask the user any questions. Summarize automatically from conversation context.
- Keep the summary concise — bullet points, not paragraphs.
- If today's log already has content, append to it; never overwrite existing entries.
