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