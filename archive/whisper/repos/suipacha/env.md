# suipacha env

## wrangler 4: KV commands default to local in non-interactive
wrangler 4 en contexto no interactivo (sin CLOUDFLARE_API_TOKEN como variable de entorno)
ejecuta los comandos `kv key get/put/delete/list` contra almacenamiento LOCAL (miniflare),
no remoto. Siempre pasar `--remote` explícito cuando se usa desde agentes/scripts.
También afecta al justfile recipe `kv-create` si se corre sin `.env` — el recipe de
`taller-ia` ya lo incluye corregido.
