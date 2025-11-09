# Section Evaluation Criteria

This document defines the taxonomy used to classify SQL solutions into folders. Each section has crisp criteria, typical patterns, and counter-examples. When writing or revising a solution, classify by the PRIMARY technique or learning objective demonstrated by the final (preferred) query.

## Decision Flow (High-Level)
1. Does the solution perform data CHANGE (INSERT/UPDATE/DELETE) or CREATE/ALTER? -> DML or DDL.
2. Else, is the core logic detecting sequences, using window frames, ranking? -> Window / Sequences.
3. Else, is the essence counting, aggregating, grouping metrics? -> Counting & Grouping.
4. Else, dominated by date/time filtering or interval comparisons? -> Filtering Dates.
5. Else, relies mainly on joins (including self-joins) or set operations (UNION/INTERSECT/EXCEPT) without window usage? -> Joins & Set.
6. Else, heavy on subqueries / CTE composition (multiple steps of derived sets)? -> Subqueries & CTE.
7. Else, pivoting, conditional aggregation for reshaping rows->columns? -> Pivot / Conditional Aggregation.
8. Else, string parsing, pattern matching (LIKE/REGEXP), text normalization? -> Strings & Regex.
9. Else, numeric math tricks (percentages, rounding, running arithmetic, modular, factorial)? -> Math & Numbers.
10. Else, classification defaults to Misc; re-evaluate if advanced technique emerges.

Prefer the MOST SPECIFIC advanced technique (Window > Aggregation; Pivot > Generic Grouping; DML/DDL always override).

## Section Definitions

### 01_counting_grouping
Focus: Aggregations with GROUP BY (SUM/COUNT/AVG/MIN/MAX) and simple HAVING filters.
Inclusions: Counting distinct entities, computing averages per category.
Exclusions: If window functions or pivots are core, classify there instead.
Example: Count customers per region; average price per product line.

### 02_filtering_dates
Focus: Date/time comparisons, intervals, ranges, current vs past/future.
Inclusions: Using DATE_ADD/DATE_DIFF, month/year extraction for filtering.
Exclusions: If date logic only minor in a window ranking problem, use Window section.
Example: Rising temperature comparisons, active records within last 30 days (without window functions).

### 03_joins_set
Focus: Multi-table joins (INNER/LEFT/RIGHT/CROSS) or set algebra (UNION/EXCEPT/INTERSECT) as the dominant pattern.
Inclusions: Self-join for pairing, anti-joins for exclusion, join-based filtering.
Exclusions: If the query's learning objective is sequence detection via window functions, move to Window.
Example: Find customers who bought all products via relational division using joins.

### 04_subqueries_cte
Focus: Nested SELECTs, CTE layering, correlation for filtering or transformation where subquery structure is central.
Inclusions: Problems emphasizing multi-step build-up, correlated EXISTS/NOT EXISTS logic.
Exclusions: If final solution is simpler with a single join + group, classify accordingly.
Example: Selecting users who satisfy complex conditional logic across multiple derived sets.

### 05_pivot_conditional
Focus: Conditional aggregation that turns rows into columns; pivoting via SUM(CASE ...) or COUNT(CASE ...).
Inclusions: Multi-column tally creation from categorical values.
Exclusions: Basic single CASE in select list is not a pivot.
Example: Exam attendance matrix per student, monthly sales pivot.

### 06_strings_regex
Focus: Text operations: LIKE, ILIKE, REGEXP, SUBSTRING, TRIM, REPLACE, normalization.
Inclusions: Pattern filters, cleaning malformed titles.
Exclusions: Basic equality comparison on strings.
Example: Find movies where description not boring using pattern negation.

### 07_math_numbers
Focus: Numeric expressions, percentages, division safeguards (NULLIF), ranking numeric transformations without window use.
Inclusions: Price computations, ratio calculations, rounding.
Exclusions: Aggregates alone (move to Counting) unless numeric transformation is core.
Example: Average selling price with guard against zero division.

### 09_window_sequences
Focus: Window functions: ROW_NUMBER, RANK, DENSE_RANK, LAG/LEAD, SUM() OVER(), sequence detection, running totals.
Inclusions: Consecutive event detection, top-N per partition using window ranking, cumulative sums.
Exclusions: Simple group aggregates, even if partitioned by one key.
Example: Detect consecutive numbers; rank products by sales per category.

### 10_dml
Focus: Data modification queries where SELECT is subordinate to DELETE/UPDATE/INSERT logic.
Inclusions: Deleting duplicates, updating rows conditionally.
Exclusions: SELECT-only problems.
Example: Delete duplicate emails keeping lowest id.

### 12_ddl
Focus: Schema definition or alteration.
Inclusions: CREATE TABLE, ALTER TABLE, adding constraints.
Exclusions: If main ask is querying existing schema.
Example: Define normalized products table with constraints.

### Misc / Reassign Queue
Temporary parking for unresolved classification; MUST be revisited.

## Classification Rules
- Single dominant technique rule: Pick the section representing the central concept the learner must grasp.
- Tie-breakers:
  1. Advanced vs basic: window > joins > group.
  2. Transformation specificity: pivot > generic aggregation.
  3. Operation type precedence: DML/DDL override all.
- Multi-approach solutions: Use folder matching PRIMARY recommended solution; alternative approach commented inside file.

## Re-evaluation Procedure
1. Implement working solution.
2. Identify core technique used.
3. Compare with existing folder; if mismatch, move file.
4. Update `solutions/index.md` path and section entry.
5. Record change (old path, new path, rationale) in a CHANGELOG block appended to file or a central log.

## CHANGELOG Format (Embedded in SQL file)
```
-- CHANGELOG
-- [2025-11-08] Moved from 03_joins_set to 09_window_sequences; uses LAG for sequence detection.
```

## Examples of Edge Decisions
- A query with COUNT(*) and LAG() for gap detection -> Window.
- DELETE with join to filter target rows -> DML.
- CREATE TABLE plus sample insert guidance -> DDL.
- Conditional aggregation producing multiple derived columns from categories -> Pivot.
- Subquery using NOT EXISTS to implement division instead of joins -> Subqueries & CTE.

## Future Extensions
Potential additions: 11_performance_indexing (if index advice tasks appear), 13_security_access (privilege management), 14_json_xml (semi-structured data handling).

---
This file should be updated as new problem patterns emerge.
