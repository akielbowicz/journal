
## WhatsApp media archive layout (2026-10-01)
- `data/media/<jid>/` is per-chat subdirectories — filenames are message IDs or derived names; NEVER grep flat top-level names
- Media failures: `device re-served media that does not match` is transient (retry with `export --media --force` — download-all.sh cannot pass --force); `404 beyond WhatsApp retention` is terminal
- Bulk phone-media recovery already exists: `media-ingest --chat <ref> [--dir data/phone-media/Media]` (size+date+ext match, canonical names, bypasses LID re-key); loop over jids in data/messages for bulk
- Phone pull: `adb pull /sdcard/Android/media/com.whatsapp/WhatsApp/Media data/phone-media/` (~8.5 GB / 11k files, ~8 min)
- `scripts/download-all.sh` state markers: `data/download-all/{done,failed}/` — mv aside to force re-backfill; bak dirs left as `*.bak-20260930`
- pgrep self-match trap: `pgrep -f <pattern>` where pattern appears in the invoking shell command matches itself → false "RUNNING"; check log freshness/summary lines instead
- 2026-10-01T18:14:26Z [id:b4776a47360dbb32cf0177384c6186c7508683ef6bc7c81972135534562ac043] - execFile `input` option deadlocks tesseract on stdin (0 CPU, hung workers): classify-media.mjs now writes a temp PNG and passes the filename + 120s timeout (d91a30a). Same trap anywhere we pipe buffers into CLI OCR/converter tools
- 2026-10-01T18:24:34Z [id:b025d4f81512046fc32b0bffe1090edb0589b234c2d3b1a472b3bb608a07b6e5] - brew tesseract ships WITHOUT eng.traineddata; `-l spa+eng` silently degrades to spa and MRZ/OCR-B text (ID cards) returns empty. Fix: local tessdata at ~/.local/share/tessdata (eng from tessdata_fast + copied spa); classify-media.mjs auto-prefers it via TESSDATA_PREFIX. Photo-scanned docs need binarize (greyscale threshold ~45%) + upscale retry — plain OCR returns nothing on guilloche backgrounds
