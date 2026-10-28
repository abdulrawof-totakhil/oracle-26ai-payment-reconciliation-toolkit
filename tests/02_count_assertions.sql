-- Project 6 | automated summary assertion | READ ONLY
SELECT CASE
    WHEN (SELECT COUNT(*) FROM ace26_payments_p6) = 7
     AND (SELECT COUNT(*) FROM ace26_settlement_p6) = 8
     AND COUNT(*) = 8
     AND SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END) = 3
     AND SUM(CASE WHEN result_code = 'AMOUNT_MISMATCH' THEN 1 ELSE 0 END) = 1
     AND SUM(CASE WHEN result_code = 'CURRENCY_MISMATCH' THEN 1 ELSE 0 END) = 1
     AND SUM(CASE WHEN result_code = 'DUPLICATE_SETTLEMENT' THEN 1 ELSE 0 END) = 1
     AND SUM(CASE WHEN result_code = 'MISSING_SETTLEMENT' THEN 1 ELSE 0 END) = 1
     AND SUM(CASE WHEN result_code = 'UNEXPECTED_SETTLEMENT' THEN 1 ELSE 0 END) = 1
    THEN 'PASS' ELSE 'FAIL' END AS test_result
FROM ace26_recon_p6;
