# Queue: dont-cli

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-18 18:43 — dont-cli

- Investigated why agents don't use `dont` across 80 sessions (4,655 tool calls) — core lifecycle used 0 times
- Produced full findings report at `.wai/projects/dont/findings/executive-summary.md` with truth table, baseline comparison, CI gate analysis, UX friction evaluation, external project audit, agent meta-cognition analysis
- Fixed AGENTS.md and `dont prime` to include session ritual and `dont-grill` mention
- Strengthened dont instructions across 7 files in 4 external projects (espectacular, pretender, testaruda, miblioteca)
- **Next:** fix the `dont lock` bug (reported as broken — `dont forget` works but `lock` doesn't) and add `--depends-on` support to `dont ground`

---