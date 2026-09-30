### 2026-09-30 13:39 — snap
- Por mis Pagos media fully recovered: 108/108 media messages have their own file (incl. 29× Comprobante_.pdf dedupe via `assignMediaFileNames`, src/storage.ts); transcript re-exported with real filenames
- Fixed media-ingest matcher (uarup-h7l, closed): stickers skip date-window (STK- pack dates ≠ send dates), documents match by exact basename despite mime/ext mismatch (e526373)
- Added local phone cache: media-ingest now bulk-pulls the WhatsApp media tree to data/phone-media/ (incremental diff after), then matches offline — phone can be unplugged after sync (d93cc17)
- All-chat recovery in progress: pass 1 recovered 2,236 files (1942/4138 media messages have files); pass 2 aborted at phone disconnect (~61 more)
- **Next:** reconnect phone → run one `media-ingest` to sync data/phone-media/ cache → loop media-ingest over all `data/media/*/` JIDs (no adb needed) → final audit → re-export transcripts for recovered chats
### 2026-09-30 15:11 — snap
- Built media classifier (uarup-04n, pushed 518485e): src/classify.ts pure bucketing + 10 tests, scripts/classify-media.mjs walks data/media → data/classification.jsonl sidecar (sharp dims/alpha, pdfinfo/pdftotext, --ocr via tesseract spa+eng + pdftoppm, --files-from incremental)
- Classified 1,848 records: 1520 image / 155 sticker / 87 receipt / 75 document / 10 scanned-pdf (DNI-type, no text) / 1 unreadable; audio+video intentionally skipped
- Lessons: full-image OCR too slow for one pass (~30 min) → incremental --files-from; PDF-OCR needed per-call temp names (parallel race fixed)
- **Next:** optional OCR pass over the 1520 `image` bucket (screenshot/receipt-image split) or join classification back to chats via data/by-name/
