SELECT I.username, T.dept, T.number, C.title
FROM Instructor I
JOIN Teaches T ON I.username = T.username
JOIN Class C ON T.dept = C.dept AND T.number = C.number
ORDER BY I.lname ASC
LIMIT 2;
