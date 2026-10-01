### 2026-09-29 09:46 — snap
- Verified pre-commit/pre-push hard blockers were NOT enforced (no lefthook.yml; beads hook shims were silent no-ops)
- Added `lefthook.yml` wiring dont-gate, ah check, spk lint specs, pretender check on pre-commit; + ah check --run-tests & testaruda doctor on pre-push; added `.pretender/` to .gitignore
- Verified gates fire with staged files, propagate failure to exit 1; committed 02d0728 and pushed to main
- **Next:** no pending work from this task; next commit will exercise the gates end-to-end via real `git commit`/`git push`

### 2026-09-29 10:30 — snap
- Investigated donp/fpa `add-kb-pipeline` specs vs bajan's specodelic corpus; Rule-of-5 review corrected 2 findings (gm_schema_v1 conflict, human-only adoption actually a gap) → revised pickup table.
- Created approved OpenSpec change `openspec/changes/update-extraction-provenance/` (proposal/design/tasks + 2 deltas: extraction-claims, graph-model); validates --strict. Defers suspicion score + bootstrap gate (design D5).
- Filed beads tickets: epic `bajan-0hs` + 8 children with deps; spec tickets `bajan-0hs.1`/`.2` ready now; impl blocked by `bajan-2xv` (CLI skeleton). Issue-review pass applied metadata.files/base_commit fixes.
- **Next:** claim `bajan-0hs.1` (or .2) for specodelic edits; first resolve ALIGN-001 (dry-run `ah check` on a property without tests) and DEP-001 (design open question #2: audit-log location) — both noted on tickets.

### 2026-09-29 11:13 — snap
- Edge-case pass on ingestion idempotence (27 findings) → fixed the schema-shaped ones in ingestion-contract.md (typed absent marker replaces `unknown` sentinel, whitespace-only text/ids malformed, new ic_id_canon/ic_unique_id/ic_batch_resume/ic_outcome-schema + properties); rule-of-5 review caught + fixed whitespace-only-id licensing gap (4fc23fa, b5e4d36)
- Filed 3 decision tickets: bajan-6sw (resubmission policy: mutated update vs reject, rejected→persisted exit, intra-batch dup ids, empty stream + BIZ-006 reorder addendum, Must gate/Meter/anti-goals attached), bajan-vye (re-ingest after deletion), bajan-42y (parked-episode retry; blocked-by 6sw + 0hs.6)
- Issue-review remediation: re-anchored 12 tickets to HEAD, metadata.files for 0hs.3–.7 (approximated src paths — revalidate after 2xv), typed-absent convention notes on 0hs.1/0hs.2
- All pushed through c39e747; spk lint + ah check green; tree clean
- **Next:** claim bajan-2xv and scaffold the Rust CLI (clap + genesis envelope, stub modules ingest/extract/resolve/query) — board is READY_TO_WORK per issue-review

### 2026-09-29 13:15 — snap
- Investigated deterministic NLP tools for bajan's ingestion seams (no network: crate list unverified) — mapped spec tasks (ic_id_canon NFC, ex_no_llm_post simhash dedup, ex_reflection flags, ex_evidence_containment) to Rust crates; converter-side parsers stay upstream per ic_no_format_parsing
- Rule-of-5 review of the investigation: verdict READY-WITH-NOTES (converged stage 4); key corrections: chunking must be single-call input assembly per ex_single_call, SBD is alignment aid not gate, add language-coverage + short-episode dedup caveats
- Filed bajan-15i (P2): pin deterministic NLP/IR crates — two-table crate map, default+fallback picks, live-verify acceptance criteria, metadata.files=Cargo.toml, label branch:main; committed bcc41e9 and pushed
- **Next:** claim bajan-15i (live-verify + pin crates, extend p_no_llm_post generators with short/non-English episodes) or claim bajan-2xv scaffold — coordinate if both in flight (share Cargo.toml)

### 2026-09-29 16:09 — snap
- Landed bajan-2xv scaffold (clap + genesis envelopes, 4 stub modules, .cargo git-fetch-with-cli fix), then spec deltas bajan-0hs.1 (gm_human_adopt, gm_schema_v2, conjunction guard verified representable) and .2 (ex_supersession + supersede transition, ex_run_record, ex_evidence_containment; ex_typed_gate amended) — all gates green, pushed through 67140f7
- Rule-of-5 self-review of scaffold → 3 findings filed as tickets: bajan-aan (exit non-zero on ok:false), bajan-ts6 (arg errors bypass envelope), bajan-cdi (Result<(),_> stub trap); issue-review pass applied: .5/.7 now blocked-by .3, all 17 tickets re-anchored to 81d5f81, .3–.7 NOTES refreshed with Meters + anti-goals
- **Next:** claim bajan-0hs.3 (schema v2 evidence field + loud migration, creates src/store.rs; TDD red→green) — it gates .5 and .7; .4 and .6 also ready
### 2026-09-29 19:32 — snap
- Filed the RO5U code-review tickets: bajan-xa2 (ingest: implement bajan-6sw resubmission decisions — mutated→conflict reject, first-wins batch duplicates, corrected recovery path; red-first update of vertical_slice.rs:118), bajan-r1h (extract: gate-rejection honesty — record reason, decide caching, wire/defer ExtractionRunStore), bajan-2sj (store: sqlite read-path .expect panics → StoreError, envelope contract), bajan-3go (P3 tidy: dead run() stubs, cli.rs:364 doc dup, stale version envelope, misnamed budget test). All with metadata.files + base_commit + red-first shape + METER/anti-goals/regression. Sequenced: 3go blocks xa2/r1h/2sj (Tidy First, shared cli.rs).
- Ran issue-review (Rule of 5, converged pass 5, READY_TO_WORK) over the 8-ticket board: re-scoped bajan-cdi to the resolve seam only (premise superseded by 6hz + 3go deletions) and gated it behind 3go; gave bajan-15i metadata.files (Cargo.toml/Cargo.lock) + METER; re-anchored bajan-42y/vye post-6sw (BIZ-003/BIZ-005 still deliberately open) and added their METER/anti-goals/regression clauses; co-modification note on r1h (may run parallel with xa2, shared cli.rs/tests). All exported and pushed (main @ 2e108a9).
- Earlier in session: bajan-6sw landed (d32cd2b) — resubmission policy encoded in specs/ingestion-contract.md (ic_mutated_resubmit, ic_corrected_resubmit, ic_batch_duplicate, ic_empty_stream, ic_order_insensitive + 3 new transitions + 5 properties; spk lint + ah check green).
- Review findings parked without tickets (in bd remember): EDGE-001 empty query-pattern semantics unspecified, EDGE-002 concurrent ingest unimplemented vs ic_unique_id (single Connection, no WAL) — surface at qt_*/multi-process work.
- **Next:** claim bajan-3go (quick tidy, unblocks xa2/r1h/2sj/cdi), then bajan-xa2; board also has bajan-15i + spec tickets 42y/vye ready.
### 2026-09-29 19:56 — snap
- bajan-15i closed & pushed (main @ f020fc8): exact-pinned all six NLP/IR crates (unicode-normalization =0.1.25, unicode-segmentation =1.13.3, text-splitter =0.33.0, tiktoken-rs =0.12.1, simhash =0.3.0, aho-corasick =1.1.5), all live-verified (registry resolve, recency, docs.rs, maintainers — simhash weakest: single owner, but smoke test green)
- Tests added red→green: tests/deps_pinned.rs simhash smoke (near-dup < unrelated hamming ordering); vertical-slice dump generator extended with short (EDGE-002) + Spanish/German (EDGE-001) episodes; whole-episode-span gate property in src/extract.rs (byte-identical + whitespace-wobbled, non-ASCII survives collapse); CORR-001 recorded on run_extract doc (chunking = assembly for ONE call, ex_single_call)
- Determinism rationale re-grounded in the tv/ talks corpus: Chalef 206 (simhash/entropy over LLM passes, single-shot extraction), Blumenfeld 204 (idempotent deterministic load, reproducible derived views), Ainge 248 (normalize deterministically regardless of prompt), Gupta 314 ("models are stochastic, infrastructure must be deterministic")
- Gates all green at close: cargo test 52, clippy -D warnings 0, fmt clean, build --locked, spk lint 0, ah check --run-tests 15
- **Next:** board ready = bajan-vye + bajan-42y (P3 specs), bajan-3go (P3 tidy), bajan-cdi (gated, resolve seam) — claim per `bd ready`; recheck simhash crate health at next crate audit (single owner, 2 releases since 2018)
### 2026-09-29 20:25 — snap
- bajan-3go tidy landed first (unblocked the xa2/r1h/2sj trio): dead run() stubs deleted, cli.rs doc dup removed, stale version envelope refreshed, misnamed budget test renamed — board re-anchored and pushed
- bajan-xa2 closed & pushed (eff5c07, export 8594484): bajan-6sw resubmission decisions implemented red-first — persist() splits unchanged (already_persisted) vs mutated (reject reason=conflict, ic_mutated_resubmit), persist_stream() enforces intra-batch first-wins (later ids reject reason=duplicate, per-record, ic_batch_duplicate), corrected-resubmission recovery path + empty-stream no-op at CLI layer + shuffled-order graph-identity proptest (ic_order_insensitive); new RejectReason::Conflict/Duplicate (codes conflict/duplicate), SqliteStore::get_episode + shared episode_from_row mapper; vertical_slice.rs:118 reingest test updated red-first
- Gates at close: cargo test 55 (6 suites), clippy -D warnings 0, fmt clean, spk lint 0, ah check --run-tests 15; whisper branch snap appended
- **Next:** claim bajan-r1h (P2 extract gate honesty — record reason, decide caching, wire/defer ExtractionRunStore) or bajan-2sj (P2 sqlite read-path .expect panics → StoreError); both co-modification-safe with cli.rs/tests now tidy; specs 42y/vye + gated cdi also ready per bd ready

### 2026-09-30 12:09 — snap
- Evaluated integrating TypeSafe Jev into bajan's pipeline (grounded on docs.typesafe.ai introduction/sde_cascade): best point is the extraction seam as a *verifier*, never the extractor; ingest persist stays AI-free by contract. Rule-of-5 review of the evaluation caught the inverted capability model + cache/threshold/failure fixes.
- Created openspec change `add-optional-jev-verification` (proposal/design/delta/tasks, strict-valid; record-only calibration mode, split verifier cache, semantic-fields-only question set, infra-class failures). Committed as 6e55471.
- Implementation deferred: placeholder ticket bajan-4hv (P3) filed and committed as 734361c. Branch main is 2 commits ahead of origin — **not pushed**.
- **Next:** push origin main (pending authorization), then either pick up bajan-4hv (needs proposal approval first) or run `/renew`.

### 2026-09-30 15:29 — snap
- Session started with /next immediately — no new work this session; state moved on since last snap.
- Repo advanced since 12:09 snap: main now synced with origin (no longer 2 ahead); new commits landed: bajan-6j1 entity-review HITL queue (57b4186, deterministic ER proposals + human resolution), beads export closing bajan-7q8 + bajan-cdi (dd1a389).
- **Next:** run `bd ready` to see the post-cdi board and claim next item (bajan-4hv still pending proposal approval if TypeSafe Jev work resumes).

### 2026-09-30 18:13 — snap (quick stash)
- Real-doc smoke of ~/Downloads/fpa through the deterministic (no-LLM) path: EPUB clean end-to-end (Profit First → 50 episodes → 4815 atomic claims → query/adopt/ER); PDF path surfaced 3 real bugs, all filed with metadata.files + base_commit: bajan-98x (P1 pdf2bajan silent-empty on Type0 CID fonts — Mike Piper PDF exits 0 with empty stream), bajan-6jp (P2 \x01 control bytes survive collapse()), bajan-9pm (P2 ER pair walk O(n²) unusable at book scale). Also regenerated stale converters/Cargo.lock (build --locked was failing)
- issue-review (Rule of 5) over the 5-issue board: fixed mechanical debt (files-as-string metadata → JSON arrays, base_commit anchors, co-mod notes for shared converters/src/lib.rs); verdict READY_TO_WORK
- Review fixes applied: bajan-98x acceptance tightened (Err-exit-1 is THE bar, quantified ACCEPTANCE/ANTI-GOALS/METER); bajan-sbs created as HUMAN-ONLY approval gate and wired bajan-sbs --blocks bajan-4hv so the user-gated ticket no longer shows in bd ready
- All remediation pushed (main in sync); gates green throughout; 9pm still carries SCOPE-001 note: items 1-2 (O(n) normalize precompute + candidate pre-filter) are behavior-preserving, item 3 (budget counts candidate pairs) is a spec-semantics change needing a separate openspec revision ticket
- **Next:** claim bajan-6jp (control-byte strip in collapse(), land BEFORE 98x per co-mod note) → bajan-98x (whole-book-empty → Err) → bajan-9pm (ER perf items 1-2 only); bajan-4hv waits on user approving the openspec proposal via closing bajan-sbs; /renew picks up from turu recall
