# suipacha env

## wrangler 4: KV commands default to local in non-interactive
wrangler 4 en contexto no interactivo (sin CLOUDFLARE_API_TOKEN como variable de entorno)
ejecuta los comandos `kv key get/put/delete/list` contra almacenamiento LOCAL (miniflare),
no remoto. Siempre pasar `--remote` explícito cuando se usa desde agentes/scripts.
También afecta al justfile recipe `kv-create` si se corre sin `.env` — el recipe de
`taller-ia` ya lo incluye corregido.

## talleres-biblioteca: pipeline pandoc + weasyprint + just
- No hay LaTeX en el sistema (solo weasyprint): los PDFs de propuestas se generan
  con `--pdf-engine=weasyprint --css=estilo.css` (editorial serif/sans, pie con
  "Biblioteca Popular de Suipacha" + N/N páginas).
- El ANCHO DE COLUMNAS de tablas viene de los guiones de la fila separadora del
  pipe table (pandoc emite <colgroup> con anchos proporcionales que PISAN el CSS).
  Para balancear columnas, ajustar los `---` del markdown, no estilo.css.
- weasyprint hacíita `hyphens: none` en th/td para evitar cortes feos tipo
  "PARTI-CIPANTE" en headers uppercase.
- `just` de esta versión no hace unescape de `$$` en recipes (expandió el PID):
  no usar `$$()` ni variables shell en recipes; usar funciones nativas just
  (`{{file_stem()}}`) o deps explícitos `(render "...")`.
- `render <taller>` asume `<taller>/propuesta.md`; presentacion-direccion.md
  vive en la raíz y tiene su propio recipe `just direccion`.
