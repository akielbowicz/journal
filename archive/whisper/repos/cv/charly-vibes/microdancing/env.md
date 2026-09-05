# microdancing env

Updated: 2026-09-04

## Scripts
- `scripts/usage-tracker.py` v4.1 — extrae datos de Claude, Pi, Amp
  - Calcula costos desde tokens × modelo pricing si no hay costos directos
  - Mergea dashboard-cache.json para costos precisos
  - Suma cuotas de suscripción mensual a costo real
  - Model pricing table en MODEL_PRICING dict (claude, codex, gemini, deepseek, kimi)
  - Cobertura: Claude CLI logs, Pi sesiones, Amp file-changes, Gemini
  - Filtro charly-only: proyectos con "charly" o "sk-" en el nombre
  - v4.1: cuenta cacheRead/cacheWrite de Pi y Claude (fix descubierto
    al validar contra toolpath). Totales: 1.25B → 10.5B tokens (8.4x).
    Costos sin cambio (Pi usa cost.total; Claude ya estimaba con cache).
  - Validación cruzada disponible vía `path` CLI (toolpath): cache en
    `~/.toolpath/`, no soporta Amp ni costeo; toolpath pierde sesiones
    pre-2026-01-28 y ~5% de sesiones pi

## Data files
- `data/usage_report_v3.json` — reporte completo
- `data/usage_hourly.json` — buckets hora a hora
- `data/daily_summary.json` — resumen diario

## Drafts
- `drafts/post-principal-resoluciones.md` — estructura del post grande
- `drafts/serie-aprendizaje-6-meses-boceto.md` — boceto original