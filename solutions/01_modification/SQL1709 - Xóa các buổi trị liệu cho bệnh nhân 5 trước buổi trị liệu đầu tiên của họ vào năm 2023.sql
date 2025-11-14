DELETE FROM therapy_sessions_2023
WHERE patient_id = 5
  AND session_date < (
    SELECT MIN(session_date)
    FROM therapy_sessions_2023
    WHERE patient_id = 5
      AND YEAR(session_date) = 2023
  );