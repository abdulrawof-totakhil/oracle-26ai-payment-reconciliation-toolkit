-- Project 6 | Oracle AI Database 26ai QUALIFY demonstration | READ ONLY
-- IMPORTANT: This query selects a latest settlement for display only.
-- It is NOT used to reconcile or hide duplicates.
SELECT settlement_id,
       transaction_ref,
       settled_amount,
       currency_code,
       settlement_date,
       ROW_NUMBER() OVER (
           PARTITION BY transaction_ref
           ORDER BY settlement_date DESC, settlement_id DESC
       ) AS row_rank
FROM ace26_settlement_p6
QUALIFY row_rank = 1
ORDER BY transaction_ref;
