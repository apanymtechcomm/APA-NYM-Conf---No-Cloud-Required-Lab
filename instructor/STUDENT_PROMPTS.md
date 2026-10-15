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

### 6. The finale: the agent drives real GIS software (18:30–20:00)

**The point of this segment:** everything so far happened in chat. Now your
agent reaches out and drives an actual GIS application — RustGIS — and the
map comes back into your conversation. This is what agent-based AI means for
planning work: the chat is the interface, but the tools are real.

**One-time setup (skip if done in step 5 of Setup):** run
`scripts/setup-rustgis-mcp.sh` from this repo — it installs the RustGIS MCP
server and wires it into Hermes (~30 MB, one minute; Windows instructions
print from the script). Then type `/reload-mcp` in your session.

**The prompt — one prompt, and watch it work:**

```
Using the parcel file at <your clone path>/data/lic_ibz_parcels.geojson, set
up a RustGIS map of the sites the OneLIC rezoning actually changed. The
rezoning replaced zoning permission: max commercial/manufacturing FAR is now
5.0 in M1-4A, 6.5 in M1-5A, and 8.0 in M1-6A (FEIS, land-use chapter,
pp. 56-58). Compute each rezoned parcel's unused development permission —
the cap minus its BuiltFAR — filter to the paired districts (ZoneDist1
M1-4A, M1-5A, M1-6A), add a greyscale Esri basemap, apply a graduated color
scheme on that headroom, and render the map. Then tell me: total unused
permission in square feet, how it compares to the building stock that exists
today, how many parcels, and which single parcels carry the most new
permission.
```

**What you should see:** the agent chains real tools — it filters the data,
opens RustGIS, loads the parcels, applies the graduated symbology, and
renders the map back into the chat.

**Audit what it produces** — the lab's whole discipline, now pointed at a
tool:
- Does the map show the **186 rezoned parcels** only, colored by intensity?
- Do its numbers match the key: **186 sites, 103 still industrial, 131
  pre-1950, and the 1922 building at FAR 5.6**?
- Is the basemap actually greyscale? (CARTO now serves "API KEY REQUIRED"
  watermark tiles — if you see that, the agent substituted a dead basemap.)
- Where does intensity concentrate — and does that match the policy story
  from segment 5?
- Does the map **explain itself**? (A graduated ramp needs a legend saying
  what the colors mean and what BuiltFAR is — if the agent skipped one, that's
  a cartographic miss worth asking it to fix.)

**The synthesis question (and your closing sentence):** where do
development pressure, the Industrial Plan's retention goal, and the EIS's
E-848 hazmat consideration land on the same parcel? Write one sentence: one
mapped fact, one policy fact, what they mean together. The agent set up the
map; the judgment is still yours.

*Fallback if the MCP won't install or the model can't drive it:* the agent
opens the pre-built map link in a browser — `?data=` parcels + boundary +
`?tiles=` greyscale — and walks you through it. Same map, less wow.*

---

## Things to push back on (good planner instincts)

- Any claim that a low-FAR or old industrial lot is "vacant" — PLUTO has no
  occupancy data
- Any mix of DEIS and FEIS findings
- Any claim that all FEIS impacts are fully mitigated
- Any intersection/truck counts the documents don't actually state
- Any statement that the Industrial Plan's policy areas are zoning
