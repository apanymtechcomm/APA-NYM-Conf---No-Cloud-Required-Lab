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

### 6. Map the conflict: rezoning intensity × industrial retention × E-848 (18:30–20:00)

**This segment you drive yourself — no agent.** Sometimes the planner's eye on
a map is the tool.

1. Open this link — it loads the IBZ's 1,176 tax lots, the official IBZ
   boundary, and a greyscale basemap into the RustGIS web app (nothing to
   install):

   **https://web.rustgis.app/?data=https://raw.githubusercontent.com/apanymtechcomm/lic-ibz-lab/main/data/lic_ibz_parcels.geojson&data=https://raw.githubusercontent.com/apanymtechcomm/lic-ibz-lab/main/data/ibz_boundary.geojson&tiles=https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}**

2. Find the sites the rezoning modified: in the attribute table, filter to
   the **paired districts M1-4A, M1-5A, M1-6A** (the "A" suffix marks the
   paired districts OneLIC created — 186 parcels; the plain M1-1/3/4 are
   unchanged).

3. Style the layer: **Style › Symbology → Graduated Colors → field BuiltFAR
   → 5 classes → pick a ramp.** BuiltFAR is development intensity.

4. Cross-reference the documents distilled in segment 3:
   - **Still-industrial (LandUse 06):** the NYC Industrial Plan wants these
     retained — yet they now sit in rezoned districts (**103 of 186**).
   - **Pre-1950 vintage (131 of 186):** a century of industrial history —
     the exposure pathway the FEIS hazmat chapter describes; **E-848**
     requires a Phase I ESA and remediation before ground disturbance.
     **77 sites are both.**

5. **The question the map answers:** where do development pressure, the
   Plan's retention goal, and the EIS's hazmat constraints land on the same
   parcel? The key: the most intense still-industrial rezoned site is a
   **1922 building at FAR 5.6** — intensity, retention policy, and E-848
   all meet on one lot.

**Label interpretation as interpretation** — "this 1922 factory is a prime
E-848 candidate" is a planner's inference from age and use; the FEIS assigns
E-848 to development sites, not MapPLUTO records.

**Close the lab with one sentence** — written by you, checked against your
agent's memory entry: one mapped fact, one policy fact, and what they mean
for the IBZ together.

---

## Things to push back on (good planner instincts)

- Any claim that a low-FAR or old industrial lot is "vacant" — PLUTO has no
  occupancy data
- Any mix of DEIS and FEIS findings
- Any claim that all FEIS impacts are fully mitigated
- Any intersection/truck counts the documents don't actually state
- Any statement that the Industrial Plan's policy areas are zoning
