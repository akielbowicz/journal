# Genesis Adoption — Release Status (2026-07-28)

## Published to crates.io
- **testaruda**: v0.2.4 ✅ (was v0.1.0)
- **espectacular**: v0.3.0 ✅ (was v0.2.0)
- **dont** (dont-cli): v0.2.2 ✅ (already synced)
- **pretender**: v0.3.1 ✅ (already synced)

## Not yet published / pending
- **wai** (wai-cli): current stable 2026.5.3, HEAD 2026.7.16 — CI release in progress (build.rs include fix)
- **vampiro**: v0.1.0 — new tool, never published
- **crua / livin**: spec stage only, no crate

## CI pipeline issues (all tools)
All three release.yml workflows had the same `--locked` + `cargo publish dirty` bugs.
Fixed across testaruda, espectacular, and wai repos.
The release workflow has NEVER succeeded before this round.