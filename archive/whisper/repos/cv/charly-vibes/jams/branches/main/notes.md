### 2026-08-02 15:25 — snap
- Fixed two real Android Chrome failures: CDN ESM parser error (transformers.js ships `export{` — switched from `<script>` to dynamic `import()`) and SW unhandled rejection (added `.catch()`)
- Segregated debug logs into per-session files (`transcribir-session-<id>.jsonl`) with auto-pruning (50 sessions max)
- Added help panel (❓ bottom-right) with usage instructions, PWA install guide, and WhatsApp share flow; debug log accessible from within help
- Persisted model/language/separation settings via localStorage
- Improved `justfile` with LAN IP detection, cloudflared tunnel recipe, and USB forwarding instructions
- Added mkcert CA serving endpoint + startup instructions for SW cert trust
- **Next:** device test with transcription + verify share-target flow end-to-end

### 2026-08-02 18:40 — worker migration, UX simplification, bugs fixed
- **Module worker required:** transformers.js CDN ships ESM (`export{`). Use `new Worker('worker.js', { type: 'module' })` + dynamic `import()` — `importScripts()` throws SyntaxError on ESM.
- **Structured clone over transfer:** Zero-copy `[audioData.buffer]` detaches the buffer on every send. Use structured clone for re-transcription safety; keep `originalAudio` backup for restore.
- **Shell config:** `just` default shell (sh/dash) chokes on Unicode chars in recipes. Set `set shell := ["bash", "-c"]` for Unicode-safe echo commands.
- **Details persistence:** `<details open>` state should be persisted via localStorage alongside form settings to avoid confusion on reload.
- **Progress throttling:** For transcription >50 chunks, send progress every 5th chunk to avoid flooding main thread.
- **Next:** Device testing on Android; verify WhatsApp share end-to-end; translate mode