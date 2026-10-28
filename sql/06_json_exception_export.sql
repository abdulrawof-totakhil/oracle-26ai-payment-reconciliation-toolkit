-- Project 6 | JSON exception report | READ ONLY
-- Run against synthetic data only. One ordered array of five exceptions.
SELECT JSON_ARRAYAGG(
         JSON_OBJECT(
           'transactionRef' VALUE transaction_ref,
           'exceptionType' VALUE result_code,
           'sourceAmount' VALUE source_amount,
           'sourceCurrency' VALUE source_currency,
           'settlementCount' VALUE settlement_count,
           'settledAmount' VALUE settled_amount,
           'settlementCurrency' VALUE settlement_currency
         )
         ORDER BY transaction_ref
         RETURNING CLOB
       ) AS exception_json_report
FROM ace26_recon_p6
WHERE result_code <> 'MATCHED';
