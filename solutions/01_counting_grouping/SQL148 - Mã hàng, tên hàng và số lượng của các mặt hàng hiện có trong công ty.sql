-- SQL148: Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty
-- Dựa theo mô tả chung các bảng:
--   MATHANG (mahang, tenhang, maloaihang, manhacungcap?, soluong, ...)
-- Output yêu cầu: mahang | tenhang | soluong (ảnh).
-- Giả định: cột 'soluong' biểu diễn số lượng hiện có; không cần tổng hợp nếu đã lưu trực tiếp.
-- Nếu thực tế tồn kho phân mảnh theo nhiều bảng (ví dụ TONKHO(mahang, soluong_kho)), thay bằng SUM.

SELECT mahang, tenhang, soluong
FROM MATHANG
ORDER BY mahang;

-- Biến thể nếu phải cộng dồn từ bảng chi tiết tồn kho (ví dụ TONKHO):
-- SELECT m.mahang, m.tenhang, COALESCE(SUM(t.soluong),0) AS soluong
-- FROM MATHANG m
-- LEFT JOIN TONKHO t ON t.mahang = m.mahang
-- GROUP BY m.mahang, m.tenhang
-- ORDER BY m.mahang;

