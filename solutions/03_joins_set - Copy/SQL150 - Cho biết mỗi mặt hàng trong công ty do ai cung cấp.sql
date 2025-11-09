-- SQL150: Cho biết mỗi mặt hàng trong công ty do ai cung cấp (sắp xếp theo tên hàng tăng dần)
-- Bảng tham chiếu (theo mô tả):
--   MATHANG(mahang, tenhang, maloaihang, manhacungcap, ...)
--   NHACUNGCAP(manhacungcap, tennhacungcap, diachi, ...)
-- Yêu cầu: liệt kê tenhang và tennhacungcap; ORDER BY tenhang ASC.

SELECT m.tenhang,
       n.tennhacungcap
FROM MATHANG m
JOIN NHACUNGCAP n ON n.manhacungcap = m.manhacungcap
ORDER BY m.tenhang ASC;

