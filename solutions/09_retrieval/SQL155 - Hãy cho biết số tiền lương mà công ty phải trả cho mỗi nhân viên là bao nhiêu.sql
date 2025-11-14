-- Tables: NHANVIEN
-- Technique: retrieval (dialect: Mysql)

SELECT
    MANHANVIEN,
    LUONGCOBAN + PHUCAP AS luong
FROM
    NHANVIEN;