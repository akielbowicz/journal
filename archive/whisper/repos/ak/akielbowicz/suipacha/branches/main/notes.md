### 2026-09-17 17:14 — snap
- Rule-of-5 sobre las 4 propuestas (01-terror, 02-PC, 03-FOSS, 04-IA) y presentacion-direccion.md; correcciones aplicadas y PDFs re-renderizados (2 páginas c/u verificado)
- Fixes clave: FOSS sin contradicción de inscripción + BitLocker/SMART en protocolo; PC costo total $30.000 + menores de 14 con adulto responsable; Terror exclusión radial hasta miércoles mediodía; IA reintegro 48 hs; dirección con tabla recalibrada, seguridad de menores y oferta de porcentaje a la institución
- Commit a98b6b4 pushed a origin/main
- **Next:** presentar presentacion-direccion.pdf a la biblioteca para fijar días/horarios (placeholders [día]/[hora] vigentes); luego completar los diseno.md (aún en plantilla) y armar autorizaciones en admin/

### 2026-09-25 11:52 — flyers/04 seminario IA: refinamiento + caption sin teléfono
- post.svg: header derecha sin "PRÁCTICO" (redundante) y cita sin comillas, solo itálica (commits heredados 5efa988); caption: fuera el WhatsApp personal — consultas por contacto directo con la biblioteca (7382b66) — regla: no exponer teléfonos personales en posts públicos de la biblioteca
- Renders en esta máquina: `rsvg-convert` NO instalado; fallback `magick -density 144 <svg> <out>` (PNG OK, PDF ~10 MB porque rasteriza — PDF vectorial requiere rsvg) — el PNG final va junto al SVG, no en flyers/export/
- Práctica útil: preview B/N con `magick ... -colorspace Gray -dither FloydSteinberg -colors 8` para validar legibilidad en fotocopia/láser antes de imprimir (veredicto flyer 04: se sostiene; punto débil menor: footer blanco sobre gris medio)
### 2026-10-05 16:30 — snap
- Sesión: renew del seminario IA (talleres-biblioteca/04-seminario-ia-profesion) → commit del diseño+mapeo (4e72761), investigación de corpus Nerdearla 2026 + SAIAConf 2026 en charly/tv (síntesis de 12 puntos), review Rule-of-5 de la investigación (2 correcciones HIGH: peritaje de autos sobre-leído, preferencia bot; TypeSafe verificado) y del paquete completo (2 HIGH verificados: planilla de 3 campos sin Gap, readiness vs E1)
- Builds: material/insumos-corpus.md (I1-I18/P1-P3, citas normalizadas de ASR con nivel de verificación), material/demo-facilitador.md (Gap #1: Ferretería El Tornillo, guion E1/E2/E4), material/mitos.md (Gap #4, 1 página). Fixes: Gap #3 con planilla de 3 campos, encuesta pre-curso como tarea, plan B regulatorio E4 (I15 si no llega la verificación legal), WhatsApp en propuesta = decisión pendiente
- Commits: 0b70619 (insumos+integración), 3fed17a (review fixes + Gaps #1/#4). No pusheado
- **Next:** generar capturas de la demo (salida mala, buena, iteraciones, precio trampa) y render de mitos.md a PDF (pandoc+weasyprint, just render) — prerequisitos de E1 mañana mar 6/10 18:30; luego registrar si salió la encuesta pre-curso
