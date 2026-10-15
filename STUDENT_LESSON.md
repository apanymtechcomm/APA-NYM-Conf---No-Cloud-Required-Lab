# Working with Hermes for Planners — a 20-minute lab
### Long Island City Industrial Business Zone: parcel data → policy documents → planning judgment

**Who this is for:** practicing planners — comfortable with chat AI, new to
agent-based AI.

**What you'll do:** use an AI agent to (1) characterize the existing industrial
stock of the Long Island City IBZ from parcel data, (2) ground a policy
analysis in three planning documents, and (3) produce a defensible
recommendation. Along the way you'll practice the skill that matters most:
**auditing what the agent tells you.**

---

## Setup (once, ~5 minutes)

1. **Install Hermes** — get it at https://hermes-agent.nousresearch.com
   (desktop app or CLI). Skip if you already have it.
2. **Create a Nous Portal free account** — free sign-up at
   https://portal.nousresearch.com, then connect it in Hermes.
3. **Set your model** — in your Hermes session, open the model picker and
   select **`poolside/laguna-s-2.1:free`**. If it's unavailable, use
   **`upstage/solar-mini4:free`**. (Both were tested end-to-end on this exact
   lab. Other free models can be slow or fail on tool-using tasks.)
4. **Get the lesson files** — clone this repo. Keep `summaries/` and
   `data/lic_ibz_parcels.csv` where your agent can read them (your Hermes
   workspace is the natural place).
5. **Verify your agent can read a file** — paste this and check the answer:

   ```
   Read summaries/OneLIC_Summary.md and tell me OneLIC's adoption date in one
   sentence.
   ```

   It should say **November 12, 2025**. If it can't read the file, fix the
   path before starting the clock.

---

## The lab (20 minutes)

### 1. Frame the question (0:00–2:00)

```
We are evaluating the Long Island City Industrial Business Zone. Separate the
task into: existing physical stock, adopted neighborhood policy, environmental
constraints, and citywide industrial policy. List the evidence needed for each
part.
```

**A good answer** separates four evidence streams and warns that IBZ
designation, manufacturing zoning, and PLUTO LandUse are three *different*
variables.

### 2. Characterize the stock (2:00–7:00)

Point your agent at `data/lic_ibz_parcels.csv` (MapPLUTO 26v2, pre-clipped to
the official IBZ boundary):

```
Using the pre-clipped 26v2 MapPLUTO table for the Long Island City IBZ,
calculate: unique tax lots; lots coded LandUse 06; total LotArea and BldgArea
for those lots; median BuiltFAR; median YearBuilt excluding zero or missing
values; zoning districts by lot count; and total FactryArea, StrgeArea, and
OfficeArea. State all filtering rules.
```

**Verified answers** — the agent should reproduce these:
- **1,176 unique lots**; **539 coded LandUse 06** (46%)
- **Median BuiltFAR 1.05**; **median year built 1940** (zero/missing excluded)
- **118 lots are LandUse 07** (transportation/utility) — kept separate;
  16 lots missing land use

**Audit as it works:** does it state its filtering rules? Does it treat
LandUse 06 as the whole industrial economy (wrong — 05, 07, and 10 matter)?
Does it call any low-FAR lot "vacant"? (PLUTO has no occupancy data — that
claim would be unsupported.)

### 3. Read the documents, save what matters (7:00–12:00)

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

**The lesson of this segment:** the summaries are pre-digested, but your
agent's memory is small — **deciding what survives the second distillation is
the skill**. Watch what it keeps, what it drops, and whether every number
traces to a summary. A good distilled entry (~1,000 characters) covers: the
parcel baseline (1,176 lots / 539 industrial / FAR 1.05 / 1940); OneLIC
(adopted 2025-11-12, CEQR 25DCP001Q, ~14,700 homes incl. ~4,300
income-restricted, IBZ subareas stay nonresidential, E-848 controls); and the
Industrial Plan (2025-12-19, 5 goals/20 strategies/72 ideas, 17,000+ acres,
guideposts not zoning).

### 4. Read OneLIC and the EIS together (12:00–16:00)

```
Based only on the OneLIC and CEQR 25DCP001Q documents you read, identify what
zoning changed in or near the IBZ and summarize the findings for hazardous
materials, transportation, and noise. Distinguish impacts, mitigation, and
E-designation requirements.
```

**Key facts to check the agent against:** adopted November 12, 2025;
CEQR 25DCP001Q; Special LIC Mixed-Use District expanded; M1→M1A conversions;
~14,700 homes including ~4,300 income-restricted; ~3.8M sf commercial/
community-facility/light-industrial; the IBZ's industrial subareas stay
nonresidential; E-848 governs hazmat investigation/remediation and
building-envelope attenuation; significant adverse transportation and
mobile-source noise impacts were found (some remain unavoidable even after
mitigation).

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

**Check:** the Industrial Plan (final December 19, 2025, required by Local Law
172 of 2023) protects 17,000+ acres of designated industrial land — but its
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
   paired manufacturing/residential districts OneLIC created — 186 parcels;
   the plain M1-1/3/4 are unchanged).

3. Style the layer: **Style › Symbology → Graduated Colors → field BuiltFAR
   → 5 classes → pick a ramp.** BuiltFAR is development intensity — how much
   building sits on each lot.

4. Now cross-reference the documents you distilled in segment 3. Two flags
   your agent's memory knows:
   - **Still-industrial** (LandUse 06): the NYC Industrial Plan wants these
     retained — yet they now sit in rezoned districts. **186 rezoned sites
     include 103 still in industrial use.**
   - **Pre-1950 vintage**: 131 of the rezoned sites. That's roughly a century
     of industrial history — exactly the exposure pathway the FEIS
     hazardous-materials chapter describes. **E-848 requires a Phase I
     Environmental Site Assessment and remediation before ground
     disturbance.** 77 sites are both pre-1950 *and* still industrial.

5. **The question the map answers:** where do a rezoning's development
   pressure, the citywide Plan's retention goal, and the EIS's hazmat
   constraints land on the same parcel? Find the most intense
   still-industrial site and note its vintage. *(The answer key: a 1922
   building at FAR 5.6 — the most intense industrial building in the
   rezoned set is also a century old. Intensity, retention policy, and
   E-848 all meet on one lot.)*

**Label interpretation as interpretation.** "This 1922 factory is a prime
E-848 candidate" is a planner's inference from age and use — the FEIS
assigns E-848 to development sites, not to MapPLUTO records. Say which is
which. That distinction is the habit the whole lab has been building.

**Close the lab with one sentence** — written by you, checked against your
agent's memory entry: one mapped fact, one policy fact, and what they mean
for the IBZ together.

*Basemap: Esri World Light Gray Canvas — attribution "Esri, HERE, Garmin,
FAO, NOAA, USGS, © OpenStreetMap contributors" (a habit worth noticing:
every basemap you use in practice carries one).*

---

## What to push back on (the audit list)

Good planner instincts — check the agent against these:

- Any claim that a low-FAR or old industrial lot is **"vacant"** — PLUTO has no
  occupancy data
- Any mixing of **DEIS (draft) and FEIS (final)** findings
- Any claim that **all** FEIS impacts are fully mitigated (some noise and
  transportation impacts are unavoidable)
- Any statement that the Industrial Plan's **policy areas are zoning** — they
  are guideposts
- Any intersection or truck count the documents don't actually state
- Any treatment of OneLIC's **projections** as observed post-adoption
  development

One deliberate wrinkle: the NYC Industrial Plan's own text says "72 ideas"
while the city's project page says "73 recommendations." When sources
disagree, the document wins — and it's worth noticing which one you read.

---

## About the numbers

Every number in this lesson was verified against the actual documents and
data, not a project page or a search snippet. The full evidence trail — data
build, document ingestion, and end-to-end test runs on both assigned models —
is in `instructor/` for anyone who wants to check the work.
