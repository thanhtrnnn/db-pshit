-- Tables: NHANVIEN
-- Technique: retrieval (dialect: Mysql)

SELECT
    MaNV,
    TenNV,
    LuongCB + PhuCap AS TongLuong
FROM
    NHANVIEN;