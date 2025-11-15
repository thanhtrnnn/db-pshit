-- Tables: Donors
-- Technique: UPDATE (dialect: Mysql)

UPDATE Donors
SET Amount = Amount + 250
WHERE FirstName = 'John' AND DonationDate = '2022-12-31';