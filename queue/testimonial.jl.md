# Queue: testimonial.jl

Sessions captured with /next — processed by /close or /wrap-up.

---
## 2026-07-21 12:49 — testimonial.jl

- Completed 11 Component Boundary tickets in a single session (o50, 2fl, 3ig, 3ok, 2jw, h1o, r24, 440, 22g, 5bn + state cleanup commits)
- Data model: TestItemRef.component field, CoverageIndex.inter_component_edges, SCHEMA_VERSION 2
- Persistence: per-component indices at .testimonial/components/<name>/index.jls, routing file, component graph at .testimonial/graph.jls
- Migration: migrate_index() converts old flat to per-component layout
- Query engine: all providers accept component= kwarg for scoped queries
- **Next:** claim 1jn — Implement bottom-up component resolution in smart_run

---

## 2026-07-21 16:11 — testimonial.jl

- Completed the **Component Boundary** epic (sections 1–7): bottom-up resolution, parallel per-component queries, dependency fingerprints, selection cache, cache invalidation, TOML components override
- Fixed pre-existing bug in `_save_per_component_indices`: relative test file paths not normalized to absolute before component matching
- Files touched: `src/CLI.jl`, `src/IndexBuilder.jl`, `src/Testimonial.jl`, plus 5 new test files
- **Next:** pick up Shard plan section (7.1–7.3) or move to next epic (Safety Invariants, Runtime Feedback, etc.)

---

## 2026-07-21 16:21 — testimonial.jl

- Investigated and fixed CI failure on `main` — `using TOML` in source but `TOML` was missing from committed `Project.toml [deps]`
- Committed fix (`ed682f0`) and pushed — pre-push hook passed all 680 quick tests
- **Next:** verify CI passes on the next run, then pick up Shard plan (section 7.1) or next epic

---