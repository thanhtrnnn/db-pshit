-- Tables: NHANVIEN
-- Technique: retrieval (dialect: MySQL)

SELECT 
    HO AS ho,
    TEN AS ten,
    DIACHI AS diachi,
    YEAR(NGAYLAMVIEC) AS `year(ngaylamviec)`
FROM NHANVIEN;