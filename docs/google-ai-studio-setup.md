# Google AI Studio (Gemini) integration

This repo can now generate exact SQL solutions from problem HTML by calling Google AI Studio (Gemini API).

## 1) Get an API key
- Open: https://aistudio.google.com/app/apikey
- Create an API key and copy it

## 2) Configure environment
- Copy `.env.example` to `.env` and paste your key:

```env
GOOGLE_API_KEY=your_api_key_here
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
- Default model is `gemini-1.5-flash` (fast, cost‑effective). Switch to `gemini-1.5-pro` in `ai_client.py` for better reasoning if needed.
- The prompt enforces project rules: exact column names/order, SQL Server default dialect with MySQL fallbacks for set ops, and taxonomy classification.
- The batch script won’t overwrite existing entries unless `--force` is used.

## Troubleshooting
- `google-generativeai` not found: ensure virtual env is active and `pip install -r requirements.txt` ran successfully.
- `GOOGLE_API_KEY not set`: create `.env` in repo root with your key, or set the env var directly in your shell.
- Long HTML: Gemini 1.5 supports large context; if a file is extremely large, you may raise the `--limit` gradually and run in batches.
