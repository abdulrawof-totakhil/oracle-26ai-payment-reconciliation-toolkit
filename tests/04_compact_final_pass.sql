-- Project 6 | compact final evidence assertion | READ ONLY
-- Execute in Oracle FreeSQL and capture the complete visible result.
SELECT
  'Abdulrawof Totakhil' AS contributor,
  TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS TZH:TZM') AS execution_date,
  COUNT(*) AS refs,
  SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END) AS matched,
  SUM(CASE WHEN result_code <> 'MATCHED' THEN 1 ELSE 0 END) AS exceptions,
  COUNT(DISTINCT result_code) AS categories,
  CASE WHEN COUNT(*) = 8
       AND SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END) = 3
       AND SUM(CASE WHEN result_code <> 'MATCHED' THEN 1 ELSE 0 END) = 5
       AND COUNT(DISTINCT result_code) = 6
       THEN 'PASS' ELSE 'FAIL'
  END AS test_result
FROM ace26_recon_p6;
