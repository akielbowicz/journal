# Queue: miblioteca

Sessions captured with /next — processed by /close or /wrap-up.

---
## 2026-05-12 17:22 — miblioteca

- Reworked ghost overlay orientation tracking from stillness-suppressed deltas to an absolute-orientation filter with deadband, smoothing toward target, and dt-based rate limiting in `src/sensors/ghostOverlay.ts`.
- Updated `GhostMotionPipeline`, `ghostOverlayCanvas`, and `CaptureView` wiring so the capture path uses live `deviceorientation` `{alpha,beta,gamma}` samples while gyro remains for motion-gate/stillness only; renamed screen-orientation deps to `getScreenOrientation` where needed.
- Kept calibration behavior intact by adapting `GhostCalibrationPage` to the renamed screen-orientation API, and refreshed tests across sensor/canvas/capture/calibration paths; full suite passes.
- **Next:** test the new filter on-device and tune `YAW_DEADBAND_RAD`, `STILL_GAIN`, `MOVING_GAIN`, and `MAX_SHIFT_RATE_RAD_S` for the tripod/page-turn scenario.

---
