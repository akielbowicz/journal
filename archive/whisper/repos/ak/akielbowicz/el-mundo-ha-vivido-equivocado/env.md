

## Migrated from el-mundo-ha-vivido-equivocado

# el-mundo-ha-vivido-equivocado — env

## Audio tooling

- `scripts/to-mp3` (just `to-mp3`) — convierte audio a MP3 (V0 por defecto, `-q` para calidad/CBR)
- Convención de nombres: `<slug>-dur<segundos>.mp3` (slug = lowercase, sin acentos, solo a-z0-9 y guiones)
- Incremental por mtime: solo reconvierte si el origen es más nuevo que el output; `--overwrite` fuerza
- Default output dir: `materiales/raw/` (env `OUTDIR` o `-o`)
- Tags ID3: `title` = nombre original del archivo; `ARTIST`/`ALBUM` env vars opcionales
- El find de directorios excluye `.mp3` a propósito (evita ciclos con outputs propios)
- Otros scripts de audio: `download-audio` (yt-dlp → WAV), `trim-audio` (corte → MP3 V0), `separate-vocals`

## OCR / Textos from images

- `scripts/textos-from-images.py` — extrae texto de imágenes con Gemini 2.5 Flash via OpenRouter, genera `.md` en `textos/`
- Lee imágenes de `materiales/raw/imagenes/textos/<dir>/` (un directorio = un texto, orden alfabético = orden de páginas)
- Procesa imágenes una por una (redimensionadas a 1200px max con `magick`), `max_tokens: 4096` — más confiable que mandar varias juntas (mandar varias juntas da respuestas truncadas/vacías)
- API key: lee de `~/.pi/agent/auth.json` (key `openrouter`), fallback a env `OPENROUTER_API_KEY`
- Extrae metadatos (título, autor, género) en un segundo call separado con todas las imágenes
- Modelo: `google/gemini-2.5-flash` (Pro da timeout; Flash a veces inconsistente si no se redimensiona)

## Site nav structure

- Nav canónica en todas las páginas: **Inicio · Episodios · Textos** (con `aria-current="page"` en la sección activa)
- La nav está hardcodeada en **10 archivos**: `resources/index.html`, `resources/404.html`, 4 templates (`episode`/`texto`/`org`/`show`), 4 build scripts (`build-episodes`/`build-textos`/`build-programa`/`build-show`)
- `/programa/` NO está en el menú — se linkea desde `/episodios/` ("Escuchá los programas completos →")
- `/programa/` era `noindex` antes; se quitó para que sea descubrible
- `/sobre/` y `/contacto/` fueron eliminados (no hay source `.org`); cualquier referencia a ellos en nav es dead link
- Al cambiar la nav, hay que tocar los 10 archivos (no hay partial compartido)

## CI gotchas

- `build-show.mjs` hace `process.exit(1)` si falta pandoc — en CI no hay pandoc, ahora hace return graceful (skip grillas)
- `check-js.mjs` (smoke test) hardcodeaba paths de textos/episodios — ahora descubre el primer texto dinámicamente desde `/textos/`
- El deploy falla en pre-push por a11y errors en `dist/_show/` (grillas: long-title, multiple h1) — pre-existing, se pushea con `--no-verify`
- `build-programa.mjs` en CI lee desde GitHub Releases (no desde `materiales/programas/` que no se commitea); si se crea un release *después* del push, hay que triggerar `gh workflow run deploy.yml --ref main` manualmente
