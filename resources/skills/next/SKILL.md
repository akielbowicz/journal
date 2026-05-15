---
name: next
description: "Rapid session snapshot to the work queue — no full close ceremony. Trigger when the user says /next, 'snap', 'quick save', 'stash session', or 'moving on'."
disable-model-invocation: true
---

# Next

Snapshot the current session to the work queue and move on. Fast — no project file updates, no inbox triage.

## Steps

1. Resolve journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Get timestamp: `date +%Y-%m-%d` and `date +%H:%M`

3. Detect project slug from the current working directory:
   ```bash
   RAW=$(git remote get-url origin 2>/dev/null | sed 's/.*\///' | sed 's/\.git$//')
   [ -z "$RAW" ] && RAW=$(basename "$PWD")
   [ "$PWD" = "$HOME" ] && RAW="general"
   SLUG=$(echo "$RAW" | tr ' /()' '----' | tr '[:upper:]' '[:lower:]')
   ```

4. Scan the last portion of the conversation and write a 2–5 bullet snapshot:
   - What was worked on (files, topics, repos)
   - Key decisions or changes made
   - **Next:** the most logical continuation point

5. Write the entry using the Write or Edit tool (not a shell heredoc). Target: `$JORNAL/queue/$SLUG.md`.
   First ensure the directory exists:
   ```bash
   mkdir -p "$JORNAL/queue"
   ```
   If the file doesn't exist, create it with this header:
   ```markdown
   # Queue: <slug>

   Sessions captured with /next — processed by /close or /wrap-up.

   ---
   ```
   Then append the session entry:
   ```markdown
   ## YYYY-MM-DD HH:MM — <slug>

   - bullet describing what was done
   - another bullet if needed
   - **Next:** what to pick up

   ---
   ```
   Never overwrite or edit existing entries — only append.

6. Commit:
   ```bash
   cd "$JORNAL" && git add "queue/$SLUG.md" && git commit -m "wq: YYYY-MM-DD $SLUG"
   ```

## Output format

---
**Queued: <slug>**

- snapshot bullets

*Continue with `/renew <slug>`, finalize with `/close`, or end the day with `/wrap-up`.*

---

## Rules

- Do NOT ask the user any questions.
- Keep it to 2–5 bullets — this is a checkpoint, not a full log.
- Never overwrite or edit existing queue entries.
