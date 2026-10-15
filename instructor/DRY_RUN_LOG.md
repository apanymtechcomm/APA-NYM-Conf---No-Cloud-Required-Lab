# LIC IBZ Lab Policy Documents — Download, Ingestion, and Retrieval Verification

**Run date:** 2026-10-14 (EDT)  
**Local staging:** `/home/abuck/lic-ibz-lab/`  
**Final document directory:** `/mnt/e/OC_Projects/projects/lic-ibz-lab/docs/`  
**LanceDB:** `/mnt/a/lancedb/data`, table `knowledge`  
**Ingestion metadata:** `domain=planning`, `collection=lic-ibz-lab`

## Outcome

All eight requested PDFs—the two final policy plans and six key OneLIC FEIS chapters—were downloaded from verified official sources, validated as PDFs, ingested successfully, and copied to the project directory. LanceDB gained exactly **3,440** records, equal to the sum of the per-file chunk deltas. The final knowledge-table indexes are FTS on `text` and **IVF_FLAT** on `vector`.

## File inventory

All URLs returned HTTP 200 with `Content-Type: application/pdf` before download. “Download date” is the local EDT date. All files passed both `file` and `pdfinfo` validation.

| File | Bytes | Pages | PDF | Source URL | Download date |
|---|---:|---:|---|---|---|
| `OneLIC_Final_Plan_Book.pdf` | 69,189,603 | 74 | 1.7 | https://www.nyc.gov/assets/planning/downloads/pdf/our-work/plans/queens/lic-neighborhood-plan/onelic-final-plan-book.pdf | 2026-10-14 |
| `25DCP001Q_FEIS_00_Executive Summary.pdf` | 6,912,131 | 113 | 1.7 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KJBSRO7TXWCQJHKRSNU6M2VQCWT | 2026-10-14 |
| `25DCP001Q_FEIS_02_Land Use Zoning and Public Policy.pdf` | 8,813,094 | 70 | 1.7 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KLVMYMZYLDU7BCZ7AUYVRF3M4H2 | 2026-10-14 |
| `25DCP001Q_FEIS_10_Hazardous Materials.pdf` | 425,297 | 33 | 1.6 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KMXB7ESRRQ47RHYQ5HJCM5ZIMME | 2026-10-14 |
| `25DCP001Q_FEIS_14_Transportation.pdf` | 6,671,156 | 128 | 1.7 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KL7FCPYHQLRF5DYLQGKA5SKMHIG | 2026-10-14 |
| `25DCP001Q_FEIS_17_Noise.pdf` | 1,176,624 | 23 | 1.7 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KIUPTSEPKJ4WVBK56JELEY4HHK2 | 2026-10-14 |
| `25DCP001Q_FEIS_21_Mitigation.pdf` | 652,467 | 46 | 1.6 | https://zap-api-production.herokuapp.com/document/artifact/01QY2C5KLEIHC6NOUHAJDK6T2QHTML3T6D | 2026-10-14 |
| `NYC_Industrial_Plan_Final.pdf` | 62,837,997 | 159 | 1.7 | https://www.nyc.gov/assets/planning/downloads/pdf/our-work/plans/citywide/nyc-industrial-plan/nyc-industrial-plan-final.pdf | 2026-10-14 |

### Source discovery and validation

- OneLIC ZAP project: https://zap.planning.nyc.gov/projects/2024Q0304
- The ZAP page is client-rendered. Its official API record, `https://zap-api-production.herokuapp.com/projects/2024Q0304`, exposed the FEIS artifact filenames and document identifiers used above.
- The FEIS files are from the `2024Q0304_FEIS_25DCP001Q_1` artifact. No DEIS chapter was substituted.
- The FEIS artifact dates are 2025-08-22/23; the FEIS Notice of Completion date is 2025-08-22.
- OneLIC was adopted 2025-11-12; the downloaded book identifies itself as approved November 2025.
- The final NYC Industrial Plan is dated December 2025; the verified final publication date is 2025-12-19.
- The final project-directory copies match the local downloads byte-for-byte by SHA-256 for all eight files.

## LanceDB ingestion

### Embedding prerequisite

A real request to `http://localhost:8083/v1/embeddings` succeeded before ingestion and returned a 768-dimensional vector from `text-embedding-nomic-embed-text-v1.5`.

### Before

```text
knowledge:     203,919
notes:          32,485
observations:       77
projects:            0
sessions (data): 3,380
sessions corpus: 58,842
```

### Exact ingestion form

Each PDF was copied to `/mnt/e/OC_Projects/knowledge/inbox/` and processed without OCR using:

```bash
/mnt/a/lancedb/.venv/bin/python3 -u /mnt/a/lancedb/pipeline.py \
  --file "/mnt/e/OC_Projects/knowledge/inbox/<filename>.pdf" \
  --domain planning \
  --collection lic-ibz-lab
```

The pipeline moved successfully processed inbox files to `/mnt/d/OC_Projects/knowledge/processed/`. The source metadata retained the original `/mnt/e/OC_Projects/knowledge/inbox/` path.

### Per-file chunk deltas

| File | Before | After | Delta |
|---|---:|---:|---:|
| `OneLIC_Final_Plan_Book.pdf` | 0 | 162 | **+162** |
| `25DCP001Q_FEIS_00_Executive Summary.pdf` | 0 | 738 | **+738** |
| `25DCP001Q_FEIS_02_Land Use Zoning and Public Policy.pdf` | 0 | 450 | **+450** |
| `25DCP001Q_FEIS_10_Hazardous Materials.pdf` | 0 | 156 | **+156** |
| `25DCP001Q_FEIS_14_Transportation.pdf` | 0 | 729 | **+729** |
| `25DCP001Q_FEIS_17_Noise.pdf` | 0 | 146 | **+146** |
| `25DCP001Q_FEIS_21_Mitigation.pdf` | 0 | 303 | **+303** |
| `NYC_Industrial_Plan_Final.pdf` | 0 | 756 | **+756** |
| **Total** | **0** | **3,440** | **+3,440** |

### After

```text
knowledge:     207,359  (+3,440)
notes:          32,485  (unchanged)
observations:       77  (unchanged)
projects:            0  (unchanged)
sessions (data): 3,380  (unchanged)
sessions corpus: 58,842 (unchanged)
```

After ingestion, the knowledge-table FTS index was rebuilt. A general `lancekeeper.py optimize` run temporarily rebuilt the `knowledge`, `notes`, and legacy `sessions` vector indexes as IVF_PQ; all three were corrected immediately to IVF_FLAT. Final verified knowledge indexes:

```text
Index(FTS, columns=["text"], name="text_idx")
Index(IvfFlat, columns=["vector"], name="vector_idx")
```

## Retrieval verification

### Working syntax

Use **both** `--domain planning` and `--collection lic-ibz-lab`. The collection filter prevents other planning documents from competing with this lesson corpus. Hybrid vector+BM25 retrieval is the default.

A generic query such as `"OneLIC Final Environmental Impact Statement"` did **not** retrieve the FEIS in the top five because those exact title words are not present together in the extracted chapter text. Do not use that generic form in the lesson sheet. The three commands below were rerun after the final IVF_FLAT index rebuild and returned the intended document as result 1.

### 1. OneLIC FEIS

```bash
/mnt/a/lancedb/.venv/bin/python3 /mnt/a/lancedb/ingest.py search \
  --table knowledge \
  --query "portions Project Area Long Island City Industrial Business Zone IBZ retain promote industrial activities established 2006" \
  --domain planning \
  --collection lic-ibz-lab \
  --limit 5
```

**Top result:**
- Title: `25DCP001Q_FEIS_00_Executive Summary`
- Source: `25DCP001Q_FEIS_00_Executive Summary.pdf`
- LanceDB date: `2026-10-14` (ingestion date); source FEIS date: `2025-08-22`
- Distance/band: `0.1495` / green
- Excerpt: “Those portions of the Project Area in the Long Island City Industrial Business Zone (IBZ) … IBZs are geographic areas in New York City designated to retain and promote industrial activities. Established in 2006, these zones aim to support New York City’s industrial economy … A key feature of these zones is the commitment not to permit rezoning for residential uses.”

### 2. Adopted OneLIC Final Plan Book

```bash
/mnt/a/lancedb/.venv/bin/python3 /mnt/a/lancedb/ingest.py search \
  --table knowledge \
  --query "OneLIC support growth manufacturing light-industrial businesses creative economy jobs" \
  --domain planning \
  --collection lic-ibz-lab \
  --limit 5
```

**Top result:**
- Title: `OneLIC_Final_Plan_Book`
- Source: `OneLIC_Final_Plan_Book.pdf`
- LanceDB date: `2026-10-14` (ingestion date); adopted: `2025-11-12`
- Distance/band: `0.2420` / green
- Excerpt: “Creative economy jobs are particularly concentrated in the OneLIC study area, where they account for 9% of total jobs. … Support growth of the area’s manufacturing and light-industrial businesses. The Plan applied higher-density mixed-use districts … that allow businesses to expand …”

### 3. Final NYC Industrial Plan

```bash
/mnt/a/lancedb/.venv/bin/python3 /mnt/a/lancedb/ingest.py search \
  --table knowledge \
  --query "NYC Industrial Plan designated industrial areas protect 17000 acres industrial land primary secondary Industrial Business Zones" \
  --domain planning \
  --collection lic-ibz-lab \
  --limit 5
```

**Top result:**
- Title: `NYC_Industrial_Plan_Final`
- Source: `NYC_Industrial_Plan_Final.pdf`
- LanceDB date: `2026-10-14` (ingestion date); final publication: `2025-12-19`
- Distance/band: `0.1193` / green
- Excerpt: “The final Designated Industrial Area maps provide industrial protection for over 17,000 acres of land and create a new citywide geography that is 2,000 acres larger than the Industrial Business Zones. Approximately 1,000 acres were added as Primary or Secondary Industrial Areas …”

## Failures and unverified items

- **Requested documents:** no failures; no requested item remains unverified.
- **Retrieval:** all three final commands returned the intended document as result 1 after index repair.
- **Unrelated maintenance warnings:** `lancekeeper.py optimize` could not build vector indexes for the 77-row `observations` table or empty `projects` table, and emitted repeated small-table k-means warnings for the legacy 3,380-row `sessions` table. These tables were not part of this task and their record counts were unchanged.
- **Pipeline metadata limitation:** file ingestion records the ingestion date rather than the source publication date and leaves the `url` field empty. Official source dates and URLs are preserved in this log.
mapping-segment composite verified via MCP render: parcels + IBZ boundary + Esri Light Gray; segment 6 conflict-map key: 186 rezoned / 103 industrial / 131 pre-1950 / 77 both; key finding = 1922 building FAR 5.6 (BBL 4004090001).
segment-6 finale flipped to agent-driven (Andrew's wow-factor request): one student prompt, agent chains terminal + rustgis MCP (layer.addData → map.addTiles Esri Light Gray → layer.symbology graduated BuiltFAR → view_map), map renders in chat. rustgis-mcp MCP is the tool-link; scripts/setup-rustgis-mcp.sh installs it one-command (v0.2.0, linux/macos/windows paths). laguna validation run dispatched 2026-10-14 (deleg_ac3dd013); results to be folded in when it lands. Browser ?data= link kept as fallback. Key: 186 rezoned (M1-5A=83, M1-4A=66, M1-6A=37) / 103 industrial / 131 pre-1950 / 77 both / key site = 1922 building FAR 5.6 BBL 4004090001.
