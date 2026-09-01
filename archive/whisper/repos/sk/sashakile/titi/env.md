

## Migrated from sk:titi

# titi — env.md

## NuGet Publishing

Trusted publishing via OIDC — no API keys needed:
- Workflow: `.github/workflows/publish.yml`
- Step: `NuGet/login@v1` with `user: sashakile` (nuget.org profile name)
- Trigger: `v*` tag push
- Config: NuGet.org → Account → Trusted Publishers → GitHubActions → sashakile/titi, workflow: publish.yml

## Tests

- 434 unit tests (`Category!=Integration`), 6 integration tests (`Category=Integration`)
- `dotnet test --filter "Category!=Integration"` for CI/pre-push
- Pre-push validates: restore, `dont check`, unit tests only — **integration tests are NOT in pre-push**; nightly `integration.yml` (schedule + workflow_dispatch) covers them. First success ever: run 33109593013 (2026-08-27, after titi-9rf fix)

## CI Restore Strategy (fix for NU1004 drift)

`PublishAot=true` injects RID-specific AOT packages (ILCompiler etc.) whose
versions float with the SDK bundle — locked-mode restore drifts between
environments. Strategy (same in ci.yml, integration.yml, pre-push hook):
- `dotnet restore src/titi/titi.csproj --force-evaluate`
- `dotnet restore test/titi/titi.Tests.csproj --locked-mode`

Consequence: the committed `src/titi/packages.lock.json` is advisory only
(policy decision pending: beads `titi-rq1`).

## Cobertura Gotcha

coverlet emits class `filename` attributes relative to the **embedded
`<sources>` root** (common root of covered source files), NOT the repo root.
`Coverage.Parser.ParseCobertura` resolves against embedded `<source>` elements
first, caller root as fallback (fix in titi-9rf). A previously recorded edge
index with wrong paths persists until re-recorded — stale-cache failures look
order-dependent.

## Release Process

1. Update `Directory.Build.props` version
2. Update `CHANGELOG.md`
3. Commit, tag `v*`, push
4. CI builds, packs, and publishes via OIDC trusted publishing
