# Contributing to DB Practice Scraper

Thank you for contributing! This guide explains the workflow for generating, reviewing, and improving SQL solutions.

## Workflow Overview

### Phase 1: Generate Solutions

1. **Prepare Problems**
   - Ensure HTML files are in `problems/` as `SQL*.html`
   - Each file contains a problem statement (and optionally images)

2. **Configure API Keys**
   - Set `GOOGLE_SQL_API_KEY` and optionally `GOOGLE_TAXONOMY_API_KEY` in `.env`
   - See [Setup Guide](./docs/google-ai-studio-setup.md) for details

3. **Run Batch Generation**
   ```powershell
   python generate_sql_batch.py --limit 30 --replace-index
   ```
   - Generates SQL for up to 30 new problems
   - `--replace-index` ensures no duplicate entries
   - Solutions are written to `solutions/<taxonomy>/` folders
   - Problems are added to `ignore.txt` to skip future runs

4. **Verify Output**
   ```powershell
   # Sync index with actual file locations
   python scripts/update_index_taxonomy.py
   
   # Check git status
   git status
   ```

### Phase 2: Review & Validate

1. **Manual SQL Review**
   - Open recently generated files in `solutions/*/`
   - Verify SQL correctness against sample output in problem HTML
   - Look for common issues:
     - Column name/order mismatches
     - Missing JOINs or WHERE conditions
     - Incorrect aggregation logic

2. **Check Taxonomy Classification**
   - Open `solutions/index.md` and spot-check a few entries
   - Ensure folder paths match the taxonomy label (e.g., SQL in `02_aggregation/` should be marked `aggregation`)
   - If a file is in the wrong folder, move it and re-run `update_index_taxonomy.py`

3. **Test Dry-Run (Before API Calls)**
   ```powershell
   # Test pipeline without consuming API quota
   python generate_sql_batch.py --limit 5 --dry-run
   ```
   - Writes placeholder SQL to test folder routing
   - Useful for validating changes without cost

### Phase 3: Improve & Iterate

#### Fixing Bad Solutions

If a generated SQL is incorrect:

1. **Manually Correct It**
   - Edit the `.sql` file in place
   - Preserve header comments and formatting

2. **Mark for Regeneration**
   - Remove the problem ID from `ignore.txt`
   - Re-run batch: `python generate_sql_batch.py --limit 1 --force`
   - Use `--replace-index` if you want to overwrite the old entry

#### Adjusting Taxonomy Classification

If a solution is in the wrong folder:

1. **Move the File**
   ```powershell
   # E.g., SQL1234.sql should be in 02_aggregation/, not 09_retrieval/
   mv solutions/09_retrieval/SQL1234.sql solutions/02_aggregation/SQL1234.sql
   ```

2. **Resync the Index**
   ```powershell
   python scripts/update_index_taxonomy.py
   ```

#### Improving Prompts

To improve SQL quality or taxonomy accuracy:

1. **Edit `ai_client.py`**
   - Modify `_SQL_SYSTEM_PROMPT` to refine SQL generation behavior
   - Modify `_TAXONOMY_SYSTEM_PROMPT` to improve classification logic

2. **Review Evaluation Guidelines**
   - See `docs/evaluation.md` for taxonomy decision tree
   - Update if a pattern is consistently misclassified

3. **Test Changes**
   ```powershell
   python generate_sql_batch.py --limit 3 --force --dry-run
   ```

4. **Commit & Roll Out**
   ```powershell
   git add ai_client.py docs/evaluation.md
   git commit -m "Improve SQL generation prompt for [specific issue]"
   python generate_sql_batch.py --limit 50  # Full batch with new prompt
   ```

## Directory Structure & File Roles

```
├── ai_client.py                      # ← Edit to adjust prompts/models
├── generate_sql_batch.py             # ← Main entry point (usually no edits needed)
├── ignore.txt                        # ← Auto-populated; remove IDs to regenerate
├── solutions/index.md                # ← Auto-generated; don't edit manually
├── scripts/
│   └── update_index_taxonomy.py      # ← Run after moving files
├── docs/
│   ├── evaluation.md                 # ← Taxonomy decision rules
│   ├── google-ai-studio-setup.md     # ← Setup instructions
│   └── sql_recipes.md                # ← Common SQL patterns (reference)
└── solutions/
    ├── 01_modification/              # DML/DDL
    ├── 02_aggregation/               # GROUP BY patterns
   ├── 03_grouping_having/           # GROUP BY + HAVING, top-N per nhóm (có thể dùng window)
    ├── 04_pivoting/                  # PIVOT / conditional aggregation
    ├── 05_set_operations/            # UNION / INTERSECT / EXCEPT
    ├── 06_relational_division/       # NOT EXISTS + ALL
    ├── 07_complex_join/              # Range joins
    ├── 08_filtering/                 # Date/string functions
    ├── 09_retrieval/                 # Basic SELECT + JOIN
    └── 10_complex/                   # Multi-technique
```

## Common Tasks

### Task: Generate N New Solutions

```powershell
python generate_sql_batch.py --limit 50 --replace-index
```

**What happens:**
1. Reads HTML files from `problems/` not already in `ignore.txt`
2. Generates SQL using Gemini (SQL instance)
3. Classifies taxonomy using Gemini (taxonomy instance)
4. Writes solution files to correct folder
5. Appends `ignore.txt` with processed problem IDs
6. Updates `solutions/index.md` (replaces old entries if any)

### Task: Re-Generate a Specific Problem

```powershell
# Remove from ignore list
(Get-Content ignore.txt) -notmatch "SQL1234" | Set-Content ignore.txt

# Regenerate with --force
python generate_sql_batch.py --limit 1 --force
```

### Task: Fix Stale Index Paths

If you've manually moved SQL files or deleted some:

```powershell
python scripts/update_index_taxonomy.py
```

This rescans the file system and corrects `solutions/index.md`.

### Task: Test a Prompt Change

Before running a full batch:

```powershell
# 1. Make your change to ai_client.py
# 2. Test on 3 problems without overwriting ignore.txt
python generate_sql_batch.py --limit 3 --dry-run

# 3. Review output in temporary locations
# 4. If good, commit and run full batch
python generate_sql_batch.py --limit 100 --replace-index
```

## Tips & Best Practices

### API Efficiency

- **Dual Keys**: Use separate `GOOGLE_SQL_API_KEY` and `GOOGLE_TAXONOMY_API_KEY` to parallelize (future enhancement)
- **Model Tiers**: For better quality, temporarily upgrade to `gemini-2.5-pro` via `.env`:
  ```env
  GOOGLE_SQL_MODEL=gemini-2.5-pro
  ```
- **Rate Limiting**: 6-second cooldown between requests; increase if hitting quotas

### SQL Quality

- All generated SQL includes header comments with tables and technique
- Verify sample output columns match exactly (case-sensitive)
- Check for correct ORDER BY clauses when sorting is implied
- Test against actual databases if possible

### Taxonomy Classification

- Consult `docs/evaluation.md` for decision tree
- A solution using multiple techniques should go to `10_complex` if it's not clearly dominated by one pattern
- If consistently misclassified, update the prompt in `ai_client.py` and re-run

### Git Workflow

```powershell
# Before running batch
git status
git branch -b "add-solutions"

# Run batch
python generate_sql_batch.py --limit 50 --replace-index

# Review changes
git diff solutions/index.md | head -50
git status solutions/

# Commit
git add solutions/ ignore.txt solutions/index.md
git commit -m "Add 50 auto-generated SQL solutions via Gemini"

# Push
git push origin "add-solutions"
# Create PR for review
```

## Troubleshooting

### Problem: "GOOGLE_SQL_API_KEY not set"

**Solution**: Create `.env` and add your key:
```bash
cp .env.example .env
# Edit .env with your actual key
```

### Problem: Solutions in Wrong Folder

**Solution**: Move them and resync:
```powershell
mv solutions/09_retrieval/SQL1234.sql solutions/02_aggregation/
python scripts/update_index_taxonomy.py
```

### Problem: Index Has Duplicates

**Solution**: Use `--replace-index` flag:
```powershell
python generate_sql_batch.py --limit 10 --replace-index
```

### Problem: Generate Command Fails Silently

**Solution**: Check for Python errors:
```powershell
python generate_sql_batch.py --limit 1 --replace-index 2>&1 | Tee-Object -FilePath debug.log
```

### Problem: Want to Test Without API Cost

**Solution**: Use `--dry-run`:
```powershell
python generate_sql_batch.py --limit 10 --dry-run
```

Writes placeholder SQL to verify paths and index updates work.

## Questions?

- Review `README.md` for project overview
- Check `docs/evaluation.md` for taxonomy rules
- See `docs/google-ai-studio-setup.md` for API setup
- Inspect `ai_client.py` for prompt logic

---

**Remember**: Always commit incrementally, test on small batches first, and review taxonomy classification before running large generations.
