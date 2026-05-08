# Queue: miblioteca

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 12:47 — miblioteca

- Completed all `add-debug-event-log` implementation: `DebugLogger`, `DebugPanel`, `CaptureView` debug wiring, and all 5 instrumentation tickets (camera, sensor/permissions, GhostOverlayCanvas, share/download, capture shutter)
- Applied ro5 fixes: `stack` in `error:uncaught`, logger DI via `CaptureViewOptions`, DOM-append anchor pattern, 4 CaptureView debug-path tests — 472 tests green, pushed
- **Next:** `mibilioteca-toq` (integration tests — now fully unblocked) or manual acceptance tests `4n4`/`2tu` on real device

---

## 2026-05-08 12:22 — miblioteca

- Proposed, ro5-reviewed, and expanded `add-debug-event-log` OpenSpec — added orientation throttle, `share:api-check`, lifecycle + uncaught-error events, metadata export envelope
- Created 9 beads issues for the feature; issue-review found 2 missing dep edges (`5v7→3fg`, `0ml→tvi`) and patched all clarity/verification gaps
- Implemented `DebugLogger` (ring buffer, 1000 slots, URLSearchParams DI, metadata envelope), `DebugPanel` (floating export button, DOM anchor pattern), and `CaptureView` debug wiring (lifecycle/error listeners, `share:api-check`)
- Applied ro5 fixes: added `stack` to `error:uncaught`, logger DI via `CaptureViewOptions`, DOM-append anchor for Firefox compat, 4 new CaptureView debug-path tests — 52 tests green
- **Next:** Continue with instrumentation tickets — `mibilioteca-r7c` (camera init), `mibilioteca-5v8` (sensor probe/permissions), `mibilioteca-9kb` (GhostOverlayCanvas), `mibilioteca-vfu` (share/download handlers)

---

## 2026-05-08 10:44 — miblioteca

- Designed and created 9 Playwright E2E tickets under epic `mibilioteca-vwi` (Suites 1–8); issue-review pass surfaced 1 CRITICAL (Playwright not installed) and patched all gaps — setup ticket, spike, file paths, done criteria
- Implemented 35 Playwright tests across 7 suites; uncovered real bug: `GhostOverlayCanvas` was silently evicted from DOM by `render()`'s `replaceChildren` — fixed in `CaptureView.ts`
- Ran Rule of 5 review on full codebase; found 3 HIGH bugs: quality checks never persisted at shutter, tilt detection hardcoded to 0, upload FSM rejected HTTP 201/204 as terminal failure — all fixed
- Fixed MEDIUM issues: dt clamp for yaw spike prevention, RAF lifecycle when destroyed, O(n²) base64, mid-record abort in bundle assembly, aria attributes on overlay and export panel
- **Next:** tackle remaining open specs — `add-capture-metrics` (0/15) or `add-tracer-bullet` (0/11); run `bd ready` to pick up next ticket

---

## 2026-05-07 16:00 — miblioteca

- Ran full Android Chrome verification of the portable bundle MVP (ticket `u39`): capture, persistence, export, retry, bundle validation, file transfer — all passed
- Bundle inspection confirmed manifest integrity: `totalBytes` matched exact sum of `sizeBytes`, SHA256 spot-check matched manifest, records/images/thumbnails all present
- Found thumbnail bug: all thumbnails are byte-for-byte copies of source images (no resize/compression) — filed as `mibilioteca-jwd` (P3)
- Closed `u39`; committed and pushed verification checklist to `openspec/changes/add-portable-bundle-export/`
- **Next:** pick up next open P3 tickets (`39j` HITL backend decision, `o25` upload reliability, `646` iOS fallback) or triage `jwd` thumbnail bug

---

## 2026-05-07 16:33 — miblioteca

- Fixed thumbnail bug (`mibilioteca-jwd`): `captureFromLiveVideo` was aliasing the full-res imageBlob as the thumbnail; now calls `makeThumbnail(imageBlob)` for a proper 640px JPEG
- Fixed `takePhoto` thumbnail dimensions: was copying raw snapshot dimensions; now computes scaled width/height using the same `min(640/w, 640/h, 1)` formula as `shutter.ts`
- Added failing test first (TDD), then fixed code; all 377 tests pass; issue closed and pushed
- **Next:** pick up next ready issue — `mibilioteca-39j` (HITL: decide backend ingest shape), `mibilioteca-o25` (upload reliability), or `mibilioteca-646` (iOS fallback)

---

## 2026-05-07 17:32 — miblioteca

- Deferred backend-related tickets (`39j`, `o25`, `bzk`, `ni0`, `uyq`) to 2026-07-01; focus shifted to app completion
- Reviewed and reconciled specs: superseded `add-tracer-bullet` in favor of `add-portable-bundle-export` as the canonical vertical-slice definition; task 1.2 checked off
- Created UI completion tickets: `72k` (routing), `3fa` (sessions list), `pa3` (captures gallery), `csp` (export discoverability), `xoa` (recompression warning), `2tu` (acceptance test)
- Implemented and closed `mibilioteca-72k`: hash-based session routing (`#/session/:id`, `#/new`), generation counter for async safety, back button on `CaptureView` — 380 tests green
- Implemented and closed `mibilioteca-3fa`: sessions list home screen with capture count + export status badge, Space `preventDefault` fix, DB error handling, timezone-safe tests — 391 tests green
- **Next:** pick up `mibilioteca-pa3` (captures gallery / thumbnails view in session) or `mibilioteca-xoa` (image recompression warning in export UI)

---

## 2026-05-07 17:53 — miblioteca

- Implemented `mibilioteca-pa3`: captures gallery / thumbnails strip in `CaptureView` — loads on bootstrap, updates after each capture, revokes object URLs on destroy; 4 new tests, 395 total green
- Ran `rule-of-5-universal` review — found 4 issues: broken-image flash (C1), object URL leak on mid-load destroy (C2), concurrent-call URL accumulation (C3), serial IDB fetches (C4)
- Fixed all 4: `gallerySeq` monotonic counter stops stale calls, `destroyed` guard prevents post-destroy leaks, old URLs revoked only after `replaceChildren`, `Promise.all` parallelizes thumbnail fetches
- **Next:** pick up `mibilioteca-xoa` (image recompression warning in export UI), `mibilioteca-9is` (back button on new-scan screen), or `mibilioteca-csp` (export discoverability in capture UI)

---

## 2026-05-07 19:53 — miblioteca

- Scaffolded + Ro5-reviewed OpenSpec proposals for `add-ghost-overlay` and `add-capture-metrics`; applied all critical fixes (wrong paths, duplicate canvas field, missing boolean fields, artificial deps)
- Created 9 beads tickets from the proposals; ran issue-review, removed artificial `am1→401` dep, clarified 3 ticket descriptions
- Implemented all 8 code tickets: boolean quality fields + `stepCountSincePrev→displacementMeters` rename (401), Welford `laplacianVariance` (am1), `rotateVec` in `src/sensors/imuMath.ts` (ybm), shift clamping (qjd), null `grabFrame` guard (b9f), motion gating (bud), exposure threshold tuning (cr6), `estimateDisplacement` wired into shutter (8zk)
- Ran Ro5 on the new code; applied 3 fixes: RAF loop `destroyed` flag, NaN guard in `estimateDisplacement`, `qualityWarnings` DRY using boolean flags — 438 tests green
- **Next:** `mibilioteca-9is` (back button on new-scan screen) or `mibilioteca-csp` (export discoverability) — both P3 and unblocked; `mibilioteca-4n4` is the manual ghost overlay acceptance test on real device

---

## 2026-05-08 09:01 — miblioteca

- Implemented back button on `#/new` (ScanManagementView) and moved BundleExportPanel to root — then reverted panel to `this.controls` after `overflow: hidden` on `.camera-app` clipped it
- Fixed bundle filename redundancy: `TB-9170_TB-9170_2026-05-08` → `TB-9170_2026-05-08_00-09` (shortCode once + HH-MM from exportedAt)
- Sized `scan-back-btn` with CSS (was unstyled SVG expanding to fill screen)
- Fixed ghost overlay never activating: `App.ts` now wires real `Gyroscope`/`Accelerometer` via `detectSensorDeps`; Ro5u caught guard bug (`!== undefined` true for null) — fixed to truthy; 442 tests green, CI green
- **Next:** manual device acceptance tests `mibilioteca-4n4` (ghost overlay) and `mibilioteca-2tu` (bundle export end-to-end on Android Chrome); then `mibilioteca-646` (iOS InputFileCapture fallback) if device available

---
