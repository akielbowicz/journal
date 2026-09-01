# espectacular repo knowledge

## Architecture notes

### `detect_slug_collisions` — two-pass count approach

The function in `src/openspec.rs` now uses a two-pass approach: first count
occurrences per `(spec_path, id)` key, then return ALL scenarios whose key
appears more than once. Previously it only returned the 2nd, 3rd+ duplicates,
leaving the first scenario unflagged — its tests would run while colliding
scenarios were blocked, masking the collision.

### `doctor.rs` collision diagnostic

The `for (slug, _spec, _id)` destructuring was misleading: `slug` was bound
to the spec_path (e.g. "compiler"), not the actual slug. Fixed to
`(spec, slug, _heading)` with a clearer message.