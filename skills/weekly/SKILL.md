---
name: weekly
description: "Generate a weekly review from the last 7 days of work journal entries. Trigger when the user asks for a weekly summary, end-of-week review, or wants to plan next week."
disable-model-invocation: true
---

# Weekly Review

Generate a weekly review from the last 7 days of journal logs, project/area status, and waiting items.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```
2. Get today's date and the date 7 days ago.
3. Find and read all log files from the last 7 days under `$JORNAL/log/`.
4. Read all active project files under `$JORNAL/projects/` (skip `_index.md`).
5. Read all area files under `$JORNAL/areas/` (skip `_index.md`).
6. Read `$JORNAL/inbox.md` for unprocessed items.
7. Collect all `[~]` waiting items across projects and areas.

## Output format

### Accomplishments
- key things completed this week

### Project status
- one-line update per active project

### Areas
- anything notable from ongoing responsibilities this week

### Waiting on others
- [~] items and how long they've been waiting
- flag anything waiting more than 7 days

### Carried forward
- open tasks or unresolved decisions moving to next week

### Focus next week
- top 3 priorities

### Inbox to process
- inbox items that should be migrated, scheduled, or cancelled
- suggest running `/migrate` if there are more than 3 unprocessed items

Keep it actionable. Flag anything blocked or overdue.
