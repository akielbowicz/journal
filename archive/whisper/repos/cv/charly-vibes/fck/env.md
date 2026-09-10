
## Migrated from cv:charly-vibes

# fck — repo-wide environment facts

## 2026-09-09: Distribution + eval infrastructure

**OpenRouter pinned ids 404:** `anthropic/claude-sonnet-5` and
`anthropic/claude-opus-4.7` fail with an HTML 404 from the OpenRouter
gateway despite appearing in pi's cached catalog. The `~anthropic/*-latest`
aliases work. Eval defaults use `~anthropic/claude-sonnet-latest` and
`~anthropic/claude-opus-latest` (judge) — don't "fix" them back to pinned ids.

**pi print mode is enough for evals:** `pi -p --mode json --no-session` emits
a JSONL event stream; final assistant text = last `message_end` with
role assistant. Piped stdin merges into the initial prompt (used for context
injection). No SDK/SessionManager needed for batch evaluation — the first
SDK-based runner was deleted as over-engineering. Skills inject cleanly via
repeatable `--skill <path>` even under `--no-skills`.

**pi package layout:** repo with `skills/` (SKILL.md dirs) + `prompts/*.md`
+ `package.json` with `pi: {skills, prompts}` is installable as a pi package
(`pi install git:...`) AND as skills.sh skills (`npx skills add ...`) — same
files serve both. A `commands/` dir is inert in pi; pi's slash commands are
prompt templates from `prompts/`.

**Session mining gotcha:** pi session JSONL user messages live at
`.message.content[].text` — scanning 868 session files found 0 profanity;
real frustration surfaces as terse problem reports. Retrospective eval cases
inject the swear at the real failure moment instead of replaying verbatim.

**jq traps in eval scripts:** `test(.; "i")` inside `[arr[] | ...]` rebinds
`.` to the piped input (test the *response* as regex — silent wrong results);
`jq -R` reads per-line, need `-Rs` for multi-line capture; judge LLM output
needs `capture("(?<j>\\{[\\s\\S]*\\})")` — the `(?s)`/"s" flag form does NOT
make `.` match newlines in jq's oniguruma.
