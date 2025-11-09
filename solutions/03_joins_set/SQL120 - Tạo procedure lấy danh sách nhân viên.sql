-- Imported from batch1.md
-- Title: Tạo procedure lấy danh sách nhân viên

CREATE PROCEDURE GetEmployeeById(IN employeeId INT)
BEGIN
    SELECT * FROM Employees WHERE id = employeeId;
END
