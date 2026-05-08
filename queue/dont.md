# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 18:20 — dont

- Investigated how `dont` enforces claim consistency without a `--no-verify` bypass — enforcement is in-binary (Rust match + exit 1), not a skippable hook
- Added `dont prime` as a pre-commit gate in `prek.toml` and wrote `docs/enforcement.md` covering all 6 in-binary gates plus git/Claude Code/CI integration points
- Applied 5 Ro5 corrections to `enforcement.md`: `Severity::Strict` naming, `term:uuid` in rule descriptions, `dont flag` parenthetical, "permissive mode" clarification
- **Next:** wire the Claude Code `Stop` hook in `.claude/settings.local.json` (write was blocked pending approval) so doubted claims surface at session end

---
