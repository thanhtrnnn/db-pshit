# Google AI Studio (Gemini) integration

This repo can now generate exact SQL solutions from problem HTML by calling Google AI Studio (Gemini API).

## 1) Get an API key
- Open: https://aistudio.google.com/app/apikey
- Create an API key and copy it

## 2) Configure environment
- Copy `.env.example` to `.env` and paste your keys:

```env
# SQL generation model key (falls back to GOOGLE_API_KEY when unset)
GOOGLE_SQL_API_KEY=your_sql_generation_key

# Taxonomy classifier key (defaults to GOOGLE_SQL_API_KEY when unset)
GOOGLE_TAXONOMY_API_KEY=your_taxonomy_key

# Optional legacy fallback for other tools
# GOOGLE_API_KEY=your_sql_generation_key
```

## 3) Install dependencies (Windows PowerShell)

```powershell
python -m venv .venv; .\.venv\Scripts\Activate.ps1; pip install -r requirements.txt
```

If activation is blocked, run PowerShell as Administrator once:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## 4) Run the generator

Generate up to 3 solutions from `problems/` and update `solutions/index.md` automatically:

```powershell
python generate_sql_batch.py --limit 3
```

Flags:
- `--force` to regenerate even if an index entry already exists.

Outputs:
- SQL files are written under `solutions/<section>/SQL#### - <title>.sql`
- `solutions/index.md` is appended with the problem → section → file mapping.

## Notes
- Default SQL model is `gemini-2.5-flash` (fast, cost‑effective). Override via `GOOGLE_SQL_MODEL` or `GOOGLE_TAXONOMY_MODEL` in `.env` when you need different tiers.
- The SQL generator and taxonomy classifier now use isolated Gemini instances/keys. If you only have one key, leave `GOOGLE_TAXONOMY_API_KEY` empty and it will fall back to `GOOGLE_SQL_API_KEY`.
- The prompt enforces project rules: exact column names/order, SQL Server default dialect with MySQL fallbacks for set ops, and taxonomy classification.
- Taxonomy classification now consumes the freshly generated SQL (plus reasoning) to determine the final folder, so ensure SQL output looks close to the expected final answer before running batch jobs.
- The batch script won’t overwrite existing entries unless `--force` is used.

## Troubleshooting
- `google-generativeai` not found: ensure virtual env is active and `pip install -r requirements.txt` ran successfully.
- `GOOGLE_SQL_API_KEY not set`: create `.env` in repo root with your key, or set the env var directly in your shell.
- Long HTML: Gemini 1.5+ supports large context; if a file is extremely large, you may raise the `--limit` gradually and run in batches.
