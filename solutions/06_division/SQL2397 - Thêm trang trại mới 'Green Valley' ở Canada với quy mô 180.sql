-- Problem: SQL2397 - Thêm trang trại mới 'Green Valley' ở Canada với quy mô 180.html
-- Auto-classified section: 06_division
-- Rationale: Bài toán “đã có tất cả” dùng HAVING COUNT(DISTINCT) = tổng mục tiêu.
-- Adjust table/column names before running.

-- Division (all items) template
SELECT entity_id
FROM entity_item
GROUP BY entity_id
HAVING COUNT(DISTINCT item_id) = (SELECT COUNT(DISTINCT item_id) FROM items);
