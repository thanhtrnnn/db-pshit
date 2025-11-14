-- Tables: NHANVIEN
-- Technique: filtering (dialect: Sql Server)

SELECT
    HONV + TENLOT + TENNV AS "Nhân viên phòng 5"
FROM
    NHANVIEN
WHERE
    PHG = 5;