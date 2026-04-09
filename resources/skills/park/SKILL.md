---
name: park
description: "Snapshot current work before switching context. Trigger when the user says /park, 'park this', 'pause this', 'switching to', or 'context switch'."
disable-model-invocation: true
---

# Park

Snapshot the current session's work before switching context. This is NOT end-of-day — just a context switch.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Get today's date and current time.

3. Read today's log: `$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`
   If it doesn't exist, create it with the daily log template.

4. Review the conversation history to determine:
   - What project/area was being worked on
   - What was accomplished in this session
   - What the logical next step is
   - Any new tasks, decisions, or blockers discovered

5. Append a session entry to today's log under `## Log`:
   ```
   ### Session HH:MM (<project/area context> — parked)
   - what was done
   - decisions made
   - **Next:** what to do when resuming
   ```

6. Update the relevant project/area file if needed:
   - Mark completed tasks `[x]`
   - Add new tasks discovered during the session
   - Add/update `[~]` waiting items with context

7. If there are uncommitted changes in the project's git worktree, note them in the log entry.

## Output format

---
**Parked: <project/area name>**

**Session summary**
- what was accomplished

**Next step** *(for when you /resume)*
- the logical continuation

---

## Rules

- Do NOT ask questions — summarize automatically from conversation context.
- Keep it brief — this is a quick snapshot, not a full report.
- Do NOT commit the journal repo.
