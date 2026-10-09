- 2026-10-06T16:32:47Z [id:66ccecfe4ef3772543772d3472bd23160989451f555ef03aa2a2c24f0b4627d9] ### 2026-10-06 13:32 — snap
  - Reviewed and repaired all nine wild specifications; commit 4526db2 is pushed to origin/main.
  - Added docs/wild-formats-v1.md, schemas/wild-v1.schema.json, structural examples, explicit future acceptance cases, and executable design gates. Defined artifact-bound evidence, certificate commitments, conservative policy/cache rules, scoped substitution, and coordinated deployment safety.
  - Validation: 35 pytest tests passed; ah passed 23 checks; strict OpenSpec, specodelic, Pretender, and pre-push CI passed. Future runtime cases are distinguished from currently implemented prototype checks.
  - Existing user edit to testaruda.toml remains uncommitted and untouched. Specification task wild-0il is closed; runtime conformance is tracked in wild-3rr.
  - **Next:** Start with wild-3rr and implement v1 canonical reading, semantic validation, and subtype/accretion checks against the explicit acceptance cases; preserve the user's testaruda.toml edit.

- 2026-10-09T18:26:01Z [id:6cd4b41165b491a10f6b8ea9063ef5eaafd2d7931dd505f05bc6d063dcc42d46] Semantic-composition research is in .wai/projects/semantic-composition (protocol revision 2, commit 89905bc). Compare H0 flat, H1 authored wrappers and H2 schema-native composites on the same graph/oracle before varying decomposition. C05 shared identity and C07 artifact-bound evidence are mandatory from P1; required case counts are P1=18/P2=19/P3=20. C12 portability starts P2; C15 refinement starts P3. Architecture choice remains OPEN; a finite same-shape race probe is not evidence of full runtime conformance. Next: wild-9co.2/.3, then .4; .1/.5/.6 are closed. Follow the comparison protocol's cost ledger, frozen variants and readiness rules. Historical provisional-scope notes are superseded.

### 2026-10-09 18:09 — snap
- Renewed wild repo context; latest commit archives add-local-contract-checking (wild-mh5.5), all six mh5 children (mh5.1–mh5.6 incl. audit) are closed in bd.
- Epic wild-mh5 itself is still OPEN — close candidate now that mh5.6 audit is done, but verify success criteria (runtime scenario conformance + CI) first.
- Untracked: .wai/projects/software-updates mh5.1 orient/quality-ledger artifacts, cv/ dir; user's testaruda.toml edit remains uncommitted and untouched.
- **Next:** verify then close epic wild-mh5, or resume wild-9co.2 per prior snap (protected public laws vs valid/faulty replacements).
