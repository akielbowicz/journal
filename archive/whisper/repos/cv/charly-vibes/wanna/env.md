## Pre-push gate timing (2026-10-09, charly-fx4)
- Pre-push gates are timing-wrapped via tools/gate-timing.sh (mirrors tambor-j44): CSV rows ts,gate,exit,duration_ms → gitignored .gate-timing.log. TEMPORARY — removal ticket wanna-fxl; remove once ah ships --base/--head (GH#42) and lefthook uses it.
- First measurements: espectacular-contracts (ah check --run-tests) 522s ≈ 87% of a 9m09s push; testaruda-select 16.7s; pretender-gate 0.7s. Pure-push median this week: 197s (n=22).
- testaruda-gate is a compound sh line (tolerated codes 0/10/20); wrapped as `gate-timing.sh testaruda-select sh -c '...'`.
- lefthook pre-push section has NO specodelic/ah managed markers (those live in pre-commit) — safe to edit directly.
