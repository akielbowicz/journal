# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 20:17 — dont

- Implemented `rule-claim-structure` lint rule (Phase 2 of `add-rule-claim-schema` OpenSpec): Rust rule, config, registration, translation doc, howto
- Ran full Ro5 review; 13 issues found across draft/correctness/clarity/edge/excellence stages
- Applied all fixes: Doubted claims now skipped in evaluation, two new tests (severity + dispatch), docs updated for silent misconfiguration, substring edge case, case-sensitivity, mandatory slots table ambiguity, concrete howto example, troubleshooting section
- OpenSpec change archived as `2026-05-08-add-rule-claim-schema`; committed and pushed at `78f60f4`
- **Next:** check `bd ready` for next available issue; consider adding the `rule-claim-structure` rule to a live project config to validate real-world usage before declaring it stable

---

## 2026-05-08 18:20 — dont

- Investigated how `dont` enforces claim consistency without a `--no-verify` bypass — enforcement is in-binary (Rust match + exit 1), not a skippable hook
- Added `dont prime` as a pre-commit gate in `prek.toml` and wrote `docs/enforcement.md` covering all 6 in-binary gates plus git/Claude Code/CI integration points
- Applied 5 Ro5 corrections to `enforcement.md`: `Severity::Strict` naming, `term:uuid` in rule descriptions, `dont flag` parenthetical, "permissive mode" clarification
- **Next:** wire the Claude Code `Stop` hook in `.claude/settings.local.json` (write was blocked pending approval) so doubted claims surface at session end

---
