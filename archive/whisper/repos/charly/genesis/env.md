# genesis-vibes (n) — env & conventions

## Version history
- v0.4.0 — CliVerbosity, CliFormat (TTY auto-detect), discovery module, Output::emit(), Guide::run_formatted()
- v0.5.0 — Full AIX generation module (aix.rs), 14 modules stable

## Key conventions

### Verbosity mapping (from_verbose_count)
- clap `-v` count 0 → `Verbosity::Normal` (default, not Quiet)
- clap `-v` count 1 → `Verbosity::Verbose`
- clap `-v` count 2+ → `Verbosity::Debug`
- `-q`/`--quiet` → `Verbosity::Quiet` (overrides -v)
- Use `CliVerbosity` struct (`#[command(flatten)]`) rather than raw `verbose: u8`

### Output format (CliFormat)
- `--json` → Json; `--human` → Human
- Neither set → auto-detect: `Human` if stdout is a TTY, `Json` otherwise
- Agents and pipes always get JSON by default
- Use `Output::emit(format, ...)` instead of `Output::print(...)` for format-aware output
- Use `Guide::run_formatted(format, f)` instead of `Guide::run(f)` when format matters

### Tool discovery
- `.genesis/tools.toml` manifest at project root
- Each tool registers during init: `genesis::discovery::register(project, name, desc, type, path)`
- Tools scan via: `genesis::discovery::scan(project)` → `Vec<DetectedTool>`
- Detector types: `"directory"` or `"file"`

### AIX generation (v0.5.0+)
- `genesis::aix::generate_llms_txt(meta, modules)` — standardized `llms.txt` from ProjectMeta + ModuleEntry
- `genesis::aix::generate_llm_txt(title, desc, &[LlmSection])` — composable `llm.txt` from typed sections
- Section helpers: `modules_section()`, `commands_section()`, `genesis_adoption_section()`, `authorship_section()`, `links_section(heading, &[(label, url)])`
- `quick_start_section` was REMOVED in v0.5.0 — use `links_section("Quick start", &[...])` instead
- `LlmSection` is `#[non_exhaustive]` — match with a wildcard arm
- Self-hosting: `just aix-gen` regenerates files; `just ai-check` in CI ensures no drift
- Files are pinned in `Cargo.toml`'s `[package] include` list

### Scratch tests
- Always use tempfile::TempDir or unique tool names (scoped by PID) in scratch tests
- Avoid shared `~/.cache/<tool>/errors.jsonl` paths between parallel tests