-- Project 6 | load exactly 7 source records and 8 settlement records.
-- Run ONCE after 01_create_tables.sql. Re-running causes PK violations.
-- All references and amounts below are fictitious.

INSERT ALL
  INTO ace26_payments_p6 VALUES ('P100',100,'USD',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P101',240,'USD',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P102', 70,'USD',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P103',150,'USD',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P104', 95,'USD',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P105',150,'EUR',DATE '2026-10-28')
  INTO ace26_payments_p6 VALUES ('P106', 20,'USD',DATE '2026-10-28')
SELECT 1 FROM dual;

-- P104 deliberately appears twice, PX99 intentionally has no source payment.
INSERT ALL
  INTO ace26_settlement_p6 VALUES (1,'P100',100,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (2,'P101',240,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (3,'P102', 65,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (4,'P104', 95,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (5,'P104', 95,'USD',DATE '2026-10-29')
  INTO ace26_settlement_p6 VALUES (6,'P105',150,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (7,'P106', 20,'USD',DATE '2026-10-28')
  INTO ace26_settlement_p6 VALUES (8,'PX99', 12,'USD',DATE '2026-10-28')
SELECT 1 FROM dual;

COMMIT;
