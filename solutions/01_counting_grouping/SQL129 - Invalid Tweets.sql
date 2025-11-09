-- Imported from batch1.md
-- Title: Invalid Tweets

SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;
