---
name: wrap-up
description: "End-of-day review across all projects. Synthesizes work-queue entries into the log, flags undocumented work. Trigger when the user says /wrap-up, 'end of day', 'day review', or 'daily close'."
---

# Wrap-Up

End-of-day sweep: pull all queued session snapshots into the log, check every project for missing documentation, commit everything.

## Steps

1. Resolve journal path:
   ```bash
   JORNAL="${JORNAL:-$HOME/para/areas/dev/gh/ak/journal}"
   ```

2. Get today's date and time.
   Derive log path: `$JORNAL/areas/log/YYYY/YYYY-MM/YYYY-MM-DD.md`
   Create it if missing using the daily log template:
   ```markdown
   # YYYY-MM-DD

   ## Focus
   - what the day is about

   ## Log

   ## Tasks created

   ## Decisions
   ```

3. Read `$JORNAL/workqueue.md`. If it doesn't exist or has no `##` entries, skip to step 5.

4. Group workqueue entries by project slug (slug = last segment after ` — ` in the `##` header line).
   **Date handling:** entries may span multiple days. For each slug group:
   a. Synthesize all entries into a coherent arc summary.
   b. If all entries are from today, append to today's log under `## Log`.
      If any entries are from prior days, label them as a backfill:
      ```
      ### Sessions HH:MM (<slug> — N sessions, backfilled from YYYY-MM-DD to YYYY-MM-DD)
      ```
      And note in the output: "Backfilled N sessions from <date range>."
   c. Use the log entry format:
      ```
      ### Sessions HH:MM (<slug> — N sessions)
      - synthesized bullet points covering what changed across sessions
      - **Arc:** what was accomplished overall
      - **Next:** final continuation point
      ```
      If `## Log` does not exist in the file, append the section header before the entry.
   d. Update `projects/<slug>.md` or `areas/<slug>.md` (whichever exists) if tasks were completed or created:
      - Mark completed tasks `[x]`
      - Add new tasks as `[ ]`
      - Add/update `[~]` waiting items

5. Read all project files: `$JORNAL/projects/*.md` (skip `_index.md`).
   Read all area files: `$JORNAL/areas/*.md` (skip `_index.md`).
   Slug = filename without `.md` extension.

   For each file, check:
   - Does it have open `[ ]` tasks?
   - Is there a log entry for this slug in today's log matching `### Session* (<slug>` (any date in today's log, any session count), OR was a workqueue entry for this slug processed in step 4?
   - If tasks exist and no session was logged today: mark it **undocumented**.

6. For undocumented projects/areas: add a reminder to `$JORNAL/inbox.md`:
   ```
   - YYYY-MM-DD — [<slug>] has open tasks but no session logged today
   ```

7. Clear the work queue — remove all entries dated **on or before today**.
   Entries dated **after today** are preserved as-is.
   Algorithm:
   - For each `## YYYY-MM-DD HH:MM — <slug>` block: if the date ≤ today, remove it (including its trailing `---`).
   - If no entries remain, restore the header-only template:
     ```markdown
     # Work Queue

     Sessions captured with /next — processed by /close or /wrap-up.

     ---
     ```
   - The file's top-level `# Work Queue` header is **never** removed.

8. Commit:
   ```bash
   cd "$JORNAL" && git add workqueue.md inbox.md areas/log/ projects/ areas/ && git commit -m "log: YYYY-MM-DD wrap-up"
   ```

## Output format

---
**Wrap-up: YYYY-MM-DD**

**Sessions processed** *(from work queue)*
- `<slug>`: N session(s) — one-line arc summary *(note if backfilled)*
- *(none)* if work queue was empty

**Undocumented projects** *(open tasks, no session today)*
- `<slug>`: N open tasks
- *(none)* if everything is current

**Inbox additions** *(if any)*
- items added for follow-up

---

## Rules

- Do NOT ask questions — process everything automatically.
- If the work queue is empty and all projects are current, say so and exit cleanly.
- Never delete workqueue entries that belong to future dates.
- Keep synthesized summaries concise — bullet points, not paragraphs.
