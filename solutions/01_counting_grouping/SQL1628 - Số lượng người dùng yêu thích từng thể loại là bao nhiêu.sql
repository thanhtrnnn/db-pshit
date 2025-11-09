-- SQL1628: Số lượng người dùng yêu thích từng thể loại
-- Bảng: users(id, name, favorite_genre)
-- Output: favorite_genre | genre_count

SELECT favorite_genre,
       COUNT(*) AS genre_count
FROM users
GROUP BY favorite_genre
ORDER BY favorite_genre;  -- hoặc ORDER BY genre_count DESC tùy yêu cầu, sample hiển thị alpha
-- Problem: SQL1628 - Số lượng người dùng yêu thích từng thể loại là bao nhiêu.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
