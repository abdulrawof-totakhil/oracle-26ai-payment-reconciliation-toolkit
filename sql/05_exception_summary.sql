-- Project 6 | exception classification and totals | READ ONLY
SELECT result_code,
       COUNT(*) AS references_count
FROM ace26_recon_p6
GROUP BY result_code
ORDER BY result_code;
