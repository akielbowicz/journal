# bajan

Rust CLI knowledge-extraction pipeline (charly-vibes/bajan): episodes → typed claim
proposals → human-only adoption, governed by specodelic specs (`specs/*.md`) +
openspec (`openspec/`). Tracked in beads (`bd`, embedded). Turu-managed branch
knowledge under `cv/charly-vibes/bajan`. Published on crates.io since v0.3.1.

## Tasks
- [ ] bajan-sbs — HITL gate: approve/reject openspec change add-optional-jev-verification (operator-only)
- [ ] bajan-4hv — implement add-optional-jev-verification (blocked on bajan-sbs; apply authors 14 contract TOMLs)

## Done 2026-11-11/12
- [x] bajan-o4t — specs debt: 2 delta-scenario executors authored, p-shape-rejection/p-evidence-ref folded, both changes archived, mirrors regen net-zero
- [x] bajan-r2a — latent proptest fix: dump_then_recreate asserts constructed (first-wins) graph, not generated batch
- [x] bajan-4gg/1an/nsh — CI onion: openspec pin 0.19.0→1.15.0, testaruda v0.5.9 installed, wai v2026.11.11, usable-store init guard; CI green end-to-end
- [x] bajan-r4u — crates.io publish verified: v0.3.1 live on crates.io (first publication), release.yml idempotent redrive
- [x] v0.3.0 + v0.3.1 released (tags, GitHub releases, Pages, homebrew/scoop taps)

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
- Delta scenarios are ephemeral: behaviors fold into the corpus-property contract (p-coverage-status pattern); the property mirror is the canonical deployed shape.
- Release shape: version bump + changelog + tag; release.yml builds 6 assets, updates homebrew-charly/scoop-charly, publishes crates.io (CARGO_REGISTRY_TOKEN rotated 2026-11-11; verified live).
- CI pins follow deliberate local installs (vampiro/bajan-23s precedent): openspec 1.15.0, testaruda v0.5.9, wai v2026.11.11, bd v1.3.0.
- `wai status` creates an empty `.testaruda` (zero-byte store.db) — justfile guards on a usable store; wai upstream fix candidate.
- crates.io API 403s bare curl without User-Agent.
- Envelope contract: exit status mirrors envelope (bajan-aan); argument errors
  emit `argument_error` envelope, clap help/version still plain text exit 0.
