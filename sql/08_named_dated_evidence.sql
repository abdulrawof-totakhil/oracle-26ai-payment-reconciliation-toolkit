-- Project 6 | contributor and date visible for ACE evidence | READ ONLY
SELECT 'Abdulrawof Totakhil' AS contributor,
       TO_CHAR(CURRENT_TIMESTAMP,
               'YYYY-MM-DD HH24:MI:SS TZH:TZM') AS evidence_date,
       (SELECT COUNT(*) FROM ace26_payments_p6) AS source_rows,
       (SELECT COUNT(*) FROM ace26_settlement_p6) AS settlement_rows,
       COUNT(*) AS distinct_references,
       SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END)
           AS matched,
       SUM(CASE WHEN result_code <> 'MATCHED' THEN 1 ELSE 0 END)
           AS exceptions,
       CASE WHEN COUNT(*) = 8
                 AND SUM(CASE WHEN result_code = 'MATCHED' THEN 1 ELSE 0 END) = 3
                 AND SUM(CASE WHEN result_code <> 'MATCHED' THEN 1 ELSE 0 END) = 5
            THEN 'PASS' ELSE 'REVIEW' END AS result
FROM ace26_recon_p6;
