### 2026-09-04 13:10 — snap
- michael theme matured this session: v2 ramp (gate-derived), full 4-bit eval cache rebuilt (42 verdicts, median-of-3, merge-safe save), highlight.js generator + live-code section on site, gallery with color-originals filter, install.sh (stdlib-only, ghostty + windows-terminal targets), Rule-of-5 review fixes applied
- In-progress: Rule-of-5 review of new implementation drafted mid-turn; studied atril's github-api.ts patterns (API_BASE/RAW_BASE, rate-limit error class, cache map) for the planned site/inspect.html — GitHub code inspector page, mobile-first
- **Next:** finish the inspect.html page (URL parse for blob URLs, api.github.com contents/raw fetch with rate-limit handling, hljs + michael dual-variant CSS, light/dark toggle) following atril patterns; then Rule-of-5 report on new implementation

### 2026-09-04 (session 2) — inspect.html shipped
- Built site/inspect.html: GitHub code inspector (mobile-first) — blob/raw URL + owner/repo@ref:path parsing, raw-first fetch w/ API fallback, GitHubApiError + rate-limit detection (X-RateLimit-Remaining), cache map, slash-branch ref-variant resolution, ext→lang map, dual-polarity toggle (page+code share data-michael), #inspect= hash share links
- Rule-of-5 review done: fixed XSS (meta.innerHTML user fields), encodeURI→segment-wise encodeURIComponent, status double-set; verified parser + live fetch paths in node
- index.html Links + Gallery sections link to inspector
- Committed a32f5ce, pushed; branch clean. Next: none queued — could add /tree/ URL support or language coverage later

### 2026-09-04 (session 3) — light-mode live-code fix
- User reported light toggle + syntax dead on live site — cause: screenshot predated the 15:54 deploy of the scoped-selector fix; verified live post-deploy via headless chromium (DOM dump: token spans present; screenshot: light bg rendering)
- Found real bug: `.hljs` bg painted per line box (inline code element) — ragged light strips. Fixed in generators/highlightjs.py: base rule now `display: block; overflow-x: auto;` → full-bleed panel bg. Verified dual-variant render side-by-side via headless screenshot
- Gotcha learned: flatpak chromium can't read /tmp — test files must live in ~; write screenshot with explicit path
- Committed 5ef731c, pushed, Pages deploy success. Next: none queued

### 2026-09-04 (session 4) — language-switch highlight fix
- User reported syntax highlighting lost after switching languages in live-code section (and not returning on python)
- Root cause: hljs 11 sets data-highlighted="yes" on first highlightElement() and silently skips re-highlighting; setLang replaced textContent but not the marker → all subsequent setLang calls no-op'd. inspect.html already handled it; live-code.js predates that pattern
- Fix d67e2f0: removeAttribute data-highlighted + data-hljs before re-highlight. Verified headless: python→9 spans, rust→7 spans with fix; negative control without fix = 0 spans
- Pages deploy success. Next: none queued

### 2026-09-04 (session 5) — julia/clojure language modules
- User reported julia + clojure still unhighlighted. Empirical check via headless chromium: hljs CDN "common" bundle does NOT register julia or clojure (getLanguage → N for both; python/rust/typescript/csharp = Y)
- Fix bf784a1: load languages/julia.min.js + languages/clojure.min.js after highlight.min.js in index.html and inspect.html. Verified: all 6 langs Y; julia 6 spans, clojure 11 spans through re-highlight flow
- Lesson: never assume CDN common bundle coverage — check getLanguage per language the site renders
- Pages deploy success. Next: none queued

### 2026-09-04 (session 6) — six new highlight languages
- Added css/html/xml/json/yaml/toml pills to live-code.js (12 languages total). Discovery: all six grammars already resolve via the common bundle — html+svg are aliases of xml, and toml is an alias of the ini grammar; no extra script tags needed
- Verified headlessly: real setLang flow over all 12 languages produced token spans each time (python=39 julia=19 rust=25 typescript=43 clojure=33 csharp=31 css=14 html=33 xml=24 json=41 yaml=21 toml=13) — re-highlight chain works
- inspect.html EXT_LANG now maps html→'html', toml→'toml' (proper alias names, correct meta label)
- Committed 26dda00, pushed, Pages deploy success. Next: none queued

### 2026-09-04 (session 7) — Rule-of-5 CTA review of index.html
- Full 5-stage review focused on CTA clarity + install/inspector usability. Fold check (1280x800 headless): zero CTAs above the fold — first CTA was 5 sections deep
- Fixed bc8cbd4: hero CTA row (Install primary + inspector + gallery, pill-derived .cta styling), one-line inspector explainer under CTAs, #install anchor, copy-to-clipboard button on install commands (clipboard API + execCommand fallback), install copy corrected ("installs every target at once (gnome doom vscode ghostty), pass targets for subset") — verified against install.sh: no-args = all except windows, silent writes; Links section now has descriptors
- Verified headless: CTAs visible in first viewport, anchors resolve, copy wiring present
- Committed bc8cbd4, pushed, Pages deploy success. Next: none queued
