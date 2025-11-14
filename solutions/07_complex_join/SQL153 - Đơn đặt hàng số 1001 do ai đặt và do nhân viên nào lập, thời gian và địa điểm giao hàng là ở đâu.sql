 -- Tables: DONDATHANG, KHACHHANG, NHANVIEN
 -- Technique: retrieval (dialect: Mysql)
 
 SELECT
  dh.sohoadon,
  kh.tengiaodich,
  nv.tennhanvien,
  dh.ngaydathang,
  dh.ngaygiaohang,
  dh.noigiaohang
 FROM DONDATHANG AS dh
 JOIN KHACHHANG AS kh
  ON dh.makh = kh.makh
 JOIN NHANVIEN AS nv
  ON dh.manv = nv.manv
 WHERE
  dh.sohoadon = 1;