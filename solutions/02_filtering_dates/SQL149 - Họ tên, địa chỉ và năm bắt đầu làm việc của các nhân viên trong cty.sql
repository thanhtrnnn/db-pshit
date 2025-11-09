-- SQL149: Họ tên, địa chỉ và năm bắt đầu làm việc của các nhân viên trong cty
-- Lược đồ tiếng Việt thường gặp:
--   NHANVIEN(manhanvien, ho, ten, diachi, ngaybatdaulam, ...)
-- Output ảnh yêu cầu: hoten | diachi | nambatdaulam (năm).
-- MySQL: dùng YEAR(ngaybatdaulam).

SELECT CONCAT(nv.ho, ' ', nv.ten) AS hoten,
       nv.diachi,
       YEAR(nv.ngaybatdaulam) AS nambatdaulam
FROM NHANVIEN nv
ORDER BY hoten;

