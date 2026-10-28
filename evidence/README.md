# Real execution screenshot manifest — October 28, 2026

These PNG files are copies of screenshots provided by the contributor in this conversation, showing Oracle FreeSQL (26ai) test runs. They are not recreated, simulated or modified execution evidence.

**Important:** All transactions and amounts are synthetic examples. The earlier named-and-dated summary cuts off `TEST_RESULT`, but a later compact SQL query visibly returned `PASS` for 8 references, 3 matches, and 5 exceptions. Separate per-reference SQL assertions remain to be captured.

## Successful runs captured

| File | What is visible |
|---|---|
| `screenshots/01_create_tables.png` | Two CREATE TABLE steps, settlement creation message visible |
| `screenshots/02_insert_records.png` | Synthetic inserts and COMMIT message visible |
| `screenshots/03_source_counts.png` | 7 payments and 8 settlements returned |
| `screenshots/04_create_reconciliation_view.png` | CREATE OR REPLACE VIEW success message |
| `screenshots/05_reconciliation_detail.png` | Eight reference classifications |
| `screenshots/06_exception_summary.png` | Six categories: 3 MATCHED and five individual exceptions |
| `screenshots/07_26ai_qualify.png` | QUALIFY returned seven most recent settlements; P104 id 5 |
| `screenshots/08_json_exception_report.png` | Query returned a JSON array; full array truncated in visible cell |
| `screenshots/09_final_named_dated_check.png` | Contributor and timestamp, 8 refs/3 matched/5 exceptions/6 categories; final TEST_RESULT off-screen |
| `screenshots/10_final_compact_PASS.png` | Final summary assertion: 8 references, 3 matched, 5 exceptions, TEST_RESULT PASS |

## Troubleshooting

| File | Context |
|---|---|
| `troubleshooting/01_missing_view_error.png` | ORA-00942 before reconciliation view was created |
| `troubleshooting/02_missing_view_diagnostic.png` | `USER_VIEWS` returned no matching view before creation |

The missing-view issue was resolved by creating the view successfully (see `screenshots/04_create_reconciliation_view.png`).

## Evidence integrity

No hostnames, real banking/customer data, credentials, or sensitive production data are required. Review images before posting publicly for other personal information.
