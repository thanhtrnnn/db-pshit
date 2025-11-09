-- SQL1661: Vận động viên tham gia > 50 sự kiện
-- Bảng: Participants(id, athlete_id, event_id)
-- Output: athlete_id

SELECT athlete_id
FROM Participants
GROUP BY athlete_id
HAVING COUNT(DISTINCT event_id) > 50
ORDER BY athlete_id;
