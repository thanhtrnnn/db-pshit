-- SQL1627: Địa chỉ IP có cả đăng nhập 'suspicious' và 'successful'
-- Bảng: login_attempts(id, ip_address, login_status)
-- Output: ip_address (mỗi địa chỉ thỏa điều kiện)

SELECT ip_address
FROM login_attempts
WHERE login_status = 'successful'
INTERSECT
SELECT ip_address
FROM login_attempts
WHERE login_status = 'suspicious'
ORDER BY ip_address;

-- Nếu hệ quản trị không hỗ trợ INTERSECT (MySQL), dùng GROUP BY/HAVING:
-- SELECT ip_address
-- FROM login_attempts
-- WHERE login_status IN ('successful','suspicious')
-- GROUP BY ip_address
-- HAVING COUNT(DISTINCT login_status) = 2
-- ORDER BY ip_address;
