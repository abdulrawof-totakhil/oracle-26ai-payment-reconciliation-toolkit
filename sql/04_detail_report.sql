-- Project 6 | full detailed reconciliation | READ ONLY
SELECT transaction_ref,
       source_amount,
       source_currency,
       settlement_count,
       settled_amount,
       settlement_currency,
       settlement_sum,
       result_code
FROM ace26_recon_p6
ORDER BY transaction_ref;
