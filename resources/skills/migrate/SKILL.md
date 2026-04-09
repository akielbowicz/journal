---
name: migrate
description: "Bullet journal migration ritual. Process inbox, review waiting tasks, clean up stale items. Trigger when the user says /migrate, 'process inbox', 'clean up tasks', or 'review tasks'."
---

# Migrate

Bullet journal migration: review inbox and waiting tasks, decide what to do with each.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Read `$JORNAL/inbox.md`.

3. Read all project files: `$JORNAL/projects/*.md` (skip `_index.md`).

4. Read all area files: `$JORNAL/areas/*.md` (skip `_index.md`).

5. Collect all `[~]` waiting items across projects and areas.

6. Present items for review in groups:

   **Inbox items** — for each unprocessed item (lines starting with `- YYYY-MM-DD`), show the item with its age and suggest an action:
   - `[>] Migrate` — move to a specific project or area (ask which one)
   - `[-] Cancel` — no longer relevant
   - `[<] Schedule` — defer to a specific date
   - `Keep` — leave in inbox for now

   **Waiting items** — for each `[~]` item, ask:
   - Still waiting? (keep as `[~]`)
   - Resolved? (change to `[x]` or `[ ]` to continue)
   - No longer needed? (change to `[-]`)

7. Apply the user's decisions:
   - For migrated items: mark `[>]` in inbox with destination note, add as `[ ]` in the target project/area file
   - For cancelled items: mark `[-]` in inbox
   - For scheduled items: mark `[<]` in inbox with date
   - For waiting items: update status in project/area file

8. Commit:
   ```bash
   cd "$JORNAL" && git add inbox.md projects/ areas/ && git commit -m "inbox: migrate"
   ```

## Output format

After processing:

---
**Migration complete**

- N items migrated to projects/areas
- N items cancelled
- N items scheduled
- N items kept in inbox
- N waiting items reviewed

---

## Rules

- Always show the item's age (days since capture date).
- Group inbox items by related project/area when possible.
- If an inbox item is already tracked in a project file, suggest cancelling the inbox copy.
