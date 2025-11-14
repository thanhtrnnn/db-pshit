# DB Practice Scraper & SQL Solution Generator

A Python project that scrapes SQL practice problems from web sources and automatically generates solutions using **Google AI Studio (Gemini API)**, organized by taxonomy classification.

## Overview

This repository manages a collection of SQL practice problems with two-stage AI-assisted solutions:

1. **SQL Generation** – Gemini generates complete SQL statements from problem HTML (with vision support for images)
2. **Taxonomy Classification** – A second Gemini instance reviews the generated SQL and assigns it to one of 10 canonical technique categories

Solutions are automatically organized into taxonomy folders (e.g., `02_aggregation/`, `04_pivoting/`) and indexed in `solutions/index.md`.

## Project Structure

```
.
├── problems/                      # Scraped problem HTML files (SQL*.html)
├── solutions/                     # Generated SQL solutions, organized by taxonomy
│   ├── 01_modification/          # DML/DDL operations (INSERT, UPDATE, DELETE, etc.)
│   ├── 02_aggregation/           # GROUP BY, COUNT, SUM, AVG, etc.
│   ├── 03_window_functions/      # ROW_NUMBER, RANK, LAG, LEAD, etc.
│   ├── 04_pivoting/              # PIVOT, CASE aggregations, transpose logic
│   ├── 05_set_operations/        # UNION, INTERSECT, EXCEPT
│   ├── 06_relational_division/   # NOT EXISTS, ALL / EVERY patterns
│   ├── 07_complex_join/          # Complex range joins, correlated subqueries
│   ├── 08_filtering/             # Date/time operations, string functions
│   ├── 09_retrieval/             # Basic SELECT, JOINs, simple filtering
│   ├── 10_complex/               # Multi-technique solutions
│   └── index.md                  # Problem → Section → File mapping
├── scripts/
│   ├── generate_sql_solutions.py # (Alternative batch generator)
│   └── update_index_taxonomy.py  # Harmonize index with actual file locations
├── docs/
│   ├── google-ai-studio-setup.md # Google AI integration guide
│   ├── evaluation.md             # Taxonomy classification guidelines
│   └── sql_recipes.md            # Common SQL patterns
├── ai_client.py                  # Gemini API client (SQL + taxonomy)
├── generate_sql_batch.py         # Main batch generation script
├── requirements.txt              # Python dependencies
├── .env.example                  # Environment variable template
├── ignore.txt                    # Problem IDs to skip during generation
└── README.md                     # This file
```

## Quick Start

### 1. Install Dependencies

```powershell
# Create virtual environment
python -m venv .venv

# Activate it (Windows PowerShell)
.\.venv\Scripts\Activate.ps1

# If activation is blocked, run as Administrator once:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install packages
pip install -r requirements.txt
```

### 2. Configure Google AI API Keys

Create a `.env` file from `.env.example`:

```env
# Primary key for SQL generation
GOOGLE_SQL_API_KEY=your_sql_generation_key

# Dedicated key for taxonomy classification (optional; falls back to SQL key)
GOOGLE_TAXONOMY_API_KEY=your_taxonomy_key

# Optional: Override model names (default: gemini-2.5-flash)
# GOOGLE_SQL_MODEL=gemini-2.5-pro
# GOOGLE_TAXONOMY_MODEL=gemini-2.5-flash
```

Get your API keys from [Google AI Studio](https://aistudio.google.com/app/apikey).

### 3. Generate Solutions

Generate up to 30 solutions and update the index:

```powershell
python generate_sql_batch.py --limit 30 --replace-index
```

Flags:
- `--limit N` – Process up to N problems (default: 5)
- `--force` – Regenerate even if index entry exists
- `--replace-index` – Replace existing index rows instead of appending duplicates
- `--dry-run` – Test pipeline without calling external API (writes placeholders)

### 4. Verify & Index

Harmonize the index with actual file locations:

```powershell
python scripts/update_index_taxonomy.py
```

This script ensures `solutions/index.md` accurately reflects where SQL files actually reside.

## How It Works

### Workflow

1. **Scrape Problems** – HTML files in `problems/` contain problem statements and optional images
2. **Generate SQL** – `ai_client.generate_sql_solution(html, problem_id, hint)` calls Gemini with:
   - Problem HTML (with vision for images)
   - Evaluation guidelines from `docs/evaluation.md`
   - Returns: `{sql: str, reasoning: str}`
3. **Classify Taxonomy** – `ai_client.classify_taxonomy(sql, problem_id)` reads the SQL and returns a canonical label
4. **Write Solution** – SQL file is placed in the correct folder (e.g., `solutions/02_aggregation/SQL1234.sql`)
5. **Update Index** – Entry added to `solutions/index.md` with problem → section → file mapping

### Taxonomy Labels

The 10 canonical taxonomy sections:

| Label | Folder | Technique |
|-------|--------|-----------|
| `modification` | `01_modification` | INSERT, UPDATE, DELETE, MERGE, DDL |
| `aggregation` | `02_aggregation` | GROUP BY, COUNT, SUM, AVG, MIN, MAX |
| `window_functions` | `03_window_functions` | ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, OVER() |
| `pivoting` | `04_pivoting` | PIVOT, conditional aggregation, CASE in SELECT |
| `set_operations` | `05_set_operations` | UNION, INTERSECT, EXCEPT |
| `relational_division` | `06_relational_division` | NOT EXISTS with ALL, EVERY patterns |
| `complex_join` | `07_complex_join` | Range joins, complex ON conditions |
| `filtering` | `08_filtering` | Date/time functions, string functions, LIKE, BETWEEN |
| `retrieval` | `09_retrieval` | Basic SELECT, simple JOINs, WHERE |
| `complex` | `10_complex` | Multi-technique solutions |

## Key Files

### `ai_client.py`

Core Gemini integration supporting dual instances:

```python
from ai_client import generate_sql_solution, classify_taxonomy

# Generate SQL + get taxonomy in one call
result = generate_sql_solution(problem_html, "SQL1234", taxonomy_hint="aggregation")
print(result["sql"])          # Generated SQL
print(result["reasoning"])    # Model reasoning
print(result["taxonomy_section"])  # Canonical taxonomy label
```

### `generate_sql_batch.py`

Main entry point for batch generation:

```bash
python generate_sql_batch.py --limit 30 --replace-index
```

Handles:
- Loading HTML from `problems/`
- Generating SQL via Gemini
- Writing solutions to taxonomy folders
- Updating `solutions/index.md`
- Skipping problems in `ignore.txt`

### `scripts/update_index_taxonomy.py`

Harmonizes `index.md` when files have moved:

```bash
python scripts/update_index_taxonomy.py
```

Reads folder structure, resolves file paths, and updates the index with correct taxonomy labels.

## API Rate Limits

The batch script includes a **6-second cooldown** between API calls to respect rate limits. For large batches, you may need to:

- Split into smaller runs: `--limit 10` multiple times
- Increase cooldown in `generate_sql_batch.py` (line ~256)
- Use different API keys for SQL and taxonomy to parallelize

## Troubleshooting

### Error: `GOOGLE_SQL_API_KEY not set`

Create `.env` with your API keys:

```bash
cp .env.example .env
# Edit .env and paste your keys
```

### Error: `google-generativeai not installed`

Activate virtual environment and run:

```powershell
pip install -r requirements.txt
```

### Dry Run (Testing Without API)

Test the full pipeline without spending API quota:

```bash
python generate_sql_batch.py --limit 3 --dry-run
```

This writes placeholder SQL to verify folder routing and index updates work correctly.

### Index Out of Sync

If SQL files are moved or deleted, resync the index:

```bash
python scripts/update_index_taxonomy.py
```

## SQL Standards

All generated SQL follows these conventions:

1. **Header Comments**: First two lines document tables and technique
   ```sql
   -- Tables: users, orders, products
   -- Technique: aggregation
   ```

2. **Dialect**: SQL Server by default (MySQL for set operations where needed)

3. **Fencing**: All SQL in response wrapped in ` ```sql\n...\n``` `

4. **Termination**: Queries end with `;`

5. **Column Names**: Match exact sample output (case-sensitive)

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for workflow guidelines on:
- Running the generator locally
- Reviewing generated solutions
- Adding or modifying problems
- Improving taxonomy classification

## Environment Variables

| Variable | Required | Default | Notes |
|----------|----------|---------|-------|
| `GOOGLE_SQL_API_KEY` | ✓ | — | Primary Gemini API key for SQL generation (falls back to `GOOGLE_API_KEY`) |
| `GOOGLE_TAXONOMY_API_KEY` | ✗ | `GOOGLE_SQL_API_KEY` | Dedicated key for taxonomy classification |
| `GOOGLE_SQL_MODEL` | ✗ | `gemini-2.5-flash` | Override SQL generation model |
| `GOOGLE_TAXONOMY_MODEL` | ✗ | `GOOGLE_SQL_MODEL` | Override taxonomy classification model |
| `GOOGLE_API_KEY` | ✗ | — | Legacy fallback for `GOOGLE_SQL_API_KEY` |

## License

Private repository. All rights reserved.

## References

- [Google AI Studio](https://aistudio.google.com)
- [google-generativeai Python SDK](https://github.com/google/generative-ai-python)
- [SQL Taxonomy & Classification Guide](./docs/evaluation.md)
