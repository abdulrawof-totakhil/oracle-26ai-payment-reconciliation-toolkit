# Test plan — Project 6

## Scope
Validate a synthetic payment-versus-settlement reconciliation implementation. Only the two `ACE26_*_P6` tables and the `ACE26_RECON_P6` view are modified or created. No real customer data is used.

## Execution steps
1. Create two tables: `sql/01_create_tables.sql`.
2. Load synthetic data once: `sql/02_seed_synthetic_data.sql`.
3. Create the reconciliation view: `sql/03_create_reconciliation_view.sql`.
4. Run SQL files 04–09 individually, capturing results.
5. Run the three SQL tests under `tests/`.

## Expected dataset outcomes

| Reference | Expected outcome | Reason |
|---|---|---|
| P100 | MATCHED | USD 100 on both sides |
| P101 | MATCHED | USD 240 on both sides |
| P102 | AMOUNT_MISMATCH | Source 70; settlement 65 |
| P103 | MISSING_SETTLEMENT | No settlement row |
| P104 | DUPLICATE_SETTLEMENT | Two settlement records |
| P105 | CURRENCY_MISMATCH | Source EUR, settlement USD |
| P106 | MATCHED | USD 20 on both sides |
| PX99 | UNEXPECTED_SETTLEMENT | Settlement without source |

Expected: 7 payment records, 8 settlement rows, 8 distinct references, 3 matched references, 5 exceptions. The `QUALIFY` demonstration should return 7 latest settlement rows, including settlement ID 5 for reference P104. These are *designed expectations* and require execution in Oracle to be verified.

## Acceptance criteria
- `tests/01_expected_statuses.sql`: 8 `PASS` rows, no `FAIL` rows.
- `tests/02_count_assertions.sql`: `PASS`.
- `tests/03_source_data_checks.sql`: all actual counts equal expected counts.
- `sql/08_named_dated_evidence.sql`: final result `PASS` with accurate execution timestamp.

## Limitations and next steps
- Currency mismatch is reported without converting currencies.
- No real clearing system, bank data, transfer instructions, or operational ledger is involved.
- Reconciliation tolerance is fixed at 0.01 for this teaching example.
- Duplicate settlement detection intentionally takes precedence over amount matching.
- This is a SQL-based rules engine, not an AI/ML model.
- For real deployments, add batch controls, exception ownership, audit logging, immutable evidence, retries, stronger idempotency, and approved currency conversion policy.

## Additional acceptance evidence

Run `tests/04_compact_final_pass.sql` in Oracle FreeSQL and capture the full `TEST_RESULT` cell. Run `tests/01_expected_statuses.sql` and `tests/02_count_assertions.sql`. Their results are not yet present in the supplied screenshots. See `evidence/README.md` and `docs/RESULTS_LOG.md`.
