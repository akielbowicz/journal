---
name: capture
description: "Add a task, note, or follow-up to the work journal inbox. Trigger when the user says /capture, 'note that', 'add to inbox', 'remember to', or mentions a task to track."
---

# Capture

Add an item to the work journal inbox.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```
2. Run `date +%Y-%m-%d` to get today's date.
3. Read `$JORNAL/inbox.md`.
4. Insert a new line immediately after the `---` separator, in this format:
   ```
   - YYYY-MM-DD <text>
   ```
5. The text is what the user wants to capture. If they invoked `/capture <text>`, use that text.
   If no text was given, ask the user what to capture before editing.
6. Confirm the item was added.

Do not commit.
