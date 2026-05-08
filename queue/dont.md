# Queue: dont

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 15:39 — dont

- Evaluated codebase completeness: ~60% done (63/105 issues closed); three in-progress specs (rule engine, spawn/harness, import system) each block large clusters
- Claimed and implemented `dont-8os` — `.dont/` directory layout validation in `Project::open()` with `LayoutInvalid` error variant, exit code 3, and `dont init` remediation hint
- Ran Rule of 5 review; found `REQUIRED_SUBDIRS` divergence (HIGH), misleading error message (LOW), and inconsistent test teardown (LOW) — all three fixed
- Committed `feat(layout): validate .dont/ subdirectory layout on project open`
- **Next:** push the commit, then pick up next unblocked issue — shell completions (`dont-8h2`) or config.toml sections (`dont-2tl`, `dont-h8c`, `dont-gl0`) are all ready

---

## 2026-05-08 15:57 — dont

- Validated and closed `dont-3so` (improve-cli-ergonomics milestone): all 26 openspec checks passed, Locked state reachable via full CLI path
- Implemented `dont-2tl`: new `src/config.rs` with `Config`/`ImportConfig`/`VerifyEvidenceConfig`/`DefineShapeConfig` structs; wired into `dont import` (adapter-disabled gate), `verify-evidence` (default timeout), and `validate_label` (shape toggles)
- Added `tests/config.rs` covering all three config surfaces; full test suite green, clippy clean
- Committed and pushed `feat(config): parse [import] [verify_evidence] [define.shape] config blocks`
- **Next:** pick up `dont-h8c` (`[trust.hedges]` and `[rules]` severity blocks) or `dont-gl0` (`[project]` `[output]` `[storage]` blocks) — config infrastructure is now in place

---

## 2026-05-08 16:11 — dont

- Implemented `dont-h8c`: `TrustHedgesConfig`, `TrustConfig`, `TermNonfunctionalConfig`, and `RulesConfig` structs wired into `Config`
- `contains_hedge` now merges hardcoded `DEFAULT_HEDGES` with project-config patterns; both `dont trust` and `dont ignore` load config before the hedge check
- `dont define` emits `term-nonfunctional-label` warning when `[rules.term_nonfunctional].enabled = true` and the label matches a configured pattern
- `dont prime` reflects `[rules].warn` and `[rules].strict` lists; removed `[trust.hedges]` from init template to avoid duplicate TOML table conflicts
- Committed and pushed `feat(config): parse [trust.hedges] and [rules] severity blocks`; closed `dont-h8c`
- **Next:** `dont-gl0` (`[project]` `[output]` `[storage]` blocks) — the last config.toml cluster

---

## 2026-05-08 16:30 — dont

- Reviewed epistemic/ontological system status: FSM, evidence, atoms, hedges fully wired; import adapters and reasoning engine still stubs (~60% done)
- Closed `dont-yve` (rule engine spec — already complete via archived `add-dont-rules-specs`)
- Implemented `dont-8cs`: `RuleEngine` in `src/rules/mod.rs` with `evaluate()`, `severity()`, warn/strict dispatch, mode escalation; `Store::run_rule_query()` wired; 9 tests green; pushed to main
- **Next:** implement individual shipped rules (`ungrounded`, `lockable`, `stale-cascade`) — all unblocked now; or tackle `dont-pnx` (MCP server, P1, no blockers)

---
