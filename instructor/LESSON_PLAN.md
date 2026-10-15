# Working with Hermes for Planners — 20-Minute Laboratory (out-of-the-box edition)
## Long Island City IBZ: parcel data → policy documents → planning judgment

**Audience:** practicing planners; comfortable with chat AI; new to agent-based AI.
**Environment assumption: just-installed Hermes.** No LanceDB, no embedding stack, no local model servers, no pre-built corpus. Everything runs on stock Hermes tools — `terminal`, `read_file`, `memory`, `web_search` — with a Nous Portal free account (or local Ollama models).

---

## What students need

**In the box (nothing to install):**
- Hermes with a Nous Portal free account
- Model: `poolside/laguna-s-2.1:free` (primary) / `upstage/solar-mini4:free` (fallback) — both tested end-to-end on this exact lab (see timing verdict below)
- Python **stdlib only** — the parcel clip is pre-done, so no geopandas/QGIS needed

**Distributed by the instructor (plain files, shared drive or workspace):**
- `lic_ibz_parcels.csv` — 295 KB. MapPLUTO 26v2 (Aug 2026) clipped to the official NYCEDC LIC IBZ boundary. 1,176 lots.
- `summaries/` — three pre-assembled markdown summaries (~9 KB total): `OneLIC_Summary.md`, `FEIS_25DCP001Q_Summary.md`, `NYC_Industrial_Plan_Summary.md`. Every fact cited to its source chapter. These are what students read in segment 3.
- `doc-pack.zip` — **optional deep-dive**, 143.7 MB: the eight source PDFs. Not required to run the lab. Each summary cites its chapters, so any claim can be verified against the original document — a 30-second "check this citation" demo in class is a good habit to build.

That's the entire setup. No server, no database, no ingestion step.

**Model note:** timing below is measured on the Nous free models. Local Ollama models will *work* but are untested here and slower — expect the 20-minute budget to break if the class runs on local models.

**Access variants:** projected (instructor runs the same files; students call prompts) or hands-on (each student's agent reads the same distributed files). Both work identically.

---

## Timed plan (budgets measured on free models, not estimated)

### 0:00–2:00 — Frame the planning question
**Prompt 1:**
> We are evaluating the Long Island City Industrial Business Zone. Separate the task into: existing physical stock, adopted neighborhood policy, environmental constraints, and citywide industrial policy. List the evidence needed for each part.

**Expected:** a four-part research plan; the agent warns that IBZ designation, manufacturing zoning, and PLUTO LandUse are three different variables.
**Teaching point:** the agent decomposes; the planner audits the decomposition.

### 2:00–7:00 — Characterize the stock from the parcel file
**Prompt 2** (give the agent the CSV path):
> Using the pre-clipped 26v2 MapPLUTO table for the Long Island City IBZ, calculate: unique tax lots; lots coded LandUse 06; total LotArea and BldgArea for those lots; median BuiltFAR; median YearBuilt excluding zero or missing values; zoning districts by lot count; and total FactryArea, StrgeArea, and OfficeArea. State all filtering rules.

**Verified answers (the agent should reproduce these):**
- **1,176 unique lots**; **539 coded LandUse 06** (46%)
- **Median BuiltFAR 1.05**; **median year built 1940** (zero/missing excluded)
- LandUse 07 (transportation/utility): **118 lots — analyzed separately, never merged**
- LandUse 05: 149 lots; LandUse 10: 112 lots; **16 lots missing land use**

**Teaching points:**
- LandUse 06 is not the whole industrial economy.
- PLUTO has no occupancy data — never call a low-FAR lot "vacant."
- **Observed in testing:** the model's first pass misread 258 rows as "missing" before self-correcting to 16. If that happens live, narrate it — it is exactly why the prompt demands "state all filtering rules."

### 7:00–12:00 — Ground in the documents, save to memory
**Prompt 3** (give the agent the three summary paths):
> Read these three pre-assembled document summaries: [summaries/OneLIC_Summary.md, summaries/FEIS_25DCP001Q_Summary.md, summaries/NYC_Industrial_Plan_Summary.md]. For the Long Island City IBZ question, extract: (a) OneLIC — adoption date, application numbers, what zoning changed, housing and commercial figures; (b) the FEIS — findings on hazardous materials, transportation, and noise, and the (E) Designation requirements; (c) the NYC Industrial Plan — its goals/strategies/recommendations structure, acreage protected, and what its Primary/Secondary Industrial Areas are. Save the distilled findings to your memory. Memory is limited to roughly 2,200 characters, so you must choose what to keep — state what you kept, what you dropped, and why. Everything must trace to the summaries.

**Expected memory entry (~1,000 chars — the model answer):**
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
strategies, 72 ideas per the plan text (the project page says 73 — a live
example of checking the source); designated industrial areas protect 17,000+
acres; Primary/Secondary Industrial Areas are policy guideposts, not zoning.
Assessment: OneLIC adds housing capacity at the IBZ edge while the industrial
core holds — land-value/compatibility pressure rises at the boundary; the old
stock (1940 median, FAR 1.05) is not automatically redevelopment-ready.
```

**Teaching points (the heart of the lab):**
- The summaries are pre-digested, but memory is still small — **the second distillation is the skill**. The judgment of what survives does not go away just because someone already read the PDFs.
- Each summary cites its source chapter. Optional 30-second demo: have the agent verify one claim against the actual PDF in `doc-pack.zip` — grounding is verifiable, not trusted.
- What doesn't fit in memory stays in the files — the agent can always re-read. Memory is an index of conclusions, not an archive.

### 12:00–16:00 — Read OneLIC and the EIS together
**Prompt 4:**
> Based only on the OneLIC and CEQR 25DCP001Q material you read, identify what zoning changed in or near the IBZ and summarize the findings for hazardous materials, transportation, and noise. Distinguish impacts, mitigation, and E-designation requirements.

**Expected:** adoption 2025-11-12; CEQR 25DCP001Q; Special LIC Mixed-Use District modified/expanded; M1A replacing portions of older M1 (the model found the mapping M1-3/4/5/6 → M1-2A/3A/4A/5A/6A in the text); MIH area; ~14,700 homes incl ~4,300 income-restricted (the plan text carries more precise figures: 14,699 dwelling units, 3,245–4,867 affordable — accept either); ~3.8M sf commercial/CF/light-industrial (text: 3.72M); IBZ industrial subareas stay nonresidential; significant adverse transportation + mobile-source/construction noise (the model correctly noted some noise impacts are "unavoidable" even after mitigation); E-848 = Phase I ESA + remediation before ground disturbance, envelope attenuation.

**Provenance note (tested):** the ULURP application numbers (C 250176 ZMQ, N 250177 ZRQ) are ZAP project metadata — they do **not** appear in the PDFs. Do not require students to cite them; if the agent can't find them, that is correct behavior, and it's a live lesson in "what the documents actually say vs. what the project page says." Instructor may supply them verbally.

### 16:00–18:30 — Compare citywide and neighborhood policy (tightened)
**Prompt 5:**
> Using only the OneLIC plan and the NYC Industrial Plan you read, produce a two-column table: policies that strengthen industrial activity and policies that may increase conversion or compatibility pressure. The Industrial Plan has 5 goals, 20 strategies, and 72 ideas and protects 17,000+ acres; OneLIC was adopted 2025-11-12 with ~14,700 homes. If a number in the documents disagrees with these, flag it — but don't spend the segment hunting for discrepancies. Label direct document findings separately from your interpretation.

**Why worded this way:** the original open-ended version made the model explore (measured 5.5 min on the primary model, over budget). A first fix told it to *verify* the counts in the documents — which caused the same overrun, because verification means extra searches. Giving the counts as stated facts with a light flag-if-you-see-it instruction keeps the segment inside budget without doing the thinking for the model.
**Expected:** the two-column table; 17,000+ acres protected; **Primary/Secondary Industrial Areas stated explicitly as policy guideposts, not zoning**; OneLIC edge housing vs. core holding. (Bonus if flagged: the plan text says "72 ideas" while the city's project page says "73 recommendations.")

### 18:30–20:00 — The finale: the agent drives real GIS software (RustGIS MCP)
**The lab's wow moment.** Everything so far happened in chat; now the agent reaches out and drives an actual GIS application, and the map renders back into the conversation. The chat is the interface; the tools are real — that's the takeaway of the whole lab.

**The prompt (student gives it verbatim):**
> Using the parcel file at `<clone>/data/lic_ibz_parcels.geojson`, set up a RustGIS map of the Long Island City IBZ sites modified by the OneLIC rezoning: filter to the paired zoning districts (ZoneDist1 of M1-4A, M1-5A, or M1-6A — the paired manufacturing/residential districts OneLIC created), add a greyscale Esri basemap, apply a graduated color scheme based on BuiltFAR, and render the map. Then tell me: how many sites, how many are still industrial (LandUse 06), how many predate 1950, and which still-industrial site has the highest BuiltFAR and what year was it built?

**What the agent must chain (the tool sequence):** terminal (filter GeoJSON to M1A districts → rezoned layer) → rustgis `layer.addData` → `map.addTiles` (Esri Light Gray raster) → `layer.symbology` (graduated, BuiltFAR, 5 quantile classes) → `layer.zoomTo` → `view_map` (the map renders as an image in the chat).

**Verified answers (the key):**
- **186 rezoned parcels**: M1-5A = 83, M1-4A = 66, M1-6A = 37
- **103 of 186 still industrial** (LandUse 06) — Industrial Plan retention goal meets OneLIC's upzoning
- **131 of 186 pre-1950** — industrial history → E-848 hazmat consideration (Phase I ESA + remediation before ground disturbance); **77 sites are both**
- **Most intense still-industrial rezoned site: a 1922 building at FAR 5.6** (BBL 4004090001, 112,000 sf); runners-up 1925 @ FAR 5.2, 1930 @ FAR 4.76
- Intensity concentrates along the waterfront edge of the southern cluster (verified in the MCP render)

**Teaching points:**
- The agent drove real GIS software from a chat prompt — MCP tool-chaining is the mechanism, and it's the same pattern for any tool a practice has (CAD, energy models, databases).
- Auditing the agent's TOOL WORK is the same discipline as auditing its text: check the parcel count, the color field, the basemap (CARTO serves watermark tiles — a live "verify the tool output" moment).
- E-848 applies to FEIS development sites, not MapPLUTO records — age/use flags are interpretation. Label which is which.
- The student still writes the closing sentence: one mapped fact + one policy fact + what they mean together. The agent set up the map; the judgment is the planner's.

**Validation status (2026-10-14, laguna-s-2.1:free):** PASSED. A fresh session given the verbatim prompt chained the full sequence with no improvisation — terminal filter (186 sites, cross-checked against the layer's own 186-feature count) → `layer.addData` → `map.addTiles` Esri Light Gray → `layer.symbology` graduated/quantile/BuiltFAR/5 classes → `layer.zoomTo` → `view_map`. All five stats matched the key exactly. **~105 seconds end-to-end** (just over the 90-second segment budget — inside the lab's stated 25–30-minute first-run window; if time is tight, the segment can absorb it). Model render: `instructor/finale_model_map.png`. Manual fallback if the MCP can't be installed or driven: the agent opens the pre-built `?data=` map link (parcels + boundary + greyscale `?tiles=`) in a browser — same map, less wow.


---

## Top failure modes (call these out live)

- Treating LandUse 06 as the complete industrial economy
- Calling low-FAR or old lots vacant without occupancy evidence
- Mixing DEIS and FEIS findings
- Treating OneLIC's projections as observed post-adoption development
- Calling the Industrial Plan's Primary/Secondary Industrial Areas zoning
- Citing a number the documents don't actually state
- Trying to save whole documents into the 2,200-char memory budget

## Timing verdict — measured, not estimated

Both assigned models ran the **full six-segment lab end-to-end; every segment PASSED on both**. Wall-clock numbers below are test-harness totals (each run also timed and graded itself — work a student never does).

- **Fallback model (solar-mini4:free):** 7m33s total. Per-segment all within budget. Data integrity re-verified (CSV SHA-256 matched).
- **Primary model (laguna-s-2.1:free):** 24m22s total, but 94s of segment 5's overtime was the harness hunting the 72-vs-73 discrepancy on its own initiative — a student running the *fixed* prompt won't do that. Real classroom active work ≈ 12 minutes. All per-segment verdicts PASS; zero failure modes triggered on either model.
- **Verdict:** 20 minutes is achievable with the pre-distributed files and the fixed segment-5 prompt, but tight — plan 25–30 for the first run. If you must cut: drop segment 5's written table (keep the discussion) or move the memory entry to a follow-up assignment.
- **One honest gap:** both test runs executed the *LanceDB* version of segment 3, before the summaries redesign. Reading three ~3 KB markdown summaries instead of 146 MB of PDFs removes the reading-cost risk almost entirely; the distillation-to-memory step was tested at 1,021 chars on both models. Segment-3 timing on the new prompt is still untested — expected well inside the 5-minute budget.

## Provenance (appendix slide)

- MapPLUTO 26v2 (data dated August 2026), NYC Planning; clipped to NYCEDC IBZ shapefile; CSV SHA-256 recorded in `data/verification_report.json`
- OneLIC: ZAP project 2024Q0304; CEQR 25DCP001Q; adopted 2025-11-12
- NYC Industrial Plan: final 2025-12-19 (LL 172 of 2023). Note: the plan text says "72 ideas"; the project page says "73 recommendations" — a built-in source-checking lesson
- All stats reproducible: `data/README.md`; dry-run evidence: `DRY_RUN_LOG.md`

## Appendix — the LanceDB version (instructor-side only)

On the instructor's machine, the same eight PDFs were also ingested into a LanceDB corpus (+3,440 chunks, verified retrieval at cosine distance 0.12–0.24) with a keyword-tested search command. **Students do not need any of this.** It exists for two instructor jobs: (1) pre-grading — every number in this plan was verified against the corpus; (2) answering "where does that number come from?" instantly during class. See `DRY_RUN_LOG.md` and `PRE_STAGING_CHECKLIST.md`.
