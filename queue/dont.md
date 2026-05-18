# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---
## 2026-05-18 14:15 — dont

- Read `~/Downloads/dont-evaluation.md` (research report on validating `dont` with LLM coding agents) and cross-checked it against the repo — found MCP, eval harness, adoption telemetry, and fake-dont control arm as key gaps
- Created OpenSpec change `add-eval-readiness` with three new specs: `dont-analytics` (`dont stats` verb), `dont-ephemeral-mode` (`--no-persist` flag as C2 control arm), and `dont-eval-export` (`dont export --eval` JSON dump)
- Ran Ro5 review on the new docs; applied all fixes (write-command filtering for idle-skill, env var value space, unknown-session rejection, privacy callout, failure-modes table, two new tasks)
- **Next:** start implementing the three new specs — begin with `dont-analytics` (retrospective join over event log, no new write-path); check `bd ready` for available tasks in the `add-eval-readiness` set

---
## 2026-05-13 17:33 — dont

- Implemented managed docs support for `dont`: canonical `.dont/AGENTS.md`, minimal root managed blocks, `doctor` checks, and `doctor --fix` repair flow.
- Added `tests/managed_docs.rs`, completed the `tdd-ro5` pipeline, addressed review findings, and archived the OpenSpec change into `openspec/changes/archive/2026-05-13-replace-sync-docs-with-doctor-fix/`.
- Closed epic `dont-ymdq`, pushed commits `0181853` and `bec7198`; remaining `git status` noise is only local `.wai/` / `.claude/` workflow artifacts.
- **Next:** decide whether to keep or clean the local workflow artifacts, then move to the next ready `bd` item or a new spec-alignment audit.

---
