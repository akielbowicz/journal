# microdancing env

Updated: 2026-09-01

## Scripts
- `scripts/usage-tracker.py` v4 — extrae datos de Claude, Pi, Amp
  - Calcula costos desde tokens × modelo pricing si no hay costos directos
  - Mergea dashboard-cache.json para costos precisos
  - Suma cuotas de suscripción mensual a costo real
  - Model pricing table en MODEL_PRICING dict (claude, codex, gemini, deepseek, kimi)
  - Cobertura: Claude CLI logs, Pi sesiones, Amp file-changes, Gemini
  - Filtro charly-only: proyectos con "charly" o "sk-" en el nombre

## Data files
- `data/usage_report_v3.json` — reporte completo
- `data/usage_hourly.json` — buckets hora a hora
- `data/daily_summary.json` — resumen diario

## Drafts
- `drafts/post-principal-resoluciones.md` — estructura del post grande
- `drafts/serie-aprendizaje-6-meses-boceto.md` — boceto original