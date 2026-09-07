# microdancing notes

## 2026-09-04 — Evaluación de toolpath (empathic/toolpath) como capa de extracción

- `path` CLI 0.16.1 instalado (~/.local/bin/path). `path p cache sync` ingirió:
  pi 855/856, claude 107, gemini 88 (4 failed), codex 26 → 1,076 docs en
  `~/.toolpath/documents/`
- **No soporta Amp** → `extract_amp()` del tracker se queda.
- **Sin costeo** (pricing por modelo, fees de suscripción, merge dashboard-cache) →
  esa capa sigue siendo de `usage-tracker.py`.
- Token accounting preserva `cache_read_tokens`/`cache_write_tokens` (TokenUsage).
- **Hallazgo:** `extract_pi()` del tracker ignora `cacheRead`/`cacheWrite` de Pi —
  undercount masivo de tokens si el post cita totales. Con filtro charly toolpath
  mide: in 654M, out 27M, cache_read 5.38B, cache_write 47M (desde Jan 11).
- Conteos no comparables 1:1: tracker 133,819 "interacciones" (1 fila por mensaje
  assistant) vs toolpath steps (agrupa message groups, dedupe vía
  `attributed_token_usage`). Ej. 2026-09-01: tracker 423 vs toolpath 915 steps.
- Toolpath no encontró sesiones anteriores a 2026-01-28; el tracker cubre desde
  2026-01-11 → riesgo de pérdida de histórico si se migra tal cual.
- Cobertura extra gratis: Codex (26 sesiones, ~113M tokens charly).
- **Decisión:** enfoque híbrido. Corto plazo: toolpath como capa de validación
  cruzada + fix de cacheRead/cacheWrite en `extract_pi()`. Largo plazo: reemplazar
  extractores claude/pi/gemini/codex por `path p import` y dejar el tracker como
  capa de costeo/agregación (~692 → ~300 líneas).
- Queries útiles: `path query 'map(select(any(.change[].structural.token_usage;
  .input_tokens > 50000)))'`

## 2026-09-05 — Review rule-of-5 sobre v4.1 (commit fc7a0fc)

- 0 CRITICAL, 3 HIGH corregidos: per-tool breakdown ahora incluye
  cache_read/cache_write; dedup key agrega project (recupera 14 filas Pi
  colisionando en mismo segundo); cache_write a 1.25x en estimate_cost
- metadata.token_accounting documenta semántica (cache aparte de input/output)
- Números actuales: 135,436 reqs, eff $3,800.84, real $369.58, cache_r 9.19B
- ⚠️ Abierto (DRAFT-001): drafts/post-principal-resoluciones.md cita números v4
  viejos y el cutoff de datos sigue avanzando (ahora Sep 7) — al escribir el
  post, congelar un reporte y citar "datos al <fecha>"
- DRAFT-002: nombre de archivo usage_report_v3.json vs script v4.1 — no alineado
