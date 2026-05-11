# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-11 15:35 — dont

- Discussed and refined four change proposals: rename `dont lock` → `dont forget`, `--file` git provenance with rejection policy, `dt` alias with strict positive semantics, and ephemeral session wrapper
- Created four beads issues: `dont-4j4` (rename), `dont-lpk` (--file provenance), `dont-kxg` (dt alias), `dont-w36` (ephemeral sessions)
- Ran Ro5 and issue-review; all fix-all passes resolved — issues are complete with dependencies (`dont-kxg` → `dont-4j4`, `dont-w36` → `dont-lpk`) and schema clarifications (`commit_ref` field, `git:<sha>`/`content:<sha256>` prefix scheme)
- **Next:** pick up `dont-4j4` or `dont-lpk` as first implementation targets (unblocked; `dont-kxg` and `dont-w36` depend on them)

---
