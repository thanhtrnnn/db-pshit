# SQL Problem Evaluation Criteria

This document defines the 11 categories for classifying SQL problems and the decision flow for selecting the correct one.

## Decision Flow (Triage)

To classify a problem, follow this triage process. Stop as soon as you find a match.

1.  **Modification Check:**
    * Does the problem require `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, or `DROP`?
    * **YES** -> `modification` (Stop).

2.  **Aggregation Check:**
    * Does the problem use an aggregate function (e.g., `COUNT`, `SUM`, `AVG`)?
    * **YES, and *no* `GROUP BY`** -> `aggregation_simple`.
    * **YES, and *has* `GROUP BY`** -> `aggregation_grouped`.
    * *(Caveat: If it has `GROUP BY` but also `SUM(CASE...)` to pivot, skip. `pivoting` is more specific).*

3.  **Analytics Check (Keyword):**
    * Does the problem use a window function (anything with `OVER(...)`, e.g., `ROW_NUMBER`, `LAG`, `SUM() OVER`)?
    * **YES** -> `window_functions`.

4.  **Reshaping Check:**
    * Does the problem transform rows into columns (e.g., `SUM(CASE WHEN...)` or `PIVOT`)?
    * **YES** -> `pivoting`.

5.  **Set Logic Check:**
    * Does the problem use `UNION`, `INTERSECT`, or `EXCEPT` as the primary logic?
    * **YES** -> `set_operations`.
    * Does it solve a "for all" problem (e.g., "student who took *all* courses")?
    * **YES** -> `relational_division`.
    * Is the `JOIN` condition a range (`BETWEEN`) or inequality (`>`, `<`) instead of equals (`=`)?
    * **YES** -> `range_join`.

6.  **Filtering Check:**
    * If none of the above, is the *main challenge* in the `WHERE` clause (e.g., complex `DATEDIFF`, `SUBSTRING` logic)?
    * **YES** -> `filtering`.

7.  **Default & Complex Check:**
    * Is the problem a standard `SELECT...WHERE...JOIN` (using `=`) for simple lookups?
    * **YES** -> `retrieval` (This is the default category).
    * Does the problem require combining 2+ *advanced* techniques (e.g., `window_functions` + `pivoting`) or have exceptionally complex, nested logic?
    * **YES** -> `complex` (This is the final catch-all).

---

## Category Definitions (11 Categories)

### 1. Modification
* **`modification`** (DML/DDL)
    * **Description:** Changes data (`INSERT`, `UPDATE`, `DELETE`) or structure (`CREATE`, `ALTER`, `DROP`).

### 2. Aggregation
* **`aggregation_simple`** (Simple Aggregation)
    * **Description:** Returns a single aggregate value for the entire result set.
    * **Key Technique:** `COUNT`, `SUM`, etc., *without* a `GROUP BY` clause.
* **`aggregation_grouped`** (Grouped Aggregation)
    * **Description:** Summarizes data into groups.
    * **Key Technique:** `GROUP BY`, often with `HAVING`.

### 3. Analytics & Reshaping
* **`window_functions`** (Window Functions)
    * **Description:** (Merges `topn_window` and `window`). Performs inter-row calculations or ranking.
    * **Key Technique:** Any function using `OVER(...)`, including `ROW_NUMBER()`, `RANK()`, `LAG()`, `SUM() OVER()`.
* **`pivoting`** (Pivoting)
    * **Description:** Transforms unique row values into distinct columns.
    * **Key Technique:** Conditional aggregation (`SUM(CASE WHEN...)`) or `PIVOT`.

### 4. Advanced Set Logic
* **`set_operations`** (Set Operators)
    * **Description:** Compares or combines two or more result sets.
    * **Key Technique:** `UNION`, `INTERSECT`, `EXCEPT`.
* **`relational_division`** (Relational Division)
    * **Description:** Solves "for all" problems (e.g., "finds who bought *all* products").
    * **Key Technique:** Often implemented with `GROUP BY...HAVING COUNT` or nested `NOT EXISTS`.
* **`range_join`** (Range Join)
    * **Description:** Connects tables based on a range or inequality.
    * **Key Technique:** `JOIN` condition using `BETWEEN`, `>`, or `<`.

### 5. Default & Complex
* **`filtering`** (Complex Filtering)
    * **Description:** (Merges `filtering_dates` and `filtering_strings`). The main challenge is the `WHERE` clause.
    * **Key Technique:** Complex logic using `DATEDIFF`, `SUBSTRING`, `LIKE`, `LOWER`/`TRIM`.
* **`retrieval`** (Basic Retrieval)
    * **Description:** The "default" category for simple information lookups.
    * **Key Technique:** Standard `SELECT`, `WHERE`, and equality-based `JOIN`s.
* **`complex`** (Complex)
    * **Description:** Requires 2+ *advanced* techniques (e.g., `window` + `pivot`) or has exceptionally complex, nested logic.