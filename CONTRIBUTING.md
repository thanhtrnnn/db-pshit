
# Hướng dẫn đóng góp (Contributing)

Cảm ơn bạn đã quan tâm đóng góp vào kho `db-pshit`. Mục tiêu của chúng ta là đảm bảo các lời giải SQL chính xác, rõ ràng và có thể chạy trên môi trường kiểm thử (db.ptit.edu.vn). Dưới đây là các bước hướng dẫn chi tiết để bạn kiểm tra, sửa và gửi PR.

## Kiểm tra thủ công trên db.ptit.edu.vn
- **Mở bài toán**: Vào `https://db.ptit.edu.vn` và tìm bài tương ứng (hoặc dùng tên file trong thư mục `problems/`).
- **Chạy câu SQL**: Dán nội dung file `.sql` (trong `solutions/`) vào ô chạy của trang và chạy thử với dữ liệu mẫu.
- **Đánh giá kết quả**: So sánh kết quả trả về với kết quả mong muốn (output trên trang hoặc mô tả đề bài). Kiểm tra:
	- **Cú pháp**: Lỗi cú pháp hoặc lỗi dialect (ví dụ `TOP` vs `LIMIT`, nối chuỗi `+` vs `||`).
	- **Sai tên bảng/cột**: Kiểm tra alias và tên cột chính xác.
	- **Kết quả sai**: Các hàng thiếu/thiếu điều kiện JOIN, GROUP BY/aggregate sai, ORDER BY không xác định.
	- **Trường hợp biên**: NULL, duplicate, phân trang, sắp xếp, và ràng buộc dữ liệu.

## Cách phát hiện code sai
- Nộp bài và nhận kết quả WA/ TLE trên db.ptit.edu.vn.
- So sánh kết quả trả về với output mẫu.
- Kiểm tra kỹ lưỡng câu SQL để tìm lỗi logic hoặc cú pháp/ lỗi "ngớ ngẩn" (như sửa/ xoá bảng trong bài SELECT).

## Sửa code và đưa lên repo
- **Chuẩn bị**: Clone/fetch repo và tạo branch mới từ `master`:

	```powershell
	git checkout -b fix/sql-<mã-bài>-mô-tả
	```

- **Chỉnh sửa file**: Mở file SQL trong `solutions/...` tương ứng, sửa câu lệnh và lưu. Giữ định dạng và phần header metadata (ví dụ: `--- Tables: ...`, `--- Technique: ...`).
- **Ghi chú kiểm thử**: Ở đầu hoặc cuối file (comment) ghi rõ bạn đã test trên `db.ptit.edu.vn` và tóm tắt input/expectation (ví dụ: "Tested on db.ptit.edu.vn — kết quả khớp/không khớp").

- **Commit & Push**:

	```powershell
	git add <path/to/that-file.sql>
	git commit -m "Fix(SQL): <mã-bài> - sửa <vấn-đề-ngắn-gọn> (tested on db.ptit.edu.vn)"
	git push origin HEAD
	```

- **Mở Pull Request**:
	- Cách thủ công: Vào trang GitHub repo, bạn sẽ thấy đề nghị tạo PR từ branch vừa push — điền tiêu đề và mô tả (nêu rõ bạn đã test ở đâu và sửa gì).
	- Nếu dùng `gh` cli: `gh pr create --fill`.

## Chuẩn nội dung PR
- **Tiêu đề**: `Fix(SQL): <mã-bài> - ngắn gọn mô tả sửa`.
- **Mô tả**: Nêu rõ
	- Vấn đề (kèm ảnh chụp lỗi hoặc output sai nếu có).
	- Cách sửa (đổi JOIN, sửa GROUP BY, thay hàm, v.v.).
	- Nơi đã test: `db.ptit.edu.vn` và các bước chi tiết để tái tạo.

## Quy tắc nhỏ
- **Giữ metadata**: Đừng xóa phần header comment (tables, technique, dialect).
- **Commit nhỏ, rõ ràng**: Một commit = một thay đổi logic.
- **Ghi chú test**: Luôn ghi chỗ bạn đã test và kết quả.

Cảm ơn bạn — mọi đóng góp giúp kho đúng và hữu ích hơn. Xin hãy kiểm tra kỹ trước khi mở PR để tiết kiệm thời gian review.

