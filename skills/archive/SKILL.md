---
name: archive
description: "Move a completed project or inactive area to the archive. Trigger when the user says /archive <name>, 'close project <name>', or 'archive <name>'."
---

# Archive

Move a completed project or inactive area to the archive directory.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Identify the target. The user says `/archive <slug>`. Match against:
   - `$JORNAL/projects/<slug>.md`
   - `$JORNAL/areas/<slug>.md`
   - If no exact match, list available and ask.

3. Read the matched file. Show:
   - Total tasks: open `[ ]`, completed `[x]`, waiting `[~]`, cancelled `[-]`
   - Any open or waiting tasks that would be lost

4. If there are open `[ ]` or waiting `[~]` tasks, ask the user what to do:
   - Mark them `[-]` cancelled?
   - Migrate them `[>]` to another project/area?
   - Complete them `[x]`?

5. Once confirmed, move the file:
   ```bash
   mv "$JORNAL/projects/<slug>.md" "$JORNAL/archive/<slug>.md"
   ```

6. Update `_index.md`:
   - Remove the entry from `projects/_index.md` or `areas/_index.md`
   - Add entry to `archive/_index.md` with today's date

7. Commit:
   ```bash
   cd "$JORNAL" && git add projects/ areas/ archive/ && git commit -m "archive: close <slug>"
   ```

## Output

---
**Archived: <name>**
- N tasks completed, M cancelled, K migrated
- File moved to `archive/<slug>.md`

---
