-- Tables: LOAIHANG, MATHANG, NHACUNGCAP
-- Technique: retrieval

SELECT DISTINCT
  lh.tenloaihang,
  ncc.tencongty,
  ncc.diachi
FROM LOAIHANG AS lh
JOIN MATHANG AS mh
  ON lh.maloaihang = mh.maloaihang
JOIN NHACUNGCAP AS ncc
  ON mh.macongty = ncc.macongty
WHERE
  lh.tenloaihang = 'furniture';