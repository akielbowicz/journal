# Queue: el-mundo-ha-vivido-equivocado

Sessions captured with /next — processed by /close or /wrap-up.

---


## 2026-07-21 17:56 — el-mundo-ha-vivido-equivocado

- Set up full site scaffold: Squint build pipeline, GH Pages deploy, lefthook hooks, a11y/reader-mode validation, beads (bd) + OpenSpec
- Implemented markdown episode system: build-episodes.mjs, episode template with audio/YouTube/images/prev-next nav, sample episodes, vanilla JS search
- Added status: draft/published frontmatter, new-episode scaffolder
- Fixed CI failure (Node 20→22 for html-validate compat)
- Created FEATURES.md with thinking on textos, EPUB, analytics, seasonal theming, scheduled programs
- Added OpenSpec proposal add-textos-pages for textos pipeline, EPUB, print styles, CF Web Analytics
- **Next:** implement the textos pipeline (pl2) — scripts/build-textos.mjs, template, index, samples

---

## 2026-07-22 20:47 — el-mundo-ha-vivido-equivocado

- Migrated domain: equivocados.ar → equivocadxs.ar con redirect 301 desde Cloudflare
- Implemented 8 UI/UX tickets from evaluation report: inline hero audio player, platform distribution links, metadata badges (duration/genre), SVG cover artwork, quick-filter chips (AND), empty-state fallbacks for search/filter, nav label refinement, persistent sticky bottom audio bar with SPA fetch navigation
- Ran Rule of 5 review, fixed all findings: sessionStorage audio persistence, shared player partial (global-player.html + inject-player.mjs), atom-cached search index, tag validation, error handling on popstate
- Added boilerplate content to programa/cuentos, programa/ideas, programa/cronograma
- Created paginas/sobre.org + paginas/contacto.org with build-org-pages.mjs integration
- Added redirect pages: /sobre/ → /paginas/sobre/, /contacto/ → /paginas/contacto/, /episodios/1/ → /episodios/el-aleph/, /episodios/2/ → /episodios/la-noche-boca-arriba/
- Created custom 404.html with nav, episode suggestion, and global player
- **Next:** implement the textos pipeline (pl2) — build-textos.mjs, template, index, sample textos — or address any remaining OpenSpec tasks

- Extracted audio from YouTube (Charly García reportaje 1982), cut segment 9:19–10:19
- Created materiales/ and programa/ dirs with .org files (org-mode per project convention)
- Built org→HTML pipeline: org-to-html.mjs converter, org-template.html, build-org-pages.mjs
- Wired build into justfile and ran full Rule-of-5 review on changeset
- Fixed issues: unused vars/imports, dead squint config, double-encoding in renderLinks, table row normalization
- **Next:** continue with textos pipeline (pl2) from the OpenSpec proposal, or resume program planning

---

## 2026-07-23 10:10 — el-mundo-ha-vivido-equivocado

- Implemented textos pipeline (pl2):
  - scripts/build-textos.mjs: reads textos/*.md → HTML with prev/next nav, index with author/genre filters
  - scripts/texto-template.html: semantic HTML + a11y, related episode link, print button, EPUB download
  - scripts/new-texto.mjs: interactive scaffolder for new textos
  - textos/ directory with 2 sample texts (Borges, Neruda)
  - Textos added to search-index.json for global search
- Added Textos to all navs (homepage, episodes, org pages, 404)
- Homepage now links to /textos/ section
- Print styles improved: hide audio/video/search/filters, show URL footnotes
- CF Web Analytics snippet added to all templates (token: REPLACE_ME)
- epub-gen npm package installed
- **Next:** implement EPUB generation (build-epub.mjs), update docs, or resume program planning