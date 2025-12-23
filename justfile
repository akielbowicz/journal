# Justfile para journal y notas de laboratorio

# Crear/editar entrada de journal (nota diaria)
jrn:
    #!/usr/bin/env bash
    note_path=$(zk new --no-input jornal --print-path)
    zk edit "$note_path"
    echo "Nota creada: $note_path"

# Crear/editar nota de laboratorio/proyecto (con nombre de proyecto y fecha automática)
lab proyecto:
    #!/usr/bin/env bash
    note_path=$(zk new --no-input laboratorio --title "{{proyecto}}" --print-path)
    zk edit "$note_path"
    echo "Nota creada: $note_path"

# Journal con IA - stream of consciousness
jrn-ai contenido:
    #!/usr/bin/env bash
    note_path=$(zk new --no-input jornal --print-path)
    claude --model sonnet-4.5 "Organiza el siguiente stream de consciencia en una entrada de journal estructurada en formato org-mode: {{contenido}}" >> "$note_path"
    echo "Journal creado en: $note_path"

# Sincronizar cambios
sync mensaje="Actualizar notas":
    @git add -A
    @git commit -m "{{mensaje}}"
    @git push

# Ver el estado
status:
    @git status

# Listar notas recientes
list filtro="":
    @zk list --sort created- --limit 20 {{filtro}}

# Buscar notas
search query:
    @zk list --match "{{query}}" --format full

# Ayuda
help:
    @echo "Comandos disponibles:"
    @echo "  just jrn                 - Crear/editar journal de hoy"
    @echo "  just jrn-ai CONTENIDO    - Crear journal con IA"
    @echo "  just lab PROYECTO        - Crear/editar nota de laboratorio (fecha automática)"
    @echo "  just sync [MENSAJE]      - Commit y push de cambios"
    @echo "  just status              - Ver estado git"
    @echo "  just list [FILTRO]       - Listar notas recientes"
    @echo "  just search QUERY        - Buscar notas"
