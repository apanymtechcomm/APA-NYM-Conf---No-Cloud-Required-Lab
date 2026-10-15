# LIC IBZ Lab — Working with Hermes for Planners

A 20-minute teaching laboratory on using agent-based AI for planning work,
centered on the Long Island City Industrial Business Zone. Designed for
**just-installed Hermes** — no LanceDB, no embedding stack, no local model
servers. Everything runs on stock Hermes tools with a free Nous Portal
account.

## Start here

**Students:** open [`STUDENT_LESSON.md`](STUDENT_LESSON.md) — it walks you
through setup and all six segments of the lab.

## What's in this repo

```
STUDENT_LESSON.md          ← the lesson: setup, six timed segments, audit list
summaries/                 ← three pre-assembled document summaries (~9 KB)
  OneLIC_Summary.md          every fact cited to its source chapter
  FEIS_25DCP001Q_Summary.md
  NYC_Industrial_Plan_Summary.md
data/
  lic_ibz_parcels.csv      ← MapPLUTO 26v2 clipped to the official NYCEDC
                             LIC IBZ boundary (1,176 lots)
instructor/                ← for the person teaching it
  LESSON_PLAN.md            timed plan with verified answers + teaching points
  PRE_STAGING_CHECKLIST.md  distribution, day-of checks, timing guidance
  DRY_RUN_LOG.md            full evidence trail: sources, hashes, verified
                            search results, test runs
```

## The lab in one paragraph

Students characterize the existing industrial stock of the LIC IBZ from a
pre-clipped MapPLUTO parcel file, read three planning documents (the OneLIC
rezoning, its EIS, and the NYC Industrial Plan) through pre-assembled
summaries, distill the findings into the agent's small memory system, and
finish with a five-sentence planning recommendation. The memory-distillation
step is the architectural lesson: a 60 MB PDF doesn't fit in a ~2,200-character
memory — deciding what survives is the skill.

## Key verified numbers

- 1,176 tax lots in the LIC IBZ; 539 coded LandUse 06 (46%)
- Median BuiltFAR 1.05; median year built 1940; 118 lots LandUse 07 (separate)
- OneLIC: adopted 2025-11-12; CEQR 25DCP001Q; ~14,700 homes incl. ~4,300
  income-restricted; IBZ industrial subareas stay nonresidential
- NYC Industrial Plan: final 2025-12-19 (LL 172 of 2023); 5 goals, 20
  strategies, 72 ideas per the plan text; 17,000+ acres protected

## Model recommendation (tested, not guessed)

Primary `poolside/laguna-s-2.1:free`, fallback `upstage/solar-mini4:free` —
both verified end-to-end on this lab (all six segments PASS on each).
Re-smoke-test the morning of class: the free catalog churns.

## Provenance

All underlying documents are public NYC sources (URLs in
`STUDENT_LESSON.md`). MapPLUTO 26v2 (August 2026 vintage) clipped to the
official NYCEDC IBZ boundary; CSV hash recorded in
`instructor/DRY_RUN_LOG.md`. The lab package was built and validated
2026-10-14; test evidence in `instructor/`.
