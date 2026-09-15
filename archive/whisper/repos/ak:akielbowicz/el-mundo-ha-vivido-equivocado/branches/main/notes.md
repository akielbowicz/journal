
### 2026-09-10 17:38 — snap
- Episodio 05 (Kamiya · Iparraguirre) completo: frontmatter, portada 005.svg (taza de café sobre médanos, sin elefante), publicado (5414a4e). Ojo: `duration: 1:00:00` es placeholder — ajustar a la duración real del audio.
- Texto "Desayuno perfecto" (Alejandra Kamiya): transcrito, publicado con EPUB. Comillas tipográficas y "allí afuera" verificados contra el libro.
- Pipeline nuevo `just new-texto-ia <dir>`: fase 0 ordena imágenes por visión (`order-images.mjs`, los nombres son hashes), fase 1 transcribe pi + skill `.pi/skills/transcribir-texto` (default `openrouter/z-ai/glm-5.3-flash`), fase 2 verifica (`verify-texto.mjs`: checks deterministas + OCR cruzado por LCS). Documentado en AGENTS.md. Testeado end-to-end con overwrite sobre día-perfecto (91.7–97.7% match).
- **Next:** nada pendiente en el repo (todo pusheado). Si surge un texto nuevo: meter imágenes en `materiales/raw/imagenes/textos/<dir>/` y correr `just new-texto-ia <dir>`. Pendiente menor: duración real del episodio 05.
