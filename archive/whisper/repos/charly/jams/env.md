# jams — Browser Audio Transcription with transformers.js

## Browser-based Whisper pattern (transcribir)

- **transformers.js** UMD build from CDN: `https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.2/dist/transformers.min.js`
- Pipeline: `window.transformers.pipeline('automatic-speech-recognition', modelId, { progress_callback })`
- Model IDs: `Xenova/whisper-tiny` (~40 MB), `Xenova/whisper-base` (~75 MB), `Xenova/whisper-small` (~250 MB)
- Models cached in IndexedDB automatically by transformers.js
- Audio input: `AudioContext.decodeAudioData()` for any browser-supported format
- Mono mixing: average all channels (not just channel 0 — some Android mics record muted channel 0)
- Resampling: `OfflineAudioContext(targetChannels, targetLength, 16000)` — create buffer at original sample rate, render at 16kHz
- **Chunking for long audio**: process in 30-second windows (Whisper's native window), accumulate text + timestamped chunks with offset
- **Timestamp output**: pipeline returns `result.chunks` with `{text, timestamp: [start, end]}`; accumulate all chunks, apply offset per segment, render as SRT or VTT
- MediaRecorder mimeType fallback: `audio/webm;codecs=opus` → `audio/webm` → `audio/ogg;codecs=opus` (Firefox) → `audio/mp4`
- Mic recording guard: disable button during `getUserMedia`, stop on `visibilitychange`
- Memory warning: PCM at 16kHz mono = ~4 bytes/sample; 100 MB ≈ 25 min audio
## transcribir PWA — key architecture decisions

- **SW registration must be in `<head>`**, not body-bottom. GitHub Pages rejects POST with 405; the SW must intercept before the server sees it. `mkcert -cert-file localhost.pem -key-file localhost-key.pem` for predictable filenames.
- **`Promise.allSettled` + per-URL `cache.add`** instead of `cache.addAll` for SW install — one non-cacheable URL (e.g. `./` on redirecting hosts) doesn't block the entire install.
- **Web Share Target Level 2** needs three things: (1) `share_target` in manifest with `POST` + `multipart/form-data`, (2) SW `fetch` handler for POST, (3) `LaunchQueue` consumer for warm starts.
- **Spleeter int8 ONNX** (~8 MB) is far more practical than Demucs (100-300 MB) for browser-based vocal separation. The `audio-to-audio` pipeline doesn't exist in transformers.js v2.x → use onnxruntime-web directly.
- **Spleeter model URL** (tested): `csukuangfj/sherpa-onnx-spleeter-2stems-int8` → `vocals.int8.onnx`. ONNX Runtime loaded dynamically from CDN (not bundled).
- **Loading overlay paint fix**: `await tick()` (50ms setTimeout) before `await pipeline()` — browser won't paint the overlay without yielding to event loop.
- **Per-chunk `.catch()`** on Whisper inference so one failed chunk doesn't kill the entire transcription.
- **All PWA versions** tracked via `VERSION` constant in `sw.js`; update detection via `updatefound` event.
