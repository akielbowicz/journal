# Genesis (charly-vibes/genesis)

Shared substrate for the charly-vibes suite: feedback bus, update_check, git interface, workspace knowledge.

**Epic — genesis-tpf: shared git interface module** ([epic], P2, open)
- [x] genesis-tpf.1 — add read-only genesis::git module, adopt wai (CLOSED, v0.13.0 at bcd7fa8)
- [ ] genesis-tpf.2 — migrate testaruda change.rs (work in charly/testaruda)
- [ ] genesis-tpf.3 — migrate espectacular changed_files_from_git (work in charly/espectacular)
- [ ] genesis-tpf.4 — migrate pretender src/git.rs, drop git2 (work in charly/pretender)
- [ ] genesis-tpf.5 — migrate dont git plumbing (work in charly/dont)
- [ ] genesis-tpf.8 — migrate wai close.rs uncommitted-files + rename defect (work in charly/wai)
- [ ] genesis-tpf.6 — migrate whisper private-zone checks (work in charly/whisper)
- [ ] genesis-tpf.7 — migrate dulce dot_ddl tracked check (work in charly/dulce-de-leche)
- [~] Orchestration: fan .2–.8 out via **separate per-repo worktree subagents** — donor repos currently occupied by parallel agents (espectacular/pretender security-remediation, dont whisper-fixes); orchestration child ticket not yet created.

**Waiting**
- [~] genesis-2ex (update_check, P3) — in_progress in genesis; completes before the migration wave's next release cut.
