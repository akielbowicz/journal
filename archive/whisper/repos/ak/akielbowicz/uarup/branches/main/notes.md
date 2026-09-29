### 2026-09-08 10:47 — snap
- Session: login verified working; full sync (8,977 msgs); added archived/pinned tracking, alias/name chat refs (`alias` cmd + resolver), `backfill` command (resumable full-history pull, src/backfill.ts), chats/info report commands + scripts/ helpers (chat-names/list/info/csv/download), media retry fixes
- Key findings: Baileys rc14 media re-upload checks `error.status` but its Boom errors carry `output.statusCode` (retry never fires) AND omits 403 (expired URLs) — reimplemented in exporter.ts with `updateMediaMessageWithLid`; ALSO account is LID-migrated so receipts must target `me.lid` not `me.id` (fixed → some retries now succeed)
- Known limitation: old own-sent media in LID groups re-serves MAC-mismatched blobs (device re-encrypts; unrecoverable client-side); re-uploads are nondeterministic — failed downloads aren't cached, so re-running chat-download.sh can recover files later
- **Next:** `backfill` large chats incrementally (`--max` caps per run, re-run to continue); consider cron/systemd setup for `watch` with uarup.toml; optionally investigate newer Baileys forks for LID media-retry fixes

### 2026-09-08 — session: EMHVE media fully recovered via phone ingest
- Root cause chain: account is LID-migrated (server-side PN→LID rollout, creds have both id+lid); phone re-keys own-sent media during thread migration → retry responses fail GCM MAC check (Baileys issue #2714, closed stale, no upstream fix)
- Shipped: (1) failures.jsonl permanent-failure cache + export --force (EDGE-001); (2) updateMediaMessageWithLid phone-JID fallback on re-upload (3)/timeout (EDGE-002); (3) `media-ingest --chat <ref> [--dir] [--dry-run]` — matches messages to WhatsApp/Media phone files by exact fileLength + date token ±1d (UTC vs local midnight) + ext; loose audio mime rule (audio/mp4 ↔ .aac) needed for voice notes
- Key facts: WA names files IMG/VID/AUD/DOC-YYYYMMDD-WA<seq> in *local* send time; Sent/ + Documents/Sent/ subdirs hold own uploads incl. chat-export zips; find -printf over adb is fast, per-file stat is not
- Result: EMHVE 176/176 media recovered (was 10/176); both chat-export zips pulled; 26MB 08-05 export preserved at data/media/<jid>/exports/ sidecar (mediaFileName collision — bd ticket filed)
- Run order note: file-exists check precedes failure-cache skip in downloadAttachment, so ingested files are referenced despite stale failure entries

### 2026-09-08 — session: ingest rolled out to 3 more chats
- Notas CHCM (110 media): 73 recovered via phone, 37 dead (34 gone-beyond-retention remote media from 2025-09..11 + 3 mac-mismatch) — true dead ends
- Por mis pagos (35): 35/35 ✓; la-vida-privada-de-los-arboles: 1/1 ✓; MONITORIA was already 38/38 ✓
- Gotchas confirmed: "already have" counts can include duplicate-docName collisions (mediaFileName collision, bd open); export transcript attachment refs count with `grep -o '<attachment: [^>]'` (doc names can start lowercase)
- ptvMessage (view-once) is not in isMediaMessage — invisible to exporter; separate from media counts

### 2026-09-10 17:12 — snap
- EMHVE: 5 pics sent 2026-09-10 undownloadable — stored as CIPHERTEXT stubs ("No session found to decrypt", message payload absent at 16:25 while the 16:11 PDF decrypted fine → transient session break)
- Shipped (cd99fea + 0d976b5): storage stub-upgrade (appendMessages replaces stored stubs on same-id re-delivery; loadMessages prefers real over stub; protobuf Long timestamps normalized), scripts/recover-stubs.mjs (PLACEHOLDER_MESSAGE_RESEND PDO — recovered all 5 pics + 3 older stubs), rule-of-5 review fixed argv[3] timeout bug + identical-content rewrite guard
- Backfill structural limit confirmed in Baileys source: HISTORY_SYNC_ON_DEMAND anchors at the OLDEST stored msg, fetches older-only → newest stubs unreachable by design; phone PDO resend window is ~14 days (3 July-era stubs got no response)
- Docs: README "Troubleshooting: undecryptable messages (CIPHERTEXT stubs)" — detect via rg -l 'No session found' data/messages/, older stubs → media-ingest; bd uarup-6ee closed; both commits pushed
- **Next:** if new stubs appear (detect one-liner), run `npx tsx scripts/recover-stubs.mjs <chatJid>` with phone online; consider wiring stub detection into `sync` output; open item: mediaFileName collision (uarup-aos/uarup-w8u)

### 2026-09-15 16:19 — session: bulk download complete (437/437 chats done)
- Shipped `scripts/download-all.sh`: per-chat backfill loop + ONE full export pass at end (per-chat export was a design gap — done chats skipped entirely, so live re-msgs never re-exported and transient media never retried). State markers `data/download-all/{done,failed}/<sanitized-jid>`; run log + per-chat logs in `logs/`; `--limit` pacing; `--requeue` clears failed
- `backfill --json` → `RESULT {...}` line (exhausted/capped) for scripting
- `link` command → `data/by-name/` symlink view (slugified names → transcripts/media); export auto-covers chats known only by stored messages (merge message-dir filenames into jid set — LID chats with no metadata)
- Bug: VALID_JID lacked `@broadcast`/`@newsletter` suffixes → status@broadcast unresolvable every run; fixed + regression test
- Media audit (2026-09-15): 4,132 media msgs → 636 on disk, ~3,172 permanent mac-mismatch (LID rekey ceiling, matches 09-08 findings), ~324 transient (auto-retried each run now). Transcripts 443/443. media-ingest (adb, phone storage) is the only path for mac-mismatch
- **Next:** periodic `download-all.sh` runs for maintenance; per-chat `media-ingest` if mac-mismatch media matters
