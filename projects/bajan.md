# bajan

Rust CLI knowledge-extraction pipeline (charly-vibes/bajan): episodes → typed claim
proposals → human-only adoption, governed by specodelic specs (`specs/*.md`) +
openspec (`openspec/`). Tracked in beads (`bd`, embedded). Turu-managed branch
knowledge under `cv/charly-vibes/bajan`.

## Tasks
- [ ] bajan-aan — [bug] main: exit non-zero on ok:false envelope
- [ ] bajan-ts6 — [bug] cli: argument errors bypass suite envelope contract
- [ ] bajan-cdi — cli: replace `Result<(),_>` stub signatures as modules un-todo
- [ ] bajan-i2a — author eval.claims spec (extraction precision/recall harness)
- [ ] bajan-ahs — author query.tools spec (read-side commands)
- [ ] bajan-zpw — author entity.review spec (HITL merge-queue)
- [ ] bajan-6sw — specs: ingestion resubmission policy decisions
- [ ] bajan-15i — deps: pin deterministic NLP/IR crates
- [ ] vertical-slice persistence ticket (SQLite) — splits store.rs (874 lines)

## Notes
- update-extraction-provenance change fully applied + archived 2026-09-29;
  all 7 sub-issues closed; espectacular contracts (15) wired and green.
- Convention: spec kebab reason names → snake_case codes in code.
- `ah scenario new` only works pre-archive; post-archive, hand-author contracts.
