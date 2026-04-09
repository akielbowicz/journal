---
name: jlog
description: "Open or create today's daily log entry and append notes. Trigger when the user says /jlog, 'log this', 'add to today's log', or wants to record a decision or session note."
---

# Journal Log

Open or create today's daily log entry and append content.

## Steps

1. Resolve the journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```
2. Get today's date: `date +%Y-%m-%d`. Derive the log path:
   ```
   $JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md
   ```
3. If the file does not exist, create it with the daily log template:
   ```markdown
   # YYYY-MM-DD

   ## Focus
   - (to be set)

   ## Log

   ## Tasks created

   ## Decisions
   ```
   Create intermediate directories with `mkdir -p`.

4. If the user provided text (e.g., `/jlog deployed the fix for X`), append it under `## Log` with a timestamp:
   ```
   - HH:MM — <text>
   ```
   If no text was given, read the file and show its current contents so the user can decide what to add.

5. Confirm what was written.

Do not commit.
