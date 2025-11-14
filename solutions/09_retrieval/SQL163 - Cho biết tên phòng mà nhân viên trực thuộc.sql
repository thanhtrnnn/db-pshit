--- Tables: NHANVIEN, PHONGBAN
--- Technique: retrieval (dialect: Sql Server)

SELECT DISTINCT
    PB.TENPHG AS "Tên phòng"
FROM
    NHANVIEN NV
JOIN
    PHONGBAN PB ON NV.PHG = PB.MAPHG;