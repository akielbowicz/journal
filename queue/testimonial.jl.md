# Queue: testimonial.jl

Sessions captured with /next — processed by /close or /wrap-up.

## 2026-07-15 15:03 — testimonial.jl

- Full toolchain setup: beads/dolt (sync: dolt-native, auto-backup to issues.jsonl), pretender, espectacular, testaruda, lefthook (4 hooks), justfile (30+ recipes), GH Actions (CI + nightly recording), CONTRIBUTING.md, wai projections
- Created 196 beads issues (7 epics + 172 tasks) from openspec tasks.md with priorities, descriptions, and parent-child hierarchy
- Ran issue-review skill — added 59 dependency links, merged 7 fine-grained tasks, backfilled descriptions for all P0/P1 tasks
- **Next:** Start implementing coverage layer MVP — begin with scaffold tasks: create Project.toml (testimonial-mar), src/Testimonial.jl (testimonial-0r5), test/runtests.jl (testimonial-3dk), scripts/TestimonialRunner/Project.toml (testimonial-bt2)

---

## 2026-07-15 16:20 — testimonial.jl

- Adopted two-layer architecture (standalone Julia core + testaruda adapter protocol)
- Rewrote openspec project.md, implement-coverage-layer (proposal, design, specs,
  tasks) across 13 files; added protocol-adapter spec (PROTO-001..007)
- Updated beads issues: 4 retitled, 16 closed, 69 deferred, 38 descriptions backfilled
- Ran rule-of-5-universal review (18 fixes) + issue-review (10 fixes)
- **Next:** Start implementing coverage layer P0 tasks — scaffold first
  (Project.toml, src/Testimonial.jl, test/runtests.jl)

---

## 2026-07-15 18:54 — testimonial.jl

- Verified and fixed all toolchain tools: dont init, lefthook install, espectacular version drift + pytest adapter, testaruda init
- Filed bug report for wai sync destructively overwriting justfile (beads: testimonial-2ph0)
- Documented TDD-Ro5 pipeline in AGENTS.md / CLAUDE.md (Red→Green→Refactor→/ro5 per ticket)
- Implemented and closed 2 P0 tickets: Project.toml bootstrap + core types (src/Testimonial.jl, 31 tests)
- Fixed Meta.parse → Meta.parseall in julia-syntax pre-commit hook
- **Next:** Continue P0 coverage layer implementation — pick up Persistence, ASTParser, or Query tickets

---

## 2026-07-15 20:14 — testimonial.jl

- Diagnosed and fixed CI: 3 failing jobs (pretender, espectacular, OpenSpec) all had broken download URLs or missing actions
- Fixed pretender/espectacular install: curl from charly-vibes/releases → cargo install from crates.io
- Fixed OpenSpec validation: missing GitHub Action → npm install @fission-ai/openspec + CLI command
- Committed .espectacular/config.toml (was gitignored, needed by CI)
- **Next:** Continue P0 coverage layer — pick up Persistence, ASTParser, or Query tickets

---