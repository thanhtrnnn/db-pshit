-- Tables: MATHANG, CHITIETDONHANG
-- Technique: retrieval (dialect: Mysql)

SELECT
    mh.TenMH,
    (ctdh.SoLuong * ctdh.GiaBan - ctdh.SoLuong * ctdh.GiaBan * ctdh.MucGiamGia / 100) AS SoTienPhaiTra
FROM
    CHITIETDONHANG AS ctdh
JOIN
    MATHANG AS mh ON ctdh.MaMH = mh.MaMH
WHERE
    ctdh.MaDH = 1002;