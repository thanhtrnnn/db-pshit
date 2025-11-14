SELECT * FROM Instructor
WHERE
	started_on >= DATE_SUB(CURDATE(), INTERVAL 20 YEAR)
	AND DAY(started_on) = 1
	AND MONTH(started_on) = 1;
