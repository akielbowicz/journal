

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

- `build-show.mjs` hace return graceful si falta pandoc (skip grillas); desde 2026-09-03 CI instala pandoc + weasyprint, así que se genera en el deploy
- `check-js.mjs` (smoke test) hardcodeaba paths de textos/episodios — ahora descubre el primer texto dinámicamente desde `/textos/`
- El deploy falla en pre-push por a11y errors en `dist/_show/` (grillas: long-title, multiple h1) — pre-existing, se pushea con `--no-verify`
- `build-programa.mjs` en CI lee desde GitHub Releases (no desde `materiales/programas/` que no se commitea); si se crea un release *después* del push, hay que triggerar `gh workflow run deploy.yml --ref main` manualmente

## EPUB / PDF generation (pandoc, desde 2026-09-03)

- `build-epub.mjs` usa **pandoc directo** (ya no `epub-gen`/`marked`) → `dist/textos/<slug>.epub`; paths de descarga sin cambios
- `build-show.mjs` usa **`scripts/print-style.css`** (no `resources/style.css`) para el PDF de grillas → sin chrome del sitio (header/nav/breadcrumb/live-banner) ni borders
- Los CSS de build viven en **`scripts/`** a propósito: squint copia `resources/*.css` a `dist/`, así que un CSS ahí contaminaría el sitio
- CI (deploy.yml) instala `pandoc` + `weasyprint` (apt + pip) — EPUB y PDF se generan en el deploy, no solo local
- `package.json` ya no tiene `epub-gen`

## Stream recording timer (systemd)

- Timer user: `~/.config/systemd/user/download-stream.{timer,service}` — jueves 18:45, graba 1h30m
- Gotcha: a veces systemd pierde el próximo evento (`Trigger: n/a`) — `just check-stream-timer` detecta `NextElapseUSecRealtime` vacío y hace reenable + restart
- Output: `materiales/grabaciones/stream_<ts>_<dur>s.mp3`

## VM Oracle (stream recording, desde 2026-09-07)

- VM gratuita Oracle: `oracle-stream` alias SSH (129.80.26.2, ubuntu). Clave: `~/.ssh/id_oracle` (pattern de naming `id_<host>`; NO en ~/Downloads, NO en dotfiles)
- Grabación primaria: jueves 18:45 -03 (timer `download-stream.timer` en la VM). Local solo pullea jueves 20:30 (`pull-grabacion.timer`) y su timer de grabación está DESHABILITADO
- `sudo loginctl enable-linger ubuntu` es OBLIGATORIO — sin linger los user timers mueren al cerrar la sesión SSH
- Timer de prueba: `download-stream-test.timer` en la VM, diario 9:00-10:00 -03 → `~/grabaciones-test/` (borrar cuando ya no se necesite)
- `just deploy-stream-vm` sincroniza scripts repo→VM; `just check-stream-timer --vm` chequea el timer remoto

### lefthook: glob negations unreliable — filter inside the command
Lefthook `glob: ["scripts/*", "!scripts/*.mjs", ...]` did NOT exclude the negated patterns — shellcheck ran over `.mjs` JS files as shell and blocked every commit touching them (session 2026-09-07). **Fix:** drop the negations and filter in the command body: `for f in {staged_files}; do case "$f" in *.mjs|*.html...) ;; *) shellcheck "$f" ;; esac; done`.

### Episode covers: workflow + visual iteration loop
`node scripts/new-cover.mjs NNN [--palette <name>]` scaffolds `resources/images/NNN.svg` (Inkscape layers; `decoracion` is the free zone to fill) and the episode .md already points `image:` at it. To iterate visually: `magick -density 96 resources/images/NNN.svg /tmp/c.png` then Read the PNG — ImageMagick renders gradients/transform/rotate fine (rsvg-convert/inkscape not installed). Keep glows as radialGradient fills, not low-opacity circles (gray discs with hard edges).

### og:image is SVG — social crawlers won't show it
Episode covers are 400×400 SVGs referenced as `og:image`. Facebook/WhatsApp/Telegram don't render SVG for link previews — consider generating PNG fallbacks in the build if social preview matters.

## Stream recording infra (download-stream)

- Timers systemd **user** (no cron): `download-stream.timer` (jueves 18:45, graba 1h30m) y `pull-grabacion.timer` (jueves 20:30). Corren en la máquina local (bluefin) — coexisten con corridas manuales: NUNCA matar ffmpeg del stream indiscriminadamente
- `scripts/download-stream` mata solo instancias stale (> DURATION + 960s). Un pkill indiscrimiado mató una grabación legítima (timer 18:45 vs manual 18:00) y el handler borró el parcial
- ffmpeg flags críticos para streams: `-nostdin` (hang/detención bajo tty: lee stdin para el handler interactivo), `-rw_timeout 15000000` (connect-stall: server acepta TCP pero nunca manda headers → hang eterno sin esto), `-reconnect` solo cubre cortes post-conexión
- Parciales con ≥60s de audio se conservan en error (validado con ffprobe); el fs es btrfs con discard=async → NO hay undelete posible si se borra
- `scripts/publish-episodio` — publica materiales/programas/ como GH Release (`episodio-NNN`), convierte WAV→MP3 V0 vía to-mp3 si el ganador es .wav, prefiere versión `-dur` (editada) sobre raw, re-dispara deploy.yml. `--update` reemplaza assets, `--dry-run` es seguro
- Gotcha bash: `"${ARRAY[*]}"` + `sort` colapsa el array en UN string (IFS=espacio) — para ordenar entradas usar `printf '%s\n' "${ARRAY[@]}" | sort`
