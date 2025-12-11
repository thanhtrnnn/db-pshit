CREATE PROCEDURE GetEmployeeById
    @employeeId INT
AS
BEGIN
    SELECT * 
    FROM Employees
    WHERE id = @employeeId;
END;