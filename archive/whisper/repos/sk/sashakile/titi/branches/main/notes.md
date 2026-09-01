### 2026-07-28 13:14 — snap
- Finished tracer bullet epic (6 tickets): `titi open/affected/clean` end-to-end, 17 tests, justfile/CI
- Finished add-test-item-detection epic (TID-1→8): test-item domain types, VSTest discovery, Cobertura parser, safety invariants, CLI commands, config, synthetic fixture, docs
- ClojureCLR deferred to C# (Decision 10 documented in architecture)
- 55 fast tests in ~3s, 58 total; README updated with CLI reference and safety model
- **Next:** adapter epic (titi-dik) blocked on external testaruda-side config (titi-co9) — needs work in testaruda repo

### 2026-07-28 16:38 — snap
- **9 tickets shipped, all on `origin/main`**: or6 (verify --list-tests console-text), 5an (TRX parser), uuz (edge builder + tests record), o87 (fixture coverlet), ulg (fixture library source + exercising tests), wnj (ingest edge correlation via EdgeBuilder), iga (history.edn persistence), mpj (wire selection into `titi affected` + fix edge-match substring bug), cleanup (reconcile stale checkboxes + 4 new beads tickets)
- **Key decisions:** .NET 10 `dotnet test --list-tests` is console text only (no JSON mode — TD-01 corrected). Edge matching now uses segment-aware path-suffix (not `.Contains()` which false-positived). File-level Cobertura granularity adopted for TD-03 (method-level unreliable on .NET 10 per coverlet#1654).
- **Test suite:** 55→113 passing. OpenSpec: ~31 of ~46 tasks done in `add-test-item-detection`.
- **Open beads (6):** titi-co9 (P0, testaruda), titi-dik (P2 epic, testaruda), titi-nxo (P2, test-manifest --select/--list), titi-tdq (P3, items cache), titi-8sg (P3, incremental edges), titi-yhm (P3, docs)
- **Next:** `titi-nxo` (TID-9) — implement `titi test-manifest --select/--list` with framework-aware filter syntax + batch splitting. Highest-value remaining piece. No testaruda dependency.

### 2026-07-28 17:08 — snap
- **titi-tdq (task 2.6)**: Added DiscoveryCache (src/titi/DiscoveryCache.cs) — content-fingerprint cache for dotnet test --list-tests results in .titi/test-cache/items/. Wired into AffectedCommand and TestsListCommand. 15 tests. ✓ Closed titi-tdq.
- **titi-8sg (task 3.6)**: Per-project fingerprint diff in TestsRecordCommand. Only re-run changed projects; preserve edges for unchanged ones from edges/projects/*.edn per-project cache. RecordPlanner helpers: ComputeChangedProjects, Load/SaveProjectFingerprints, PruneStaleFingerprints. 13 new tests. 141 total passing. ✓ Closed titi-8sg.
- **Test suite:** 129→141 passing. OpenSpec add-test-item-detection: 41/50 tasks complete.
- **Open beads (4):** titi-nxo (P2, test-manifest --select/--list), titi-yhm (P3, docs), titi-dik (P2 epic, blocked on testaruda), titi-co9 (P0, testaruda).
- **Next:** `titi-nxo` — implement test-manifest --select/--list (5.4/5.5/7.4/7.5/7.6).
### 2026-07-28 17:46 — snap
- Completed add-testaruda-adapter Phase 1: all 6 adapter handlers + lifecycle + CLI dispatch. 28 tests, 191 total passing.
- Archived both openspec changes (add-test-item-detection, add-testaruda-adapter) to `openspec/changes/archive/`.
- Ran issue-review on the 4 new Phase 2 tickets. Fixed metadata.files, added verification criteria to titi-267, added benchmark methodology to titi-8sm.
- **Next:** `titi-267` — upgrade adapter discover/static-deps/run-args/ingest to method-level granularity. First step: update handshake to return symbol_model_complete=true, then wire TestItem discovery into the discover handler.

### 2026-07-28 19:27 — snap
- Upgraded testaruda adapter to method-level granularity (Phase 2): handshake, discover, static-deps, run-args, ingest all rewritten. 191 tests pass. Closed titi-267, titi-uz9, titi-sqx epic.
- Benchmarked CLR cold-start: Non-AOT mean 711ms. AOT blocked by System.Text.Json reflection. Updated README, added `scripts/benchmark-adapter-coldstart.sh`, added `just benchmark-adapter-coldstart`. Closed titi-8sm.
- Created Phase 3 tickets: epic titi-isg + 6 REPL command tasks (scaffold, deps/dependents, path, info, affected, tree) + titi-7ns AOT source-gen ticket.
- Ran issue-review skill: fixed metadata.files, added dependency ordering (scaffold blocks all commands), added verification criteria to all tickets.
- **Next:** Work the first ready ticket: titi-g98 (REPL scaffold) — implement the interactive REPL shell, arg parsing, help/quit/exit, unknown command handling, GraphNotAvailable error.

### 2026-07-28 20:38 — snap
- Completed Phase 3 (Interactive REPL) — all 6 command tickets + epic closed. Implemented `src/titi/Repl.cs` with 8 commands (deps, dependents, path, info, affected, tree, help, quit/exit) with per-project args, --depth, --from flags, git diff plumbing, cycle guards, and 26 tests.
- Test suite: 219 total passing (up from 191). 5 commits, all pushed to `origin/main`.
- Rule of 5 review applied: fixed PrintPath indentation, capped tree depth at 50, fixed --from value skip.
- **Next:** `titi-7ns` (P3) — AOT source-generated JsonSerializerContext across all 6 serialization files. The only remaining open ticket.

### 2026-07-29 09:54 — snap
- **titi-7ns complete** (AOT source-gen): TitiJsonContext covers TestItem[], Dictionary<string,string>, List<JsonEdge>, OpenCommandOutput, EdgeEntry[], AffectedSetOutput, TestItemList. Adapter.cs intentionally NOT migrated (reflection-based, subprocess not AOT-compiled). csproj: `PublishAot=true` + `NoWarn IL2026;IL3050;IL2104` (warnings only meaningful at publish, pollute stdout when `dotnet run` rebuilds inside IntegrationTests).
- **AOT publish env workaround**: this host lacks `brotli-devel`; `dotnet publish -p:PublishAot=true` fails at native link (`cannot find -lbrotlienc`). Fix: `ln -sf /usr/lib64/libbrotlienc.so.1 /tmp/lib/libbrotlienc.so` (×3) then `LIBRARY_PATH=/tmp/lib` (NOT LD_LIBRARY_PATH — that's for runtime, not link time). CI on ubuntu-latest has brotli-dev preinstalled, so no workaround needed there.
- **DocFX 2.78.5 limitation**: cannot generate API reference from .NET 10 source (`Cannot find .NET Core SDK to compile the project` during metadata step). Removed `metadata` section from docfx.json — conceptual docs only for now. Revisit when DocFX adds .NET 10 support.
- **docs site**: `just docs` copies `openspec/specs/*` → `docs/specs/` (gitignored, regenerated) + `docs/specs-toc.yml` → `docs/specs/toc.yml`. GHA workflow uses artifact-based Pages (`upload-pages-artifact` + `deploy-pages`), no gh-pages branch. Needs Pages enabled in repo Settings → Pages → Source: GitHub Actions.
- **Rule of 5 on docs caught**: fabricated `titi cache warm` command + `.titi/graph.cache` file (do NOT exist in codebase — `rg` returns nothing; adapter rebuilds graph in-memory at handshake). Phantom `Cli.cs` in source tree (actual dispatch is in Core.cs).
- **titi backlog empty**: 0 open beads, all openspec changes archived. Next big work: cascading version bumps (still Planned).

### 2026-07-29 14:07 — snap
- Started global-review epic (titi-k2x): closed 3/21 P1 tickets in this session
- `.2` (stable edge file key): fixed write/read/cleanup key mismatch. Centralized in RecordPlanner. [Core.cs, RecordPlanner.cs, IncrementalRecordTests.cs]
- `.1` (edge orientation): fixed AffectedAnalyzer traversal (dep.From→dep.To). Updated test edge directions. [Affected.cs, AffectedTests.cs]
- `.3` (process timeouts): extracted RunProcess with async stream draining, timeout enforcement, process-tree kill. Both RunDotnet methods delegate to it. [Core.cs, ProcessExecutionTests.cs, titi.csproj]
- **Next:** `.5` (cold adapter caching), then `.9` (fallback threshold), `.16` (recording state), `.17` (shutdown). 226 tests pass.

### 2026-07-29 15:18 — snap
- **titi-k2x.5** (cold adapter caching): `GetOrDiscover` no longer stores empty results on cold cache miss. [DiscoveryCache.cs, DiscoveryCacheColdStartTests.cs]
- **titi-k2x.17** (shutdown): `RunLoop` terminates after processing shutdown response instead of continuing to read stdin. [Core.cs, AdapterTests.cs]
- **titi-k2x.9** (fallback threshold): Parse 0-1 threshold from config, suppress test-ID/Traversal below threshold, emit affected-projects diagnostic. Fixed `:test-detection-enabled true` not setting `Enabled=true`. [Config.cs, ConfigTests.cs]
- **titi-k2x.16** (recording state on failure): fingerprint advancement only for successfully recorded projects; failed projects retain priorFingerprints entries. 3 new tests. [Core.cs, IncrementalRecordFailureTests.cs]
- **Test suite:** 257 passing, 6 pre-existing skips. All 4 P1 tickets closed. Git `main` pushed.
- **Next:** P2 queue — up to 12 tickets (titi-k2x.4, .6, .7, .8, .10, .12, .13, .14, .15, .18, .19, .21).

### 2026-07-29 16:25 — snap
- **titi-k2x.4 closed** (bounded collision-resistant cache keys): `DiscoveryCache.CacheKey` = SHA-256 hex of UTF-8 package id, used in both Load and Store. Fixes `..` escape, `a/b` vs `a_b` collision, unbounded long-id paths. Legacy sanitized entries deliberately invalidated (no migration). 4 new key tests + aligned cold-start/TestItemCache path assertions.
- **Note:** the src CacheKey fix + key-tests file were swept into commit `d713aa5` (an unrelated "file titi-qaj" triage commit made in parallel mid-session) which did NOT update the dependent cold-start/TestItemCache tests, leaving the suite red. My commit `6b667f4` realigned those test path assertions to `CacheKey` and added a determinism test, restoring green (261 pass, 6 skips). Pushed to origin/main.
- **Next:** P2 queue — `titi-k2x.21` (archive add-docs-site openspec, fast housekeeping) or `titi-k2x.7` (distinguish empty git diff from diff failure) / `titi-k2x.8` (canonicalize coverage & changed-file identities).

### 2026-07-29 16:42 — snap
- **titi-k2x.7 closed** (distinguish empty git diff from git failure): `GetChangedFiles` now returns `[]` (not `null`) on a successful zero-file diff; `null` reserved for real git failure (non-zero exit / exception). Empty/fallback distinction preserved through `BuildAffectedSet` (empty=>none, null=>all). Trimmed dead `is null` branch in affected-command success-path message (Core.cs:161).
- **Tests:** 4 new git-subprocess tests in `GetChangedFilesTests.cs` (temp git repo: HEAD..HEAD empty diff, bad ref failure, both via BuildAffectedSet). 265 pass (up from 261), 6 skips. Commit `f91c950`, pushed to origin/main.
- **Next:** P2 queue — `titi-k2x.8` (canonicalize coverage & changed-file identities before selection) or `titi-k2x.6` (honor affected-project scope in adapter static-deps) — both code bugs.

### 2026-07-29 19:30 — snap
- **titi-k2x.8 closed** (canonicalize coverage & changed-file identities): `Coverage.ResolveUnderRoot` collapses '.'/'..' and rejects paths escaping/outside sourceRoot (no edge). `Selection.IsPathMatch` compares canonical segment-joined tail-suffixes on the FULL relative path (not basename), so a/Foo.cs vs b/Foo.cs no longer cross-match while /repo/src/a/Foo.cs still matches repo-relative a/Foo.cs. Renamed `NormalizePathSuffix`→`CanonicalRelativePath`. Owned normalization at ingestion/selection boundary.
- **Tests:** 5 new (3 CoverageCanonicalizationTests + 2 SafetyTests). 270 pass (up from 265), 6 skips, no build warnings. Commit `c550153`, pushed to origin/main. CI green (run 30484571076).
- **Also filed titi-ayp** (P2 bug, discovered-from titi-k2x): TitiOpen integration test fragile to source-introduced build warnings (the CS8602→stdout-pollution root cause of the f91c950 CI red). Commit `45bc309`.
- **Next:** P2 code bugs — titi-k2x.6 (honor affected-project scope in adapter static-deps), titi-k2x.18 (ignore uncovered Cobertura lines when building edges), titi-qaj (P3, discover response format).

### 2026-07-29 19:45 — snap
- **titi-k2x.18 closed** (ignore uncovered Cobertura lines): `ParseCobertura` now inspects the `hits` attribute and only retains lines with a positive numeric hit count. Methods or file-level classes with zero covered lines produce no edge (avoids false-positive test selections). Extracted shared `ParseCoveredLines` helper for both class-level and method-level paths (REFACTOR).
- **Tests:** 3 new in `CoverageHitFilterTests.cs` (all-zero-hits → no edge, mixed hits → retain only positive, file-level all-zero → no edge). 273 pass (up from 270), 6 skips, no build warnings.
- **Commit:** `a62d359`, pushed to origin/main. CI green (run 30485640512).
- **Session recap:** Closed 4 P2 tickets today: .4 (cache keys), .7 (empty diff), .8 (canonicalize paths), .18 (hit filter). Filed 1 bug: titi-ayp (TitiOpen test fragility). Still open: titi-k2x.6, .10, .11, .12, .13, .14, .15, .19, .21 + epic (total 10).
- **Context:** ~75-80% — recommend wrapping up this session soon.

### 2026-07-29 16:46 — snap
- Closed 4 P2 tickets under titi-k2x epic: .4 (SHA-256 cache keys instead of sanitized dir name), .7 (empty git diff → [] not null, avoids fallback-all), .8 (canonicalize coverage & changed-file paths — reject out-of-root, full relative-path matching), .18 (ignore hits=0 Cobertura lines — methods with zero covered lines produce no edge). All pushed to origin/main, CI green.
- Filed titi-ayp (P2): TitiOpen integration test fragile to source-introduced build warnings (dotnet run prints warnings to stdout, breaks JSON parsing).
- **Next:** titi-k2x.6 (honor affected-project scope in adapter static-deps) or .21 (archive add-docs-site openspec) — 9 remaining P2 tickets in the epic.
- **Context:** ~80% — close via /close next session.

### 2026-07-29 18:15 — snap
- Completed configurable discovery root (titi-9tg): SourceRoot supports string[] array, DiscoverProjects iterates all roots, validation for relative paths and non-existent directories
- Migrated config & cache files from EDN to JSON (titi-8c4): replaced custom regex parser with System.Text.Json, renamed .edn → .json throughout
- Updated Config.cs, Interop.cs, Core.cs, Domain.cs, all tests, fixtures, docs, and openspec specs
- Committed & pushed to main (7f24a79)
- **Next:** Continue with titi-k2x.11 (narrow config spec — needs spec trimming and OpenSpec validation), or pick next ready ticket

### 2026-07-29 19:11 — snap
- **Closed entire titi-k2x epic** (all 8 children): narrowed config spec (k2x.11), added test-sdk package-ref detection (4p5), adapter cold-cache warmup (ua5), NuGet pack validation (k2x.19), locked restore + CI (k2x.13), DocFX PR build (k2x.15), AOT publish smoke test (k2x.14), e2e integration CI (k2x.12), CLI spec alignment (k2x.10), adapter static-deps scope fix (k2x.6), removed cache-warm docs (k2x.20), archived add-docs-site (k2x.21), plus earlier fixes: test fragility with build warnings (ayp), RID lock file fix, pre-push hook.
- **Key decisions:** RuntimeIdentifiers belongs in csproj (not Directory.Build.props) for lock file generation. Pre-push hook runs locked-mode restore + fast tests. Docs nav deduplicated (href to specs/toc.yml instead of manual list).
- **CI fix:** Lock file lacked linux-x64 RID — moved RuntimeIdentifiers to titi.csproj, regenerated, committed. Pre-push hook prevents recurrence.
- **Next:** No remaining open tickets in titi. Next project or the docs navigation deploy.

### 2026-07-30 13:03 — snap
- Fixed top bar on deployed docs site (saxa.xyz/titi/): content was overlapping the fixed header, and the TOC tree was expanding in the top navbar
- Created docs/styles/main.css with body padding (100px), nested nav tree hidden in top bar, expand-stubs removed
- Added CI step to copy custom styles into _site/styles/ after build
- Two commits: 4675d97 (initial fix), d423fdb (padding + nav tree fix)
- **Next:** Deploy confirmed working — no tickets remaining in titi.

### 2026-07-30 15:16 — snap
- Implemented `StaticEdgeAnalyzer` with three levels: L1 (project refs), L2 (using statements), L3 (method call graph) — pure static test→source edge analysis without running coverage
- L3 parses `TypeName.MethodName()` and `new TypeName()` calls from test files, resolves against method/class maps built from source declarations (regex-based)
- Wired fallback into adapter `HandleStaticDeps` and CLI `AffectedCommand`/`test-manifest --select`
- Fixed CI: main `ci.yml` now excludes integration tests (`Category!=Integration`) — they run separately via `integration.yml`
- 345 tests passing, all commits pushed to `main`
- **Next:** stress-test against 10 .NET repos to validate >0 static edges for at least 7/10 repos

### 2026-07-30 17:06 — snap
- Verified and closed titi-obz (L3 method-level call graph). Updated ACs to reflect by-design instance-method-on-variable fallthrough to L2.
- Created stress-test script (scripts/stress-test-static-edges.py) — validates static edge analysis against 10 .NET repos. Result: 8/10 pass (threshold: 7/10).
- Assessed titi as TIA tool: working correctly, 345 tests, safety model, cold-start via static edges, no open bugs. All core value delivered.
- Assessed titi as monorepo management tool: swap engine has hard-coded path convention bug (Swap.cs:31). Created 3 tickets for gaps.
- Ran issue-review skill on all open tickets. Created 8 VN subtask tickets, wired dependency chains, added metadata.files to all 11 tickets, fixed approach ambiguity in titi-u07.
- **Next:** Work titi-4nz (P1) — fix swap engine path lookup to use graph.Nodes instead of hard-coded {sourceRoot}/{packageId}/{packageId}.csproj.

### 2026-07-30 18:15 — snap
- Closed 5 tickets this session: titi-4nz (P1, graph path lookup), titi-u07 (P1, Swap.targets), titi-1o1 (VN-01 NBGV detect), titi-5el (VN-03 CPM detect + validate), titi-03h (VN-06 AssemblyVersion check + --fix)
- 365 tests passing (up from 345), all pushed to main
- **Next:** Continue VN tickets — VN-02 (NuGet version resolution), VN-04 (lock file), VN-05 (NuGet 6.12 regression), VN-07 (cascading bump), or VN-08 (baseline assembly)

### 2026-07-31 11:07 — snap
- Completed VN epic: 6 tickets shipped (VN-02, VN-04, VN-05, VN-07, VN-08) + cascading version bumps epic
- Added NuGetVersionResolver, BaselineAcquirer, ChangesetReader, CascadingBumpEngine, lock file management, NuGet 6.12 CPM regression workaround
- Test suite: 365 → 420 passing (+55)
- Applied Ro5 review: fixed 12 issues (CRITICAL feed URL, HIGH assembly extraction, CLI wiring, etc.)
- Fixed CI: PackValidationTests now uses installed tool binary; AOT publish smoke test drops MSBuild-dependent adapter handshake
- No remaining open tickets — all VN work complete
- **Next:** No ready work — pick up new project or close session


## Migrated from sk:titi (branches/main)

# titi — main branch notes

## Session 2026-08-05 — Bug fixes, PackageReference graph, v0.3.0/v0.3.1 release

### Tickets Closed
- **titi-mo7** (P1 bug): Subprocess safety — routed restore and test-discovery through `RunProcess` (concurrent async drain, bounded timeout, process-tree termination). Two inline `Process` handlers that could deadlock or orphan dotnet children.
- **titi-e59** (P1 bug): Confidence model — replaced `project-count/file-count` with weighted `ComputeConfidence(resolution × 0.6 + freshness × 0.25 + depth × 0.15)`. Added `ResolvedFiles` to `AffectedSet`.
- **titi-ark** (P1 decision): PackageReference identity policy — `PackageId` property matching (already established by Swap.cs). Version: semver-compatible. Cycles: suppress. Unresolved: skip.
- **titi-2uk** (P1 bug): PackageReference graph edges — `GraphBuilder.Build` now resolves `PackageRefs` to Binary-mode edges. Added `IsVersionCompatible` helper.

### Key Decisions
- Matching internal PackageReferences by `PackageId` property (case-insensitive, `Swap.cs:27` pattern)
- Version compatibility: semver-compatible by default, major-mismatch suppresses edge
- Cycle-creating PackageReference edges: suppressed with warning
- External (unresolved) PackageReferences: silently ignored

### Release
- v0.3.0: PackageReference graph, version management, subprocess safety, confidence model
- v0.3.1: README embedded in NuGet package with AI notice
- Both published via OIDC trusted publishing (NuGet/login@v1)

### Chores
- Removed unused ClojureCLR dependency (dead weight since initial skeleton)
- Added `dont check` to pre-push hook
- Refreshed wai managed blocks
