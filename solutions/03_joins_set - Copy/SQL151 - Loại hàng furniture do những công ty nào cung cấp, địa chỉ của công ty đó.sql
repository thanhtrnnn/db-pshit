-- SQL151: Loại hàng 'furniture' do những công ty nào cung cấp, địa chỉ của công ty đó
-- Bảng:
--   LOAIHANG(maloaihang, tenloaihang,...)
--   MATHANG(mahang, tenhang, maloaihang, manhacungcap,...)
--   NHACUNGCAP(manhacungcap, tennhacungcap, diachi,...)
-- Yêu cầu: lọc theo LOAIHANG.tenloaihang = 'furniture'. Trả về tennhacungcap, diachi (và có thể manhacungcap nếu ảnh hiển thị).

SELECT DISTINCT n.manhacungcap,
       n.tennhacungcap,
       n.diachi
FROM LOAIHANG l
JOIN MATHANG m      ON m.maloaihang = l.maloaihang
JOIN NHACUNGCAP n   ON n.manhacungcap = m.manhacungcap
WHERE LOWER(l.tenloaihang) = 'furniture'
ORDER BY n.tennhacungcap;

