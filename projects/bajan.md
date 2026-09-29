# bajan

Rust CLI knowledge-extraction pipeline (charly-vibes/bajan): episodes → typed claim
proposals → human-only adoption, governed by specodelic specs (`specs/*.md`) +
openspec (`openspec/`). Tracked in beads (`bd`, embedded). Turu-managed branch
knowledge under `cv/charly-vibes/bajan`.

## Tasks
- [ ] bajan-cdi — cli: replace `Result<(),_>` stub signatures as modules un-todo
- [ ] bajan-6sw — specs: ingestion resubmission policy decisions
- [ ] bajan-15i — deps: pin deterministic NLP/IR crates
- [ ] bajan-6hz — vertical-slice: ingest→extract→SQLite→first query (P2, ready; splits store.rs 914 lines)

## Done 2026-09-29
- [x] bajan-aan — main exits 1 on ok:false envelope (`cli::exit_code`)
- [x] bajan-ts6 — argument errors emit the suite envelope (`Cli::try_parse` + `argument_error_envelope`)
- [x] bajan-3w1 — argument_error message quality (Rule-of-5 review fix)
- [x] bajan-i2a — specs/eval-claims.md (eval.claims)
- [x] bajan-ahs — specs/query-tools.md (query.tools)
- [x] bajan-zpw — specs/entity-review.md (entity.review)

## Notes
- Spec corpus: 6 specodelic specs, 0 lint issues, 0 dangling refs; artifacts
  in `specodelic/` regenerated from spec source (source of truth = specs/).
- update-extraction-provenance change fully applied + archived 2026-09-29;
  espectacular contracts (15) wired and green.
- Convention: spec kebab reason names → snake_case codes in code.
- `ah scenario new` only works pre-archive; post-archive, hand-author contracts.
- Envelope contract: exit status mirrors envelope (bajan-aan); argument errors
  emit `argument_error` envelope, clap help/version still plain text exit 0.
