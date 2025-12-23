# Configuración de ZK para gestión de notas

Esta guía describe cómo configurar [zk](https://github.com/mickael-menu/zk) en un repositorio para gestionar diferentes tipos de notas con automatización de commits.

## Categorías de notas

### Repositorio de borradores/conocimiento general
- **til** (Today I Learned / Hoy aprendí) → `hoy-aprendi/`
- **mch** (Machete / Cheat sheet) → `machetes/`
- **exp** (Exploraciones) → `exploraciones/`
- **tiw** (Things I Want / Quiero) → `quiero/`
- **ida** (Ideas) → `ideas/`

### Repositorio de proyecto/journal
- **jrn** (Journal / Notas diarias) → `jornal/`
- **lab** (Lab / Notas de laboratorio/proyecto) → `laboratorio/`

## Instalación de dependencias

```bash
# Instalar zk
# macOS
brew install zk

# Linux
# Ver: https://github.com/mickael-menu/zk#installation

# Instalar just (para automatización)
# macOS
brew install just

# Linux
# Ver: https://github.com/casey/just#installation
```

## Estructura del repositorio

```
.
├── .zk/
│   ├── config.toml          # Configuración principal de zk
│   └── templates/           # Templates para cada tipo de nota
│       ├── default.org
│       ├── til.org
│       ├── mch.org
│       ├── exp.org
│       ├── tiw.org
│       ├── ida.org
│       ├── jrn.org
│       └── lab.org
├── hoy-aprendi/            # Notas TIL
├── machetes/               # Cheat sheets
├── exploraciones/          # Exploraciones
├── quiero/                 # Things I want
├── ideas/                  # Ideas
├── jornal/                 # Notas diarias (solo en repo de journal)
├── laboratorio/            # Notas de proyecto (solo en repo de journal)
└── justfile                # Comandos de automatización
```

## Configuración paso a paso

### 1. Crear directorios

```bash
# Para repositorio de conocimiento general
mkdir -p .zk/templates hoy-aprendi machetes exploraciones quiero ideas

# Para repositorio de journal/proyecto
mkdir -p .zk/templates jornal laboratorio
```

### 2. Crear `.zk/config.toml`

<details>
<summary>Para repositorio de conocimiento general (borradores)</summary>

```toml
# Configuración de ZK
[note]
dir = "."
filename = "{{slug title}}.org"
default-template = "default.org"
lang = "es"
id-charset = "alphanum"
id-length = 8
id-case = "lower"

[format.org]
extension = "org"
title = "#+title:"
link-format = "[[{{path}}][{{title}}]]"

[alias]
til = 'zk new --no-input hoy-aprendi --template til.org --title "TIL: $1" "${@:2}"'
mch = 'zk new --no-input machetes --template mch.org --title "Machete: $1" "${@:2}"'
exp = 'zk new --no-input exploraciones --template exp.org --title "$@"'
tiw = 'zk new --no-input quiero --template tiw.org --title "Quiero: $1" "${@:2}"'
ida = 'zk new --no-input ideas --template ida.org --title "Idea: $1" "${@:2}"'

[group.til]
paths = ["hoy-aprendi"]

[group.mch]
paths = ["machetes"]

[group.exp]
paths = ["exploraciones"]

[group.tiw]
paths = ["quiero"]

[group.ida]
paths = ["ideas"]

[tool]
editor = "${EDITOR:-vim}"
```
</details>

<details>
<summary>Para repositorio de journal/proyecto</summary>

```toml
# Configuración de ZK para journal
[note]
dir = "."
filename = "{{slug title}}.org"
default-template = "default.org"
lang = "es"
id-charset = "alphanum"
id-length = 8
id-case = "lower"

[format.org]
extension = "org"
title = "#+title:"
link-format = "[[{{path}}][{{title}}]]"

[group.jrn]
paths = ["jornal"]
filename = "{{format-date now \"2006-01-02\"}}.org"
template = "jrn.org"

[group.lab]
paths = ["laboratorio"]
filename = "{{slug title}}-{{format-date now \"2006-01-02\"}}.org"
template = "lab.org"

[tool]
editor = "${EDITOR:-vim}"
```
</details>

### 3. Crear templates en `.zk/templates/`

<details>
<summary>default.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}


```
</details>

<details>
<summary>til.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** Lo que aprendí


** Por qué es importante


** Referencias

-
```
</details>

<details>
<summary>mch.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** Comandos principales


** Ejemplos


** Notas adicionales

```
</details>

<details>
<summary>exp.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** Contexto


** Exploración


** Conclusiones


** Próximos pasos

- [ ]
```
</details>

<details>
<summary>tiw.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** ¿Qué quiero?


** ¿Por qué lo quiero?


** ¿Cómo podría obtenerlo?


** Estado

- [ ] Idea inicial
- [ ] Investigación
- [ ] En progreso
- [ ] Completado
```
</details>

<details>
<summary>ida.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** La idea


** ¿Qué problema resuelve?


** Posibles implementaciones


** Notas

```
</details>

<details>
<summary>jrn.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** Lo que hice hoy


** Aprendizajes


** Pendientes

- [ ]

** Notas

```
</details>

<details>
<summary>lab.org</summary>

```org
#+title: {{title}}
#+date: {{format-date now}}

* {{title}}

** Objetivo


** Procedimiento


** Resultados


** Conclusiones


** Referencias

-
```
</details>

### 4. Crear `justfile`

<details>
<summary>Para repositorio de conocimiento general (borradores)</summary>

```justfile
# Justfile para automatizar la creación de notas con ZK

# Crear una nota TIL (Today I Learned / Hoy aprendí)
til titulo:
    @zk new --no-input hoy-aprendi --template til.org --title "TIL: {{titulo}}"
    @git add -A
    @git commit -m "Agregar TIL: {{titulo}}"
    @git push

# Crear un machete (cheat sheet)
mch titulo:
    @zk new --no-input machetes --template mch.org --title "Machete: {{titulo}}"
    @git add -A
    @git commit -m "Agregar machete: {{titulo}}"
    @git push

# Crear una exploración
exp titulo:
    @zk new --no-input exploraciones --template exp.org --title "{{titulo}}"
    @git add -A
    @git commit -m "Agregar exploración: {{titulo}}"
    @git push

# Crear una nota de "quiero" (things I want)
tiw titulo:
    @zk new --no-input quiero --template tiw.org --title "Quiero: {{titulo}}"
    @git add -A
    @git commit -m "Agregar cosa que quiero: {{titulo}}"
    @git push

# Crear una idea
ida titulo:
    @zk new --no-input ideas --template ida.org --title "Idea: {{titulo}}"
    @git add -A
    @git commit -m "Agregar idea: {{titulo}}"
    @git push

# Crear nota con IA - pasale el contenido y la categoría
ai-note categoria titulo contenido:
    #!/usr/bin/env bash
    set -euo pipefail
    case "{{categoria}}" in
        til) dir="hoy-aprendi"; template="til.org"; prefix="TIL: ";;
        mch) dir="machetes"; template="mch.org"; prefix="Machete: ";;
        exp) dir="exploraciones"; template="exp.org"; prefix="";;
        tiw) dir="quiero"; template="tiw.org"; prefix="Quiero: ";;
        ida) dir="ideas"; template="ida.org"; prefix="Idea: ";;
        *) echo "Categoría no válida. Usa: til, mch, exp, tiw, ida"; exit 1;;
    esac
    echo "Generando nota con IA..."
    full_title="${prefix}{{titulo}}"
    note_path=$(zk new --no-input "$dir" --template "$template" --title "$full_title" --print-path)
    if command -v claude &> /dev/null; then
        prompt="Crea una nota en formato org-mode sobre: {{contenido}}. Usa el título: $full_title. Incluye secciones relevantes y contenido útil."
        claude --model sonnet-4.5 "$prompt" >> "$note_path"
    else
        echo -e "\n** Contenido\n\n{{contenido}}" >> "$note_path"
    fi
    git add "$note_path"
    git commit -m "Agregar nota generada con IA: {{titulo}}"
    git push
    echo "Nota creada en: $note_path"

# Editar una nota (usa zk edit con búsqueda interactiva)
edit query="":
    #!/usr/bin/env bash
    if [ -z "{{query}}" ]; then
        note=$(zk list --format path | fzf --preview 'cat {}')
    else
        note=$(zk list --match "{{query}}" --format path --limit 1)
    fi
    if [ -n "$note" ]; then
        zk edit "$note"
        git add "$note"
        git commit -m "Actualizar: $(basename $note)"
        git push
    fi

# Sincronizar cambios
sync mensaje="Actualizar notas":
    @git add -A
    @git commit -m "{{mensaje}}"
    @git push

# Ver el estado del repositorio
status:
    @git status

# Listar notas recientes
list filtro="":
    @zk list --sort created- --limit 20 {{filtro}}

# Buscar notas por contenido
search query:
    @zk list --match "{{query}}" --format full

# Ayuda
help:
    @echo "Comandos disponibles:"
    @echo "  just til TITULO          - Crear TIL"
    @echo "  just mch TITULO          - Crear machete"
    @echo "  just exp TITULO          - Crear exploración"
    @echo "  just tiw TITULO          - Crear 'quiero'"
    @echo "  just ida TITULO          - Crear idea"
    @echo "  just ai-note CAT TITULO CONTENIDO - Crear nota con IA"
    @echo "  just edit [QUERY]        - Editar nota"
    @echo "  just sync [MENSAJE]      - Sincronizar cambios"
    @echo "  just status              - Ver estado git"
    @echo "  just list [FILTRO]       - Listar notas recientes"
    @echo "  just search QUERY        - Buscar notas"
```
</details>

<details>
<summary>Para repositorio de journal/proyecto</summary>

```justfile
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
```
</details>

### 5. Actualizar `.gitignore`

Si usas GitHub Actions para generar índices automáticos (como en este repo), agrega:

```gitignore
# Emacs temporary files
*~
\#*\#
.\#*

# ZK - solo ignorar cache y db, no la config
.zk/cache/
.zk/.zk.db*
.zk/notebooks.db*

# Generated navigation files (si usas un script de generación)
index.org
hoy-aprendi.org
machetes.org
exploraciones.org
quiero.org
ideas.org
jornal.org
laboratorio.org
```

## Uso

### Comandos básicos

```bash
# Crear notas
just til "uso de git worktree"
just mch "docker"
just exp "configurando neovim"
just tiw "una computadora más rápida"
just ida "app para tracking de hábitos"

# Para journal/proyecto
just jrn                                                        # Crea/edita nota del día
just jrn-ai "Hoy trabajé en el proyecto X, aprendí sobre Y..." # Genera nota con IA
just lab "nombre-proyecto"                                      # Crea/edita nota de lab

# Crear con IA
just ai-note til "git rebase" "Explica cómo funciona git rebase interactivo"

# Editar y sincronizar
just edit                    # Selector interactivo (requiere fzf)
just edit "docker"           # Buscar y editar
just sync "Actualización semanal"

# Listar y buscar
just list                    # Últimas 20 notas
just search "kubernetes"     # Buscar por contenido
```

### Uso directo de zk

```bash
# Crear nota (zk detecta si ya existe y la edita)
zk new jornal               # Nota diaria
zk new laboratorio          # Nota de laboratorio (necesita --title)

# Editar con selector interactivo
zk edit --interactive

# Buscar
zk list --match "docker"

# Ver backlinks
zk list --link-to path/to/note.org
```

## Configuración global (opcional)

Para usar comandos globales que apunten a diferentes repos, crea un `~/justfile` global:

```justfile
# Justfile global para acceder a diferentes repos de notas

# Borradores (conocimiento general)
alias b := borradores
borradores subcmd *args:
    cd ~/para/areas/dev/gh/ak/borradores && just {{subcmd}} {{args}}

# Journal personal
alias j := journal
journal subcmd *args:
    cd ~/para/journal && just {{subcmd}} {{args}}

# Ejemplos de uso:
# just b til "título"
# just j jrn
```

## Referencias

- [zk documentation](https://github.com/mickael-menu/zk)
- [just documentation](https://github.com/casey/just)
- [AI stream journaling](https://idratherbewriting.com/blog/ai-stream-journaling-experiment)
