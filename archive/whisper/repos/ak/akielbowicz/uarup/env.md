
## WhatsApp media archive layout (2026-10-01)
- `data/media/<jid>/` is per-chat subdirectories — filenames are message IDs or derived names; NEVER grep flat top-level names
- Media failures: `device re-served media that does not match` is transient (retry with `export --media --force` — download-all.sh cannot pass --force); `404 beyond WhatsApp retention` is terminal
- Bulk phone-media recovery already exists: `media-ingest --chat <ref> [--dir data/phone-media/Media]` (size+date+ext match, canonical names, bypasses LID re-key); loop over jids in data/messages for bulk
- Phone pull: `adb pull /sdcard/Android/media/com.whatsapp/WhatsApp/Media data/phone-media/` (~8.5 GB / 11k files, ~8 min)
- `scripts/download-all.sh` state markers: `data/download-all/{done,failed}/` — mv aside to force re-backfill; bak dirs left as `*.bak-20260930`
- pgrep self-match trap: `pgrep -f <pattern>` where pattern appears in the invoking shell command matches itself → false "RUNNING"; check log freshness/summary lines instead
