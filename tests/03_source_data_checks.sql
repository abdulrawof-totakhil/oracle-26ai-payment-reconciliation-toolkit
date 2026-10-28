-- Project 6 | independent data checks | READ ONLY
SELECT 'SOURCE_ROWS' AS check_name, COUNT(*) AS actual_value, 7 AS expected_value
FROM ace26_payments_p6
UNION ALL
SELECT 'SETTLEMENT_ROWS', COUNT(*), 8
FROM ace26_settlement_p6
UNION ALL
SELECT 'DUPLICATE_SETTLEMENT_REFS', COUNT(*), 1
FROM (
    SELECT transaction_ref
    FROM ace26_settlement_p6
    GROUP BY transaction_ref
    HAVING COUNT(*) > 1
);
