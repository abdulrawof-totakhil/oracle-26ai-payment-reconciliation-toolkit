-- Project 6 | compact final result: designed to fit a screenshot | READ ONLY
SELECT COUNT(*) AS refs,
       SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END) AS matched,
       SUM(CASE WHEN result_code = 'AMOUNT_MISMATCH' THEN 1 ELSE 0 END) AS amt_diff,
       SUM(CASE WHEN result_code = 'CURRENCY_MISMATCH' THEN 1 ELSE 0 END) AS ccy_diff,
       SUM(CASE WHEN result_code = 'MISSING_SETTLEMENT' THEN 1 ELSE 0 END) AS missing,
       SUM(CASE WHEN result_code = 'UNEXPECTED_SETTLEMENT' THEN 1 ELSE 0 END) AS extra,
       SUM(CASE WHEN result_code = 'DUPLICATE_SETTLEMENT' THEN 1 ELSE 0 END) AS dupes
FROM ace26_recon_p6;
