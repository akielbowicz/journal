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
