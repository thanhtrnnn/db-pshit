# Copilot Instructions for dbpshit-scraper

This repo builds a searchable library of exact SQL answers for PTIT DB problems while providing a Python scraper to pull authoritative problem content. Follow these rules to stay productive and consistent.

## Big picture
- Source of truth: problems come from PTIT APIs. We store lightweight problem stubs in `problems/` and write final SQL in `solutions/` by technique (taxonomy). The scraper (`main.py`) can fetch full HTML/JSON into `output/` for reference.
- Goal: each solution must reproduce columns, aliases, and sort order exactly as shown under “Output mẫu/Output ví dụ” in the problem content.

## Key directories and conventions
- `problems/SQL#### - <title>.html`: Stub with IDs and API links; sometimes includes schema/IO samples.
- `solutions/<section>/SQL#### - <title>.sql`: One problem per file; Vietnamese names retained when present. Sections are the taxonomy (see docs).
- `docs/evaluation.md`: Authoritative taxonomy and reclassification rules; use this to decide the correct section.
- `solutions/index.md`: Path map used by tooling; keep in sync when moving solutions.

## AI workflow to add/update a solution
1. Locate the HTML problem file in `problems/`. Read full schema (text or base64 image) and the “Output mẫu”.
2. Infer the SQL dialect (default SQL Server unless the problem states otherwise). Match case/aliases exactly; mirror the output order. If using non-SQL Server constructs (INTERSECT/EXCEPT), include a SQL Server alternative in comments. Note: delete the skeleton code snippets from the problem content before finalizing.
3. Place the solution under the primary technique folder from `docs/evaluation.md` (e.g., counting_grouping, joins_set, topn_window, dml). If the dominant technique changes, physically move the file to correct folder, delete old sql file and immediately update `solutions/index.md`.
4. Add brief header comments in the `.sql` summarizing tables/columns used and any dialect notes. Prefer clear joins and conditional aggregation over guessy shortcuts.
5. Verify: compare your projection names, row order, and filters to the sample output. When a sample shows two rows from two tables (e.g., two COUNT lines), use `UNION ALL` to preserve row order.

## Python scraper (optional but helpful)
- File: `main.py`. Requires a local `cookies.json` exported from your browser (must include an `access_token`). The script builds both `Authorization: Bearer <token>` and a `Cookie` header.
- Configure constants at top if needed (API base URLs, `TOTAL_PROBLEMS_TO_FETCH`). Output is written to `output/SQL#### - <title>.txt` with the raw HTML content block.
- Headers are sanitized for Latin‑1; see `_sanitize_http_header_value`. Respect the built-in `time.sleep(0.3)` and do not remove throttling.

## SQL patterns seen across problems
- Vietnamese schemas are common: NHACUNGCAP, MATHANG, LOAIHANG, NHANVIEN, KHACHHANG, DONDATHANG, CHITIETDATHANG… Use those names verbatim.
- SQL Server is the default dialect: use `TOP`, `GETDATE()`, `ISNULL()`, `DATEADD()`, `DATEDIFF()`, `CONVERT()`, `CAST() AS FLOAT` etc.
- Percentages: guard divides with `NULLIF` and round to the precision shown (e.g., `ROUND(..., 2)`).

## Quality and taxonomy
- Quality gates: ensure the final columns match labels from the sample output image/text and that ordering is explicit (`ORDER BY`).
- TRY TO COME UP WITH SOLUTIONS THAT ARE EFFICIENT, TIME OPTIMIZED AND READABLE. Follow best practices for the identified technique (e.g., avoid unnecessary subqueries, use JOINs appropriately, etc.).
- Taxonomy precedence (short): DML/DDL > Window/Sequences > Pivot/Conditional > Counting/Grouping > Joins/Set > Subqueries/CTE > Strings/Regex > Math/Numbers. See `docs/evaluation.md` for edge cases and examples.

## Examples from this repo
- Top‑N per manufacturer (SQL1617): window `ROW_NUMBER()` to pick the latest satellite per manufacturer; file in `04_topn_window/`.
- Both statuses intersection (SQL1627): use `INTERSECT` or MySQL `HAVING COUNT(DISTINCT login_status)=2` fallback; file in `08_set_difference/`.
- Two table counts as two rows (SQL1621/SQL1633/SQL1644): `UNION ALL` of `COUNT(*)` to preserve row order and headings.

## Pitfalls
- Don’t guess column names, schema or anything else other than the problem statement—pull them from the problem content/API. Vietnamese titles often imply Vietnamese column names.
- Keep file names exactly `SQL#### - <title>.sql`; avoid renaming problems or changing IDs.
- Update `solutions/index.md` immediately after moving files to avoid confusion.

---
If anything here is unclear (e.g., preferred dialect for a specific series, or how to update `solutions/index.md`), leave a short note in your PR and I’ll refine these instructions.
