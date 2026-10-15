# Distribution & Setup Checklist — LIC IBZ Lab (out-of-the-box edition)

**Environment assumption: students run just-installed Hermes.** No LanceDB, no
embedding stack, no local servers. The instructor's only job is distributing
two files and smoke-testing the models.

---

## 1. What the instructor distributes

| File | Size | What it is |
|---|---|---|
| `lic_ibz_parcels.csv` | 295 KB | MapPLUTO 26v2 (Aug 2026) clipped to the official NYCEDC LIC IBZ boundary. 1,176 lots. SHA-256 recorded in `data/verification_report.json`. |
| `summaries/OneLIC_Summary.md` | 2.6 KB | Pre-assembled summary of the OneLIC rezoning — every fact cited to its source. |
| `summaries/FEIS_25DCP001Q_Summary.md` | 3.9 KB | Pre-assembled summary of the OneLIC EIS (six chapters consolidated). |
| `summaries/NYC_Industrial_Plan_Summary.md` | 2.4 KB | Pre-assembled summary of the NYC Industrial Plan. |
| `data/lic_ibz_parcels.geojson` | 0.8 MB | Same 1,176 lots with geometry — powers the segment-6 RustGIS map via a `?data=` link to this repo's raw file (or drag-drop). |
| `doc-pack.zip` *(optional)* | 143.7 MB | The eight source PDFs. Not required to run the lab — for citation verification and deep-dives. Zip integrity verified. |

**Required distribution is ~9 KB** (CSV + three summaries). Students point
their agent at the summaries directory. **Nothing else is needed** — no
server, no database, no ingestion, no local model stack.

How these were built (for your records, all reproducible):
- Parcel CSV: MapPLUTO 26v2 citywide CSV filtered to Queens, clipped to the
  NYCEDC IBZ shapefile (retrieved via browser — Cloudflare 403s automated
  downloads; checksummed). Cleaning: 121 sub-square-foot slivers excluded at a
  1 sq ft threshold. Repro recipe in `data/README.md`.
- Doc pack: 8 PDFs downloaded from official NYC sources, PDF-validated,
  SHA-256-matched. Sources and inventory in `DRY_RUN_LOG.md`.

## 2. Day-of checks (morning of class, ~5 minutes)

- [ ] **Model smoke test** — one 10-token call to each student model. The free
      catalog churns; a model can disappear overnight (one listed `:free` model
      was found delisted with a 404):
      ```bash
      TOKEN=$(python3 -c "import json; print(json.load(open('/home/abuck/.hermes/auth.json'))['providers']['nous']['agent_key'])")
      for m in poolside/laguna-s-2.1:free upstage/solar-mini4:free; do
        curl -s --max-time 60 https://inference-api.nousresearch.com/v1/chat/completions \
          -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
          -d "{\"model\":\"$m\",\"messages\":[{\"role\":\"user\",\"content\":\"Reply with exactly: OK\"}],\"max_tokens\":10}" \
          | python3 -c "import json,sys; d=json.load(sys.stdin); print('$m ->', (d.get('choices') or [{}])[0].get('message',{}).get('content','ERR'))"
      done
      ```
- [ ] **read_file works on the PDFs** — open one FEIS chapter in the student
      agent (the tool extracts PDF text natively; no extra software needed).
      Verified: `25DCP001Q_FEIS_10_Hazardous Materials.pdf` extracts cleanly.
- [ ] **Mapping segment link** — open
      https://web.rustgis.app/?data=https://raw.githubusercontent.com/apanymtechcomm/lic-ibz-lab/main/data/lic_ibz_parcels.geojson&tiles=https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}
      and confirm the IBZ parcels render on the greyscale basemap (data fetch
      verified 2026-10-14; tile template engine-verified via MCP; if the
      basemap is blank, manual path: Home › Add › Basemap › Add Tile Layer →
      paste
      `https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}`;
      drag-drop fallback = `data/lic_ibz_parcels.geojson`)
- [ ] **Hermes fresh session** with terminal + file + memory toolsets;
      student model pinned in config, not left on the session default
- [ ] **Offline fallback** — everything the lab needs is in the two distributed
      files; if NYC sites are down, the lab still runs end-to-end

## 3. Timing guidance (measured, not estimated)

- **Fallback model (solar-mini4:free):** full reasoning lab completed in 7.5
  minutes *with test-harness overhead* (timing + grading a student never does).
- **Primary model (laguna-s-2.1:free):** segment 5's original open-ended prompt
  overran (5.5 min vs 4-min budget) — use the tightened prompt in
  `STUDENT_PROMPTS.md`.
- **Plan 25–30 minutes for the first run.** 20 minutes is achievable with the
  tightened prompts, but tight. If you must cut: drop segment 5's written table
  (keep the discussion) or move the memory entry to a follow-up assignment.
- Local Ollama models will work but are untested and slower — expect the
  budget to break.

## 4. Instructor-side enrichment (optional, instructor machine only)

On the instructor's machine, the same 8 PDFs are also ingested into a LanceDB
corpus (+3,440 chunks, verified retrieval at distance 0.12–0.24). Students
don't need it; it's for (a) pre-grading every number in the lesson plan and
(b) answering "where does that number come from?" instantly in class.
Search command:

```bash
/mnt/a/lancedb/.venv/bin/python3 /mnt/a/lancedb/ingest.py search \
  --table knowledge --domain planning --collection lic-ibz-lab \
  --query "<query>" --limit 5
```

Describe *content*, not document titles — title-shaped queries miss the
top hit (this is the segment-3 teaching point, verified at rank 2 / 0.41).

## 5. Known constraints (disclose, don't work around)

- IBZ boundary: NYCEDC blocks automated downloads (Cloudflare); the shapefile
  was retrieved via a real browser session and checksummed. No verified
  current NYC Open Data 4×4 IBZ boundary dataset exists (old `pqg4-dm6b` id
  now points elsewhere — don't use it).
- The FEIS is distributed as chapter files; the lab uses six verified FEIS
  chapters, not a monolithic FEIS. Never mix DEIS and FEIS findings.
- Source discrepancy worth teaching: the NYC Industrial Plan's text says "72
  ideas"; the city's project page says "73 recommendations." The document
  wins — cite the page you actually read.
- Free-tier rate limits are unverified — mitigate with short prompts and the
  two-model fallback chain.
- This project is markdown-only in the project OS (not enrolled in the
  ProjectOS/DevOS task databases — enrollment is human-gated).
