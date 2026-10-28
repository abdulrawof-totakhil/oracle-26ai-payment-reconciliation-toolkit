-- Project 6 | unified, reproducible reconciliation classification.
-- Aggregate settlements BEFORE joining: duplicate settlement rows must not
-- multiply source payment rows or be mistaken for matched payments.
-- CREATE VIEW changes only a demonstration view in the current schema.

CREATE OR REPLACE VIEW ace26_recon_p6 AS
WITH settlement_totals AS (
    SELECT transaction_ref,
           COUNT(*) AS settlement_count,
           MAX(settled_amount) AS single_settlement_amount,
           MAX(currency_code) AS single_settlement_currency,
           SUM(settled_amount) AS settlement_sum
    FROM ace26_settlement_p6
    GROUP BY transaction_ref
)
SELECT
    COALESCE(p.transaction_ref, s.transaction_ref) AS transaction_ref,
    p.source_amount,
    p.currency_code AS source_currency,
    s.settlement_count,
    CASE WHEN s.settlement_count = 1
         THEN s.single_settlement_amount END AS settled_amount,
    CASE WHEN s.settlement_count = 1
         THEN s.single_settlement_currency END AS settlement_currency,
    s.settlement_sum,
    CASE
        WHEN p.transaction_ref IS NULL THEN 'UNEXPECTED_SETTLEMENT'
        WHEN s.transaction_ref IS NULL THEN 'MISSING_SETTLEMENT'
        WHEN s.settlement_count > 1 THEN 'DUPLICATE_SETTLEMENT'
        WHEN p.currency_code <> s.single_settlement_currency
            THEN 'CURRENCY_MISMATCH'
        WHEN ABS(p.source_amount - s.single_settlement_amount) > 0.01
            THEN 'AMOUNT_MISMATCH'
        ELSE 'MATCHED'
    END AS result_code
FROM ace26_payments_p6 p
FULL OUTER JOIN settlement_totals s
    ON p.transaction_ref = s.transaction_ref;
