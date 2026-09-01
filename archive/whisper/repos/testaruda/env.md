# testaruda genesis adoption (v0.3.1+)

All 14 genesis v0.4.0 modules are adopted. 13 are in active use; `aix` is a
stub upstream (TODO: implement full AIX generation once design is finalized).

## Boundary rule

If testaruda needs functionality NOT in genesis and NOT duplicated in another
tool, keep it local. If it IS duplicated elsewhere, the pattern belongs in
genesis — file a genesis change first, then adopt.

## Usage per module

| Module | Usage |
|--------|-------|
| cli | generate_completions, maybe_print_version_json |
| config | ConfigFile, ConfigRegistry, ConfigStore |
| discovery | .genesis/tools.toml registration |
| doctor | DoctorCheck, DoctorReport, DoctorRunner |
| envelope | Envelope, EnvelopeKind, ErrorResult |
| feedback | handle_feedback, scratch records, gh issues |
| fixture | Fixture::new().with_file().build() in test suites |
| guide | Guide builder, CliVerbosity, CliFormat |
| managed_block | BlockInjector, BlockRegistry, BlockDef |
| scaffold | Scaffold builder for init |
| status | StatusBuilder for cross-tool health |
| suggestions | SuggestionEngine + CommandRegistry for typos |
| suite_linter | LintResult, Severity |
