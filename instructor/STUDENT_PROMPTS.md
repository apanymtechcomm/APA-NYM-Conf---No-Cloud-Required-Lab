# Student Prompt Sheet — LIC IBZ Lab (20 minutes)

Paste each prompt into your Hermes session in order. Your instructor runs the
projected machine; call out your own phrasing when invited — different phrasings
produce different answers, and that's part of the lesson.

## Before you start

Your agent should be running `poolside/laguna-s-2.1:free` (fallback:
`upstage/solar-mini4:free`). If answers take minutes or come back as long visible
"thinking" with no answer, tell the instructor — the model is wrong for this lab.

Your instructor has given you pre-assembled summaries of the three planning
documents plus the parcel table — put them in your Hermes workspace:

- `summaries/OneLIC_Summary.md` — the OneLIC rezoning (segment 3)
- `summaries/FEIS_25DCP001Q_Summary.md` — the OneLIC EIS (segment 3)
- `summaries/NYC_Industrial_Plan_Summary.md` — the NYC Industrial Plan (segment 3)
- `lic_ibz_parcels.csv` — the MapPLUTO parcel table for the IBZ (segment 2)

(Optional deep-dive: the full 8 PDFs are in `doc-pack.zip`. Each summary cites
its source chapters, so you can verify any claim against the original document
— a habit worth building.)

---

### 1. Frame the question (0:00–2:00)

```
We are evaluating the Long Island City Industrial Business Zone. Separate the
task into: existing physical stock, adopted neighborhood policy, environmental
constraints, and citywide industrial policy. List the evidence needed for each
part.
```

A good answer separates four evidence streams and warns that IBZ designation,
manufacturing zoning, and PLUTO land use are three different variables.

### 2. Characterize the stock (2:00–7:00)

Give the agent the file path `/mnt/e/OC_Projects/projects/lic-ibz-lab/data/lic_ibz_parcels.csv`
(MapPLUTO 26v2, clipped to the official IBZ boundary):

```
Using the pre-clipped 26v2 MapPLUTO table for the Long Island City IBZ,
calculate: unique tax lots; lots coded LandUse 06; total LotArea and BldgArea
for those lots; median BuiltFAR; median YearBuilt excluding zero or missing
values; zoning districts by lot count; and total FactryArea, StrgeArea, and
OfficeArea. State all filtering rules.
```

Verified answers: **1,176 lots; 539 LandUse 06; median BuiltFAR 1.05; median
year built 1940** (zero/missing excluded); **118 lots are LandUse 07**
(transportation/utility) — kept separate; 16 lots missing land use.

### 3. Read the summaries, save what matters (7:00–12:00)

```
Read these three pre-assembled document summaries:
[path]/summaries/OneLIC_Summary.md,
[path]/summaries/FEIS_25DCP001Q_Summary.md,
[path]/summaries/NYC_Industrial_Plan_Summary.md.
For the Long Island City IBZ question, extract: (a) OneLIC — adoption date,
application numbers, what zoning changed, housing and commercial figures;
(b) the FEIS — findings on hazardous materials, transportation, and noise, and
the (E) Designation requirements; (c) the NYC Industrial Plan — its
goals/strategies/recommendations structure, acreage protected, and what its
Primary/Secondary Industrial Areas are. Save the distilled findings to your
memory. Memory is limited to roughly 2,200 characters, so you must choose what
to keep — state what you kept, what you dropped, and why. Everything must trace
to the summaries.
```

The lesson of this segment: the summaries are already pre-digested — but your
agent's memory is small, so **deciding what survives the second distillation is
still the skill**. Watch what it keeps, what it drops, and whether every number
traces to a summary. A good distilled entry (~1,000 characters) looks like this:

```
LIC IBZ baseline (MapPLUTO 26v2 clipped to official NYCEDC boundary): 1,176
lots; 539 industrial (LandUse 06); median BuiltFAR 1.05; median YearBuilt
1940; 118 lots transportation/utility (07), analyzed separately.
OneLIC (adopted 2025-11-12; CEQR 25DCP001Q; C 250176 ZMQ, N 250177 ZRQ +
related): ~14,700 homes incl ~4,300 income-restricted; ~3.8M sf
commercial/CF/light-industrial; IBZ industrial subareas stay nonresidential;
FEIS: significant adverse transportation + mobile-source noise impacts; E-848
requires hazmat investigation/remediation + envelope attenuation.
NYC Industrial Plan (final 2025-12-19; LL 172 of 2023): 5 goals, 20
strategies, 72 ideas per the plan text (the project page says 73 — check the
source); designated industrial areas protect 17,000+ acres;
Primary/Secondary Industrial Areas are policy guideposts, not zoning.
```

Note: the NYC Industrial Plan's own text says "72 ideas" while the city's
project page says "73 recommendations." When sources disagree, the document
wins — and that's worth a minute of class discussion.

### 4. Read OneLIC and the EIS together (12:00–16:00)

```
Based only on the OneLIC and CEQR 25DCP001Q documents you read, identify what
zoning changed in or near the IBZ and summarize the findings for hazardous
materials, transportation, and noise. Distinguish impacts, mitigation, and
E-designation requirements.
```

Key facts to check the agent against: adopted November 12, 2025; ~14,700 homes
including ~4,300 income-restricted; ~3.8M sf commercial/community
facility/light-industrial; the IBZ's industrial subareas stay nonresidential;
E-848 governs hazmat investigation/remediation and building-envelope
attenuation; significant adverse transportation and mobile-source noise
impacts were found.

### 5. Compare citywide and neighborhood policy (16:00–18:30)

```
Using only the OneLIC plan and the NYC Industrial Plan you read, produce a
two-column table: policies that strengthen industrial activity and policies
that may increase conversion or compatibility pressure. The Industrial Plan
has 5 goals, 20 strategies, and 72 ideas and protects 17,000+ acres; OneLIC
was adopted 2025-11-12 with ~14,700 homes. If a number in the documents
disagrees with these, flag it — but don't spend the segment hunting for
discrepancies. Label direct document findings separately from your
interpretation.
```

Check: the Industrial Plan (final December 19, 2025, required by Local Law 172
of 2023) protects 17,000+ acres of designated industrial land — but its
Primary/Secondary Industrial Areas are policy guideposts, **not** zoning.

### 6. Map the IBZ's key properties (18:30–20:00)

**This segment you drive yourself — no agent.** Sometimes the planner's eye on
a map is the tool.

1. Open this link — it loads the IBZ's 1,176 tax lots into the RustGIS web
   app (nothing to install; basemap loads with it):

   **https://web.rustgis.app/?data=https://raw.githubusercontent.com/apanymtechcomm/lic-ibz-lab/main/data/lic_ibz_parcels.geojson**

   (Fallback: download `data/lic_ibz_parcels.geojson` from the lab repo and
   drop the file onto the map.)

2. Open the attribute table, filter to **LandUse 06** (industrial), and sort
   by **BldgArea** descending.
3. Click the top result and find it on the map. Note its **YearBuilt**.
4. Pan to the other big sites — do they cluster?

**The question the map answers:** where are the IBZ's major industrial sites,
and how old are they? (The two largest industrial buildings were built in
**2022 and 2024** — industrial investment in this district is not history.
The third-largest is from **1920** at a built FAR of 4.18 — old stock can be
intense stock.)

**What to notice:** the industrial core's position relative to the blocks
OneLIC upzoned for housing. Edge pressure looks different from above.

**Close the lab with one sentence** — written by you, checked against your
agent's memory entry from segment 3: one mapped fact, one policy fact, and
what they mean for the IBZ together.

---

## Things to push back on (good planner instincts)

- Any claim that a low-FAR or old industrial lot is "vacant" — PLUTO has no
  occupancy data
- Any mix of DEIS and FEIS findings
- Any claim that all FEIS impacts are fully mitigated
- Any intersection/truck counts the documents don't actually state
- Any statement that the Industrial Plan's policy areas are zoning
