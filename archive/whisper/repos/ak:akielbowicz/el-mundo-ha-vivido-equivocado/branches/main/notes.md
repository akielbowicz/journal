
### 2026-09-10 17:38 — snap
- Episodio 05 (Kamiya · Iparraguirre) completo: frontmatter, portada 005.svg (taza de café sobre médanos, sin elefante), publicado (5414a4e). Ojo: `duration: 1:00:00` es placeholder — ajustar a la duración real del audio.
- Texto "Desayuno perfecto" (Alejandra Kamiya): transcrito, publicado con EPUB. Comillas tipográficas y "allí afuera" verificados contra el libro.
- Pipeline nuevo `just new-texto-ia <dir>`: fase 0 ordena imágenes por visión (`order-images.mjs`, los nombres son hashes), fase 1 transcribe pi + skill `.pi/skills/transcribir-texto` (default `openrouter/z-ai/glm-5.3-flash`), fase 2 verifica (`verify-texto.mjs`: checks deterministas + OCR cruzado por LCS). Documentado en AGENTS.md. Testeado end-to-end con overwrite sobre día-perfecto (91.7–97.7% match).
- **Next:** nada pendiente en el repo (todo pusheado). Si surge un texto nuevo: meter imágenes en `materiales/raw/imagenes/textos/<dir>/` y correr `just new-texto-ia <dir>`. Pendiente menor: duración real del episodio 05.

### 2026-09-18 15:39 — snap
- Página oculta de diagnóstico del stream: `/_stream-check/` (vanilla JS + Web Audio). Monitorea en vivo los canales L/R del stream que graba `download-stream`: ondas L/R y L−R, medidores RMS/pico-hold, balance, alerta de canal muerto con ~1s de sostenido, detección de stream MONO (header MP3), failsafe CORS. `scripts/build-stream-check.mjs` inyecta la STREAM_URL de `download-stream` → `dist/_stream-check/` (excluida del sitemap, noindex). Commits 4830ded, e5d177e.
- Confirmado con mediciones (grabaciones + en vivo): el canal derecho del stream está en silencio/débil (~25-50 dB menos que L). Issue beads `me1` (P2) para reportar al operador de la radio.
- Review rule-of-5 aplicada al código nuevo: 6 findings corregidos (balance mentía en silencio total, rAF loop pisaba historial tras error, retry con audio.load(), peak-hold, anti-parpadeo de alerta, contextos canvas cacheados).
- **Next:** reportar el canal R muerto a la radio (issue me1) usando los números de /_stream-check/ como evidencia. Página disponible en producción tras deploy: equivocadxs.ar/_stream-check/. `lista` (links de YouTube) quedó modificado sin commitear — es edición del usuario.
