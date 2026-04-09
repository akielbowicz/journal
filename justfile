# Justfile para journal, notas de laboratorio, y BuJo/PARA

export JORNAL := env("JORNAL", justfile_directory())

# Helper interno: commit local
[private]
_commit path mensaje:
    @git add "{{path}}"
    @git commit -m "{{mensaje}}"
    @echo "Committed: {{path}}"

# Crear/editar entrada de journal (nota diaria)
jrn:
    #!/usr/bin/env bash
    note_path=$(zk new --no-input log --print-path)
    zk edit "$note_path"
    just _commit "$note_path" "log: $(date +%Y-%m-%d)"

# Crear/editar nota de laboratorio/recurso
lab proyecto="":
    #!/usr/bin/env bash
    if [ -z "{{proyecto}}" ]; then
        note_path=$(zk list resources --sort created- --limit 1 --format path)
        if [ -n "$note_path" ]; then
            zk edit "$note_path"
            just _commit "$note_path" "resources: update $(basename $note_path .org)"
        else
            echo "No se encontraron notas."
            echo "Uso: just lab \"nombre del proyecto\""
            exit 1
        fi
    else
        note_path=$(zk new --no-input resources --title "{{proyecto}}" --print-path)
        zk edit "$note_path"
        just _commit "$note_path" "resources: add {{proyecto}}"
    fi

# Journal con IA - stream of consciousness
jrn-ai contenido:
    #!/usr/bin/env bash
    note_path=$(zk new --no-input log --print-path)
    claude --model sonnet-4.5 "Organiza el siguiente stream de consciencia en una entrada de journal estructurada en formato org-mode: {{contenido}}" >> "$note_path"
    just _commit "$note_path" "log: $(date +%Y-%m-%d) (ai)"

# Editar una nota (con búsqueda interactiva)
edit query="":
    #!/usr/bin/env bash
    if [ -z "{{query}}" ]; then
        note=$(zk list --format path | fzf --preview 'cat {}')
    else
        note=$(zk list --match "{{query}}" --format path --limit 1)
    fi
    if [ -n "$note" ]; then
        zk edit "$note"
        just _commit "$note" "update: $(basename $note)"
    fi

# Deploy skills to ~/.config/agents/skills/
deploy:
    @bash bin/sync

# Commit all pending changes
save mensaje="update journal":
    @git add inbox.md log/ projects/ areas/ resources/ archive/
    @git commit -m "{{mensaje}}" || echo "Nothing to commit"

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
    @echo "  just lab PROYECTO        - Crear/editar nota de laboratorio"
    @echo "  just edit [QUERY]        - Editar nota (interactivo o por búsqueda)"
    @echo "  just deploy              - Deploy skills to agent configs"
    @echo "  just save [MENSAJE]      - Commit pending journal changes"
    @echo "  just status              - Ver estado git"
    @echo "  just list [FILTRO]       - Listar notas recientes"
    @echo "  just search QUERY        - Buscar notas"
