# talleres (Phorma workshops)

Design workspace + knowledge system for the Phorma Scientific workshop
catalog at `~/para/areas/dev/gh/phorma/talleres`
([github.com/PhormaSci/talleres](https://github.com/PhormaSci/talleres)).
21 workshops (`workshops/<order>-<slug>/{en,es,shared}/`); upstream source of
truth for `phormasci.github.io/content/trainees/`. Whisper is repo-local
(`.whisper/` committed by design). Full conventions in the repo's AGENTS.md.

## Tasks

- [ ] Sasha: CABA §7 decisions (see `program/deep-research/caba-analysis-2026-09-18.md`): shortlist approval (83→81→51→21→31), design-vs-outreach sequencing (agent rec: outreach first), first channel (rec: CONICET direct), in-company pricing, 71/72 CABA sequencing
- [ ] Sasha: persona-fork decision for 91–93 was resolved 2026-09-18 (parked, option c) — no action; tripwire recorded in `program/catalog.md` Parked section
- [ ] Bioimage/pathology deep-research: run + intake DONE (2026-09-18, `2026-09-18-bioimage-pathology-landscape.md`); 70/80-leverage pass done at intake (agentic failure modes seed 71/73/74/82/83; LABI/CABANA = regional channels). Remaining: 51–54 design-fuel pass + digital-pathology new-workshop question + tool-version spot-checks before any `shared/` use
- [ ] PragEng + SAIA tv corpora: leverage pass DONE (2026-09-19, teaching-topics C-34–C-43; es-native anchors for 71/75/82); candidates live in teaching-topics only — fold into 73/74/75/82 designs at their next design pass
- [ ] Design passes for remaining shells when promotion demand lands (51/21/31 shortlisted for CABA; shells = interest-registration only per analysis readiness rungs)

## Waiting

- [~] Verify-before-use list before any batch-A candidate adoption (C-6/C-9/C-15): Microsoft eval-faq primary, MCP stateless spec version, Inzlicht study — `program/deep-research/batch-analysis-a-2026-09-18.md` §6
- [~] 71 delivery prerequisite: ops-provisioning capability before selling (`program/evidence/71-ops-provisioning-check-2026-09-17.md`)
- [~] Whisper #1 relative-path bug: `.whisper/config.toml` pinned absolute until fixed; flip when whisper#1 ships

## Notes

- Catalog Parked section (added 2026-09-18) is the tripwire home for deferred
  directions — principles #18–20 in `program/design-principles.md` govern
  audience/category additions.
- CABA launch premise (empty scientific-AI segment) has a shelf life: re-run
  the null search before each promotion push (`caba-analysis-2026-09-18.md` §8).
- Gates: `just check` before every commit (parity + one-pager staleness);
  vale/typos run client-side on staged files. Never `--no-verify` on parity.
