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
