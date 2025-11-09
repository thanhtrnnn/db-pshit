-- SQL152: Những khách hàng nào (tên giao dịch) đã đặt mua mặt hàng 'chair' của công ty
-- Bảng (theo ngữ cảnh Việt):
--   KHACHHANG(makhachhang, tengiaodich, ...)
--   DONDATHANG(sohoadon, makhachhang, ngaydathang, ...)
--   CHITIETDATHANG(sohoadon, mahang, soluong, dongia, ...)
--   MATHANG(mahang, tenhang, ...)
-- Output ví dụ: tengiaodich | tenhang (hàng mẫu: an | chair)

SELECT DISTINCT k.tengiaodich,
	   m.tenhang
FROM KHACHHANG k
JOIN DONDATHANG d   ON d.makhachhang = k.makhachhang
JOIN CHITIETDATHANG ctdh ON ctdh.sohoadon = d.sohoadon
JOIN MATHANG m      ON m.mahang = ctdh.mahang
WHERE LOWER(m.tenhang) = 'chair'
ORDER BY k.tengiaodich;

