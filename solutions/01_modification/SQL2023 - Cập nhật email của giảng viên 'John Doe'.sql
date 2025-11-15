 -- Tables: faculty
 -- Technique: UPDATE (dialect: MySQL)
UPDATE faculty
SET email = 'johndoe_new@mail.com'
WHERE first_name = 'John' AND last_name = 'Doe';