-- Project 6 | per-reference assertion | READ ONLY
-- Expected entries are specified independently of the reconciliation view.
WITH expected AS (
    SELECT 'P100' transaction_ref, 'MATCHED' expected_code FROM dual UNION ALL
    SELECT 'P101', 'MATCHED' FROM dual UNION ALL
    SELECT 'P102', 'AMOUNT_MISMATCH' FROM dual UNION ALL
    SELECT 'P103', 'MISSING_SETTLEMENT' FROM dual UNION ALL
    SELECT 'P104', 'DUPLICATE_SETTLEMENT' FROM dual UNION ALL
    SELECT 'P105', 'CURRENCY_MISMATCH' FROM dual UNION ALL
    SELECT 'P106', 'MATCHED' FROM dual UNION ALL
    SELECT 'PX99', 'UNEXPECTED_SETTLEMENT' FROM dual
)
SELECT COALESCE(e.transaction_ref, r.transaction_ref) transaction_ref,
       e.expected_code,
       r.result_code AS actual_code,
       CASE WHEN e.expected_code = r.result_code THEN 'PASS'
            ELSE 'FAIL' END AS test_result
FROM expected e
FULL OUTER JOIN ace26_recon_p6 r
    ON r.transaction_ref = e.transaction_ref
ORDER BY COALESCE(e.transaction_ref, r.transaction_ref);
