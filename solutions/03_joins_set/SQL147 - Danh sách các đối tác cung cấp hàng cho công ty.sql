-- SQL147: Danh sách các đối tác cung cấp hàng cho công ty
-- YÊU CẦU: Liệt kê danh sách các đối tác (nhà cung cấp) có cung cấp mặt hàng cho công ty.
-- Dựa vào mô tả bài toán và hệ thống bảng được lặp lại ở các bài tiếp theo:
--   NHACUNGCAP (manhacungcap, tennhacungcap, diachi, ...)
--   MATHANG     (mahang, tenhang, maloaihang, manhacungcap?, soluong, ...)
-- Giả định phổ biến: bảng MATHANG chứa khóa ngoại manhacungcap trỏ về NHACUNGCAP.
-- Nếu trong lược đồ thực tế quan hệ N-N qua bảng trung gian (vd: CUNGCAP(manhacungcap, mahang))
--   thì thay JOIN trực tiếp bằng JOIN qua bảng trung gian.
-- Output mẫu (ảnh) chỉ thể hiện danh sách nhà cung cấp → nhiều khả năng gồm tennhacungcap (và có thể manhacungcap).
-- Chọn hiển thị manhacungcap, tennhacungcap; sắp xếp theo tên.
-- Điều chỉnh lại cột nếu ảnh output hiển thị khác.

SELECT DISTINCT n.manhacungcap, n.tennhacungcap
FROM NHACUNGCAP n
JOIN MATHANG m ON m.manhacungcap = n.manhacungcap
ORDER BY n.tennhacungcap;

-- Nếu output chỉ cần tên nhà cung cấp:
-- SELECT DISTINCT n.tennhacungcap
-- FROM NHACUNGCAP n
-- JOIN MATHANG m ON m.manhacungcap = n.manhacungcap
-- ORDER BY n.tennhacungcap;

