-- Imported from batch1.md
-- Title: Cập nhật kết quả sinh viên

UPDATE SinhVien
SET TrangThai = CASE
    WHEN DiemTB >= 5.0 THEN 'Đạt'
    ELSE 'Không đạt'
END;
