# Queue: titi

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-07-27 19:33 — titi

- Created `add-test-item-detection` OpenSpec change: test-item-level detection, test-to-source edges, safety invariants, coverage ingestion — fills the gap between titi's project-level TIA and the per-test patterns from testaruda/Testimonial.jl
- Applied 5 spec deltas across domain-model, dependency-graph, cli, configuration, and new test-detection capability (26 requirements, 21 parsed deltas)
- Ran Rule of 5 universal review: found 18 issues (0 critical, 6 high); fixed all — origin label, VSTest .NET 10 syntax, parameterized tests, framework-aware filter, cache path unification, run-history retention, Cobertura correlation docs
- This change is a prerequisite for `add-testaruda-adapter`'s deferred Phase 2
- **Next:** either implement Phase 1 tasks (1.1–1.8 domain types) or advance `add-testaruda-adapter`'s blocking decisions

---
