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

## 2026-07-21 20:31 — el-mundo-ha-vivido-equivocado

- Extracted audio from YouTube (Charly García reportaje 1982), cut segment 9:19–10:19
- Created materiales/ and programa/ dirs with .org files (org-mode per project convention)
- Built org→HTML pipeline: org-to-html.mjs converter, org-template.html, build-org-pages.mjs
- Wired build into justfile and ran full Rule-of-5 review on changeset
- Fixed issues: unused vars/imports, dead squint config, double-encoding in renderLinks, table row normalization
- **Next:** continue with textos pipeline (pl2) from the OpenSpec proposal, or resume program planning

---