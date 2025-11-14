-- Tables: MATHANG, NHACUNGCAP
-- Technique: retrieval

SELECT
  m.TenHang,
  ncc.MaCongTy,
  ncc.TenCongTy
FROM MATHANG AS m
JOIN NHACUNGCAP AS ncc
  ON m.MaCongTy = ncc.MaCongTy
ORDER BY
  m.TenHang;