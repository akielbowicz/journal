# Queue: atril

Sessions captured with /next — processed by /close or /wrap-up.

---

## 2026-05-08 20:50 — atril

- Fixed `atril-6v4`: replaced `navDepth` integer with `history.state`-backed `NavState {depth, view, previousView}`; contextual back labels (← Overview, ← Files, etc.); reload-safe; shared-link eject prevented via `previousView` guard
- Fixed pre-existing CI failure in `navigation-renderers.ts` (unsafe double-destructure `[[commonDir, groupItems]]` → index access with non-null assertion)
- Implemented `atril-94t`: overview redesigned as 2×2 category cards (Specs, Docs, Issues, History); inactive cards grayed; active cards navigate with correct back labels; Playwright-validated
- Closed `atril-6v4`, `atril-94t`; tickets `atril-r2n` and `atril-xgv` are now unblocked
- **Next:** `atril-r2n` (cross-screen breadcrumb) or `atril-xgv` (persistent category nav) — both consume `history.state` shape defined in `atril-6v4`

---
