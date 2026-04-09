---
name: standup
description: "Generate a daily standup summary from recent work journal log entries. Trigger when the user asks for a standup, daily summary, or 'what did I do yesterday'."
disable-model-invocation: true
---

# Standup

Generate a concise standup summary from recent journal logs.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```
2. Get today's and yesterday's dates.
3. Read yesterday's log: `$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`.
4. Read today's log (if it exists).
5. Read active project files under `$JORNAL/projects/` (skip `_index.md`).
6. Collect open tasks and blockers (`[~]` items).

## Output format

**Yesterday**
- bullet points of completed or progressed work

**Today**
- bullet points of planned work (from open tasks, focus, and areas)

**Blockers**
- any `[~]` waiting items, or "None"

Keep it brief — standup format, not a full report.
