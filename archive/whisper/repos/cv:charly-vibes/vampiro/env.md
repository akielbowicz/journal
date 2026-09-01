# vampiro — repo env / infra facts

## Publishing

- **10 crates, published in topological order** — cir → law → harness → rust-fe → seam → py/clj/jl-fe → lifecycle → vampiro
- **crates.io new-crate rate limit**: token-bucket pattern (~5 burst, then ~1 per 10-min refill). First publish of 10 new crates needs multiple rounds with ~10 min between each batch.
- **Self-healing publish** in release.yml: on 429, parses `Please try again after <RFC2822 date>`, sleeps until window clears + 30s buffer, retries (up to 6×).

## Cross-compilation

- **git2** needs `vendored-openssl` feature for cross-compilation (macOS, Linux-aarch64). Without it, `openssl-sys` fails to find system OpenSSL.
- Release workflow builds: Linux (x86_64 + aarch64), macOS (x86_64 + aarch64), Windows (x86_64).

## Workspace metadata

- All metadata hoisted to `[workspace.package]` in root Cargo.toml: license (Apache-2.0), repository, keywords, categories, rust-version.
- All 19 internal path deps use `{ path = "../...", version = "x.y.z" }` — version required for publishing.

## Tap repos

- Homebrew: `charly-vibes/homebrew-charly` → `Formula/vampiro.rb`
- Scoop: `charly-vibes/scoop-charly` → `bucket/vampiro.json`
- Requires `TAP_GITHUB_TOKEN` secret (PAT with repo scope to both tap repos).