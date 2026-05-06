# Work Queue

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-06 19:38 — dont

- Completed `dont-dxu`: added `clap_complete` dep and `completions <shell>` subcommand so `dont completions bash/zsh/fish/...` emits shell completions that include `ground`
- Added stdin bulk-mode rejection to `Ground` handler — `dont ground -` now exits with `stdin-not-supported` error (code 2)
- Four new tests cover help listing, completions output, and stdin rejection; full suite green
- Committed and pushed `dont-dxu`; issue closed
- **Next:** `dont-1f4` (add hypothesis/atom commands), `dont-8bu` (drift-aware evidence projection), or `dont-cw6` (rollout sequencing review)

---

## 2026-05-06 19:23 — dont

- Implemented CURIE resolution in `show` command (`dont-jr8`): `store::term_by_curie` already existed; wired it into the show handler so `dont show WB:P001` resolves the CURIE to its term entity
- Unknown CURIEs now return `"no term with curie WB:ZZZZ"` (exit 1) instead of leaking `"no claim with id"`; help text updated to `"Show a claim or term."`
- Added 2 integration tests; full 188-test suite green; committed and pushed
- **Next:** `dont-dxu` (expose `ground` in help, completions, stdin rules, schema surfaces) or `dont-1f4` (no way to add hypotheses or atoms via CLI)

---

## 2026-05-06 18:45 — dont

- Implemented `--human` flag (issue `dont-0um`) as a global CLI option backed by an atomic `HUMAN_MODE` bool
- All commands emit plain text when `--human` is set: tabular list, detail blocks for show/prime, one-liner transitions, `(no claims)` empty states
- 8 new integration tests cover list, conclude, show, prime, init, transition, and `--json` override; full 180+ test suite stays green
- Closed `dont-0um`; committed and pushed
- **Next:** `dont-jr8` (CURIE/short-ID resolution in `show`) or `dont-psu`/`dont-sxh` (verb renames: `trust→doubt`, `dismiss→verify`) per `improve-cli-ergonomics` spec

---

## 2026-05-06 16:53 — miblioteca

- Implemented 5 P1/P2 tickets in one session: PWA manifest + install prompt + offline indicator (`9p4`), uploadState FSM with 5-attempt retry cap (`d1b`), camera init with getUserMedia + capabilities probe + error variants (`c9n`), shortCode + clockOffsetMs pure functions (`264`), plus ro5u fix tickets (`ouo`, `hyx`, `g8e`)
- Ro5u applied after each ticket; fixed AbortError on install prompt, empty tracks crash in camera init, NotReadableError/SecurityError variants; 106 tests passing
- Filed follow-up tickets: `mibilioteca-lxs` (PNG icons for Android install prompt), `mibilioteca-3ms` (re-entry hazard in upload FSM), `mibilioteca-cxk` (silent no-op in updateUploadState)
- **Next:** `mibilioteca-lxs` (P1 — add 192×512 PNG icons to `public/` for Android install prompt) or `mibilioteca-1o8` (P1 — TypeScript domain type definitions + Generic Sensor API `.d.ts`)

---

## 2026-05-06 16:32 — miblioteca

- Completed `add-tracer-bullet` OpenSpec slice: factory (`capture.ts`), IDB persistence, upload adapter, `TracerBulletShell` UI, session bootstrap — 41 tests passing
- Ro5u review caught and fixed: shared mutable `qualityChecks` reference, missing `by-uploadState` IDB index, MediaStream tracks never stopped, no denial-retry button, "Retry bootstrap" race, redundant `snapshot()` interface method, silent NaN persistence from unvalidated `serverTimeMs`
- All 5 tickets closed (`mibilioteca-lnf`, `mibilioteca-xre`, `mibilioteca-dj1`, `mibilioteca-zvo`, ro5u fixes), 6 commits pushed to origin
- **Next:** pick up `mibilioteca-9p4` (PWA manifest), `mibilioteca-d1b` (uploadState FSM), or `mibilioteca-c9n` (camera init) — run `bd ready` to confirm priority order

---

## 2026-05-05 15:31 — elegua

- Implemented `elegua/numeric/tolerance.py` (scalar tolerance types), `array.py` (array comparison with top-K diagnostics), `provenance.py`, and `verify_isolation` in `adapter.py`
- Rule of 5 review caught and fixed: ULP distance wrong for negatives (HIGH), NaN/Inf guard (MEDIUM), label mismatch silent failure (MEDIUM), plus 3 LOWs
- Implemented `elegua/numeric/layer.py` — `make_numeric_layer` LayerFn dispatching scalar/array/sample paths; registered in comparison pipeline as L3 via `NUMERIC_KEYS`
- **Next:** `elegua-jwox` (integrate top-K array disagreement reports with numeric layer) or `elegua-g5k7` (backwards compatibility tests) — both now unblocked

---

## 2026-05-05 15:51 — elegua

- Committed staged housekeeping (archived `refactor-composition-pipeline` change files)
- `elegua-06tm` (red): wrote failing tests for NPY array blob — added missing-blob contract test, checksum-corruption test, compressed round-trip, docstring fix, large-array threshold bump; closed after ro5u review
- `elegua-7ktz` (green): implemented `put_array`, `get_array`, `validate_manifest`, `ArrayManifest` in `elegua/blob_array.py`; 597 tests pass; ro5u found 2 fixes (broad except → specific exceptions, dtype string → np.dtype comparison); closed
- **Next:** `elegua-jwox` — integrate top-K array disagreement reports with numeric comparison layer (now unblocked by both 06tm and 7ktz)

---

## 2026-05-05 17:09 — elegua

- Implemented and committed `elegua-jwox`: numeric layer now surfaces array max/argmax/failing-count/top-K diagnostics through `ComparisonResult.diagnostics`, with diagnostics preserved when later layers mismatch.
- Added and committed red-phase coverage report CLI contract tests for `elegua-29d1` in `tests/cli/test_coverage_report.py`; confirmed RED because `python -m elegua coverage` is not implemented yet.
- Validation for implementation passed: ruff, pyright on `src`, full pytest (600 passed), and strict OpenSpec validation; pre-commit passed on both commits with existing Vale warnings only.
- **Next:** pick up `elegua-kaqt` — add failing tests for `--full-pipeline` diagnostic mode and concordance reporting.

---
## 2026-05-06 11:01 — mibilioteca

- Scaffolded repo with wai, beads (bd), and openspec based on `bookshelf-pwa-requirements.md`
- Ran Rule of 5 review on the scaffold; identified 1 critical, 5 high, 6 medium, 6 low issues
- Fixed all issues: projections→slash commands, baseline OpenSpec specs (data-model + api-contracts), session close protocol, research artifacts (4 entries), CLAUDE.md structure, justfile, `.editorconfig`, `_typos.toml`
- wai way score improved from 10/21 to 14/21
- **Next:** advance to design phase (`wai phase set design`), add design artifacts for capture pipeline and data model, begin Vite + TypeScript project init

---

## 2026-05-06 13:00 — miblioteca

- Rule of 5 review on specs (data-model, api-contracts, project.md): found 1 critical + 9 high issues; fixed all 23 in one pass (IMU field count 13→14, shortCode format, blobRef identity contract, uploadState FSM, idempotency header, error codes, storage budget, quality thresholds, DB version history)
- Created all 33 implementation tickets across 7 layers (infra, IDB, camera, sensors, image processing, scan/session/upload, UI) with full dependency chain
- Fixed git remote URL typo: `mibilioteca` → `miblioteca` (pointing to correct GitHub repo)
- Issue-review (5-pass Ro5): found priority inversion, artificial dep, missing deps, iOS null-sensor gap — all 11 fixes applied
- **Next:** start implementation from `mibilioteca-ocf` (Vite scaffold, the only unblocked ticket); `bd ready` shows correct state

---

## 2026-05-06 15:28 — miblioteca

- Drafted and tightened the OpenSpec tracer-bullet proposal in `openspec/changes/add-tracer-bullet/`, including proposal, design, tasks, and spec delta.
- Created a vertical tracer-bullet beads lane (`mibilioteca-jac` through `mibilioteca-19z`) and wired dependencies across the new slice sequence.
- Reframed overlapping horizontal backlog items: added tracer-bullet dependency edges to scaffold/test/IDB/camera/upload tickets and marked `mibilioteca-2sz` and `mibilioteca-g5y` as post-tracer-bullet expansion work.
- **Next:** claim `mibilioteca-jac` and start implementing the tracer-bullet scaffold HTTPS shell and test harness.

---


## 2026-05-06 16:17 — clojure-tutor

- Initialized `wai`, `bd`, and `openspec` for the squint structural editing tutor repo, following `squint-structural-editing-tutor-spec.md`
- Added repo hygiene files: `.gitignore`, `.editorconfig`, `_typos.toml`, `justfile`, `llm.txt`, `package.json` stub
- Created domain ubiquitous language in `.wai/resources/ubiquitous-language/` (3 contexts: structural editing, curriculum/pedagogy, architecture)
- Scaffolded Phase-0 openspec change proposal (CM6 action observation spike — the spec's gate to all subsequent build work); fixed 16 review findings from `rule-of-5-universal`
- Created 6 `bd` issues for Phase-0 tasks with dependency graph; `bd ready` now shows `CLT-acs` (setup) as the first actionable item
- **Next:** claim `CLT-acs`, install Node/squint deps, then run the CM6 action observation spike (`CLT-scl` default keymap, `CLT-7kd` vim, `CLT-1jd` emacs)

---


## 2026-05-06 16:41 — clojure-tutor

- Implemented `CLT-acs`: Vite + squint + CM6 + clojure-mode + vim + emacs keymaps; wrote `src/editor/command-wrapper.js` (`wrapCommand` / `makeActionLog`) and `spike/` entry (3 live editors); RO5 found and fixed wrong key labels, wrong Vite dev script, missing `Prec.highest` on emacs editor, removed dead `@vitejs/plugin-react`
- Implemented `CLT-scl`: added vitest + happy-dom; wrote `test/default-keymap.test.js` (4 tests confirm wrapper captures slurp on default keymap); RO5 found broken "decline" assertion — fixed with a `neverFires` stub command; all 4 green
- Both issues closed; `CLT-7kd` (vim) and `CLT-1jd` (emacs) are now unblocked
- **Next:** `CLT-7kd` — spike CM6 action observation on vim emulation (normal-mode `>` interception investigation)

---
## 2026-05-06 17:07 — miblioteca

- Wired up real camera capture in `TracerBulletShell.tsx`: `<video>` element fed by `initCamera()` stream, `captureFromLiveVideo()` replaces gray-box stub with `canvas.drawImage(video)`
- Redesigned layout as a full-screen phone camera UI: viewfinder fills `100dvh`, white shutter button at bottom with safe-area inset support
- Made tracer bullet the app root (removed landing page), set Vite `base: '/miblioteca/'` for GitHub Pages
- Created `.github/workflows/deploy.yml` deploying to `https://charly-vibes.github.io/miblioteca/` on every push to `main`
- **Next:** verify the GH Pages deploy succeeded and the camera works on a real phone; consider adding thumbnail preview after capture

---
## 2026-05-06 17:35 — miblioteca

- Closed 9 issues in one sprint: `1o8` (Generic Sensor API .d.ts + PreviewFrame type), `07u` (idb v8 typed schema with v1→v2 migration), `lxs` (PNG 192+512 icons for Android), `3th`/`n9i` (record/blob/scan/session CRUD), `3ms` (uploadCapture re-entry guard), `8s9` (laplacianVariance + makeThumbnail), `j4s` (traces/previewFrames/previewBlobs CRUD), `idt` (probeSensors + detectSensorDeps)
- Test suite grew from 106 → 144 passing tests across 16 files; all changes pushed to `main`
- `07u` unblocked `3th`/`n9i`/`j4s`; `idt` now unblocks `mj8` (steadiness gate)
- **Next:** `270` (session lifecycle), `iz3`/`ypi` (scan API), `z6p` (Background Sync SW), or `mj8` (steadiness gate using `probeSensors`)

---
## 2026-05-06 18:08 — miblioteca

- Implemented `startSession`/`endSession`/`recoverCrashedSessions` in `src/tracer/session.ts` with real-IDB integration tests (10 tests); closed mibilioteca-270
- Implemented `feedAccel` steadiness gate in `src/sensors/steadiness.ts` — ZUPT-safe variance check with null-axis guard and out-of-order timestamp protection; closed mj8
- Workflow rule saved: implement → ro5u → fix → commit → next ticket
- **Next:** claim and implement `0bg` (ImageCapture ladder — resolution cascade for reliable camera init)

---
## 2026-05-06 18:24 — miblioteca

- Implemented `captureImage` ImageCapture → canvas degradation ladder in `src/camera/captureImage.ts`; closed `mibilioteca-0bg`; 177 tests green
- Ro5u review found: inaccurate catch comment, missing height-axis test, untested `createImageBitmap` failure path, inactive-track guard gap, shared mock state
- Applied all 5 Ro5u fixes + added 4 new tests (`onDegradation` hook, height-axis threshold, `createImageBitmap` throws, zero-dimension guard); 181 tests green
- **Next:** P1 scan creation — `ypi` (POST /api/scan + shortCode + QR invite) or `iz3` (POST /api/scan/join + token handling)

---
## 2026-05-06 19:10 — miblioteca

- Implemented `createScan` (POST /api/scan + IDB persistence + QR invite); closed `ypi`; 191 tests green
- Implemented `joinScan` (POST /api/scan/join + IDB persistence + token handling); closed `iz3`; 197 tests green
- Removed React entirely — rewrote `TracerBulletShell`, `AppHeader`, hooks, and `QrInvite` as plain TypeScript DOM classes/factories; closed the React-removal ticket; 199 tests green
- **Next:** `z6p` (Background Sync Service Worker with Workbox) — only remaining P1 gap before end-to-end uploads survive tab close

---
## 2026-05-06 19:14 — clojure-tutor

- Ran Rule-of-5 review on Phase 1 proposal docs (proposal.md, tasks.md, design.md, findings.md); fixed all 18 issues — test count, task ordering, shim design, keyword/string language, init ordering, untestable Phase 1 test
- Implemented full Phase 1 editor shell scaffold: index.html, main.js, storage, action-log, command-wrapper, eval pipeline, shell, cell, three profiles (default/vim/emacs); 28/28 tests green; CLT-37m closed
- Archived Phase 0 spike change; fixed `just dev` to serve from project root instead of spike/ directory
- **Next:** open CLT-29m (P3 — prototype structure-diff fallback, conditional) or start Phase 2 planning

---
## 2026-05-06 20:00 — miblioteca

- Implemented Background Sync SW (`src/sw.ts`) via `injectManifest`; drains IDB pending/failed records, error-isolates per upload, notifies window clients; 202 tests green; closed `z6p`
- Implemented quality checks (`src/tracer/qualityChecks.ts`): `runQualityChecks` + `qualityWarnings` with exported `THRESHOLDS`; Ro5u fixed `else if` → `if` in exposure fractions + added checkerboard laplacian test; 218 tests green; closed `6yj`
- Fixed `just dev` — installed mkcert via Homebrew, generated self-signed certs; HTTPS dev server now starts
- Closed stale `ypi` (scan creation was already done) and `l20` (OpenSpec review superseded); unblocked `9fo`, `ot8`, `2sz`, `g5y`
- **Next:** `2sz` (Shutter flow, P1) or `9fo` (Scan management UI, P2) — both newly unblocked by closing `6yj`

---
## 2026-05-06 20:08 — clojure-tutor

- Designed Phase 2 (profile system): no-header layout, collapsible left panel (Claude Code-style), profile-aware which-key leader (`g` in Calva/Emacs, `Space` in Vim), reactive keybinding substitution via `active-profile` atom, fixture slide to prove substitution without lesson runner
- Scaffolded `implement-profile-system` OpenSpec proposal; ran Rule-of-5 review (NEEDS_REVISION) — 8 HIGH fixes: reinitProfile type contract, panel focus management, fixture cell registration, cyclic-extends guard, Space-leader fallback, vocabulary drift, resolveBindings unknown-ID
- Applied all 18 spec fixes across profile-system, which-key-nav, keybinding-substitution specs + tasks.md + design.md
- Created 25 beads issues (CLT-026 through CLT-na9); ran issue-review (9 fixes): wired CLT-2fn into critical path, added keyboard-nav tests to CLT-90p, HITL flags on CLT-dlh and CLT-na9, refinitProfile rollback test in CLT-zqj, mounting pattern in CLT-1wr
- **Next:** CLT-dlh (HITL — research Calva keybindings from Calva extension source) must go first; then CLT-9pd + CLT-026 can run in parallel

---
