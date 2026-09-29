
### 2026-09-29 09:29 — snap
- Reviewed the bajan board with issue-review: fixed bajan-2xv metadata.files (string → JSON array), anchored base_commit on all 5 issues, added meters/anti-goals/regression clauses to the three spec issues, deferred bajan-oyw (upstream specodelic#1)
- Found and fixed a real infra bug: beads export.auto was false → .beads/issues.jsonl stale since Sep 28; set export.auto=true, flushed export (8 issues), configured dolt remote origin from git origin, bd dolt push done — tracker state now truly on remote
- Board state: 4 ready issues — bajan-2xv (P2 scaffold, fully gated), bajan-i2a (eval.claims spec), bajan-ahs (query.tools spec, carries sequencing rule for the vertical-slice implementation issue), bajan-zpw (entity.review spec)
- Spec corpus: 3 lint-clean specs (ingestion.contract, extraction.claims, graph.model), pipeline seams declared (persisted≡pending, staged≡proposed), claim schema frozen at 7 fields, tags are lineage-walk projection
- **Next:** claim bajan-2xv and scaffold the Rust CLI (clap + genesis envelope, stub modules ingest/extract/resolve/query); the earlier premature attempt was reverted on purpose — specs are now ready for it
