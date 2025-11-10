-- Tweets longer than 15 characters are invalid; use LEN for SQL Server compatibility.
SELECT tweet_id FROM Tweets
WHERE LEN(content) > 15;
