--- Tables: PHONGBAN, NHANVIEN
--- Technique: retrieval (dialect: Sql Server)

SELECT
    N.HONV + N.TENLOT + N.TENNV AS 'Trưởng phòng nghiên cứu'
FROM
    PHONGBAN AS PB
JOIN
    NHANVIEN AS N ON PB.TRPHG = N.MANV
WHERE
    PB.TENPHG = N'Nghiên cứu';