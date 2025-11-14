# SQL Problem Evaluation Criteria

This document defines the 10 categories for classifying SQL problems. The decision flow is crucial for distinguishing truly complex problems from simpler ones.

## Decision Flow (Triage)

To classify a problem, follow this logic. **Do not stop at the first match.**

1.  **Check for Modification:**
    * Does the problem require `INSERT`, `UPDATE`, `DELETE`, `CREATE`, `ALTER`, or `DROP`?
    * **YES** -> `modification`. (This is a unique path. Stop here).

2.  **Scan for Structural Complexity (forces `complex`):**
    * These traits immediately force the problem into the `complex` bucket, even if no other advanced technique appears:
        * **CTE usage:** any `WITH ... AS (...)` block counts. 2+ CTE exist -> `complex`.
        * **Heavy subquerying:** ANY SUBQUERIES IN THE QUERY (SELECT inside FROM/ GROUP BY/ HAVING...) -> `complex`
        * **Complex joins:** multi-table joins whose conditions mix inequalities, OR chains, or cross-table calculations (not just simple FK equality).
        * **Very long solutions:** statements that naturally span dozens of lines/steps before the final `SELECT`.
    * If any bullet above is true -> `complex`. (Stop here).

3.  **Identify Advanced Techniques:**
    * If still undecided, look for any following specific patterns to route to their dedicated categories:
        * `window_functions` (Any `OVER()` clause)
        * `pivoting` (Any `SUM(CASE...)` or `PIVOT`)
        * `set_operations` (Any `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`)
        * `relational_division` ("For all" logic)
        * `complex_join` (any `JOIN`/ `LEFT JOIN`/ `RIGHT JOIN`/ `CROSS JOIN` among >= 2 tables together)

4.  **Single Advanced Technique:**
    * If *exactly one* advanced technique from Step 2 was identified:
    * **YES** -> Assign that category (e.g., `window_functions`, `pivoting`, etc.). (Stop).

5.  **Check Simple Categories (If no advanced techniques found):**
    * *If not aggregation*, is the *main challenge* the `WHERE` clause (ANY date/string processing logic)?
    * **YES** -> `filtering`. (Stop).
    * *If none of the above*, does the query's main purpose involve `GROUP BY` or aggregates like `COUNT()`, `SUM()`?
    * **YES** -> `aggregation`. (Stop).

6.  **Assign Default:**
    * *If none of the above apply*, the query is a standard lookup.
    * **YES** -> `retrieval`.

---

## Category Definitions (10 Categories)

### 1. Modification
* **`modification`** (DML/DDL)
    * **Description:** Changes data (`INSERT`, `UPDATE`, `DELETE`) or structure (`CREATE`, `ALTER`, `DROP`).

### 2. Aggregation
* **`aggregation`** (Merged Aggregation)
    * **Description:** Summarizes data. Includes both single (`COUNT(*)`) and grouped (`GROUP BY`) aggregations.

### 3. Advanced Analytics & Reshaping
* **`window_functions`** (Window Functions)
    * **Description:** Ranking (`ROW_NUMBER`) or inter-row calculations (`LAG`, `LEAD`, `SUM() OVER`).
* **`pivoting`** (Pivoting)
    * **Description:** Transforms rows into columns (`SUM(CASE WHEN...)` or `PIVOT`).

### 4. Advanced Set Logic
* **`set_operations`** (Set Operators)
    * **Description:** Uses `UNION`, `INTERSECT`, `EXCEPT` as the primary logic.
* **`relational_division`** (Relational Division)
    * **Description:** Solves "for all" problems (e.g., "who bought *all* products").
* **`complex_join`** (Range Join)
    * **Description:** `JOIN` condition uses `BETWEEN` or inequalities (`>`, `<`).

### 5. Default & Complex
* **`filtering`** (Complex Filtering)
    * **Description:** The main challenge is the `WHERE` clause (complex date logic, string parsing).
* **`retrieval`** (Basic Retrieval)
    * **Description:** Default bucket. Standard `SELECT-WHERE-JOIN` lookups with straightforward equality joins/filters. Allows single-layer `IN` / `EXISTS` filters, but no CTEs or deeply nested subqueries.
* **`complex`** (Complex)
    * **Description:** Any solution that relies on CTEs, 2+ stacked subqueries, complex conditional joins, or is long enough to require multiple staged steps.
