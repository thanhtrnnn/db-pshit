--- Tables: KHACHHANG, HOADON, CHITIETHOADON, MATHANG
--- Technique: retrieval (dialect: MySQL)

SELECT DISTINCT
    kh.TenGiaoDich,
    mh.TenHang
FROM
    KHACHHANG AS kh
JOIN
    HOADON AS hd ON kh.MaKH = hd.MaKH
JOIN
    CHITIETHOADON AS cthd ON hd.MaHD = cthd.MaHD
JOIN
    MATHANG AS mh ON cthd.MaMH = mh.MaMH
WHERE
    mh.TenHang = 'chair';