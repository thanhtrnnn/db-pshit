-- SQL1633: Tổng số thuê bao di động và băng thông rộng
-- Bảng: mobile_subscribers(subscriber_id, subscription_type)
--        broadband_subscribers(subscriber_id, subscription_type)
-- Output mẫu: hai hàng COUNT(*): mobile trước, broadband sau (theo thứ tự xuất hiện sample)

SELECT COUNT(*) AS total_mobile FROM mobile_subscribers
UNION ALL
SELECT COUNT(*) AS total_broadband FROM broadband_subscribers;
-- Problem: SQL1633 - Có tổng cộng bao nhiêu thuê bao di động và băng thông rộng.html
-- Auto-classified section: 01_counting_grouping
-- Rationale: Đếm/tổng hợp theo nhóm với GROUP BY; dùng SUM/COUNT/AVG và CASE khi cần điều kiện.
-- Adjust table/column names before running.

-- Counting / Grouping template
SELECT <group_cols>, COUNT(*) AS cnt
FROM <table>
GROUP BY <group_cols>;
