-- Project 6 | Oracle AI Database 26ai | synthetic data only
-- Run once in your own FreeSQL schema.
-- WARNING: Creates two new demonstration tables; no existing tables are modified.

CREATE TABLE ace26_payments_p6 (
    transaction_ref VARCHAR2(20) PRIMARY KEY,
    source_amount   NUMBER(12,2) NOT NULL,
    currency_code   VARCHAR2(3) NOT NULL,
    payment_date    DATE NOT NULL,
    CONSTRAINT ace26_pay_amt_p6_ck CHECK (source_amount > 0),
    CONSTRAINT ace26_pay_ccy_p6_ck CHECK (currency_code IN ('USD','EUR'))
);

-- Intentionally no FOREIGN KEY to payments: an unmatched settlement is
-- a legitimate test scenario for reconciliation.
CREATE TABLE ace26_settlement_p6 (
    settlement_id   NUMBER PRIMARY KEY,
    transaction_ref VARCHAR2(20) NOT NULL,
    settled_amount  NUMBER(12,2) NOT NULL,
    currency_code   VARCHAR2(3) NOT NULL,
    settlement_date DATE NOT NULL,
    CONSTRAINT ace26_set_amt_p6_ck CHECK (settled_amount > 0),
    CONSTRAINT ace26_set_ccy_p6_ck CHECK (currency_code IN ('USD','EUR'))
);
