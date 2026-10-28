# Oracle AI Database 26ai — Payment Reconciliation & Exception Toolkit

**Original open-source demo project | Oracle ACE Product Usage | GitHub Repository category**

This project implements a **synthetic, SQL-based reconciliation prototype**. It reconciles payment records with settlement records and classifies differences. It is distinct from a SQL diagnostics/data-quality toolkit, transaction anomaly detection, application audit trails, and JSON Duality Views.

> **Status (2026-10-28):** Source tables, seed data, reconciliation view, summary, QUALIFY, and JSON reporting were executed in Oracle FreeSQL as shown by contributor-provided screenshots. The compact Oracle SQL summary test returned PASS on 2026-10-28. Individual per-reference and aggregate assertion scripts remain available for independent execution. No screenshots or execution dates have been fabricated.

## What it detects

- `MATCHED`: one settlement has same currency and amount.
- `AMOUNT_MISMATCH`: one settlement has a different amount.
- `CURRENCY_MISMATCH`: one settlement has a different currency.
- `MISSING_SETTLEMENT`: source payment has no settlement.
- `UNEXPECTED_SETTLEMENT`: settlement has no source payment.
- `DUPLICATE_SETTLEMENT`: multiple settlements refer to one source payment.

The prototype **groups settlement rows before joining**. This is important: a naive join can hide duplicate settlement risk or inflate reconciliation totals. The rules are documented and independently checked by SQL tests.

## Technology

- Oracle AI Database 26ai, free online SQL worksheet: https://freesql.com
- SQL joins, conditional rules, grouped calculations, JSON_OBJECT, and SQL test assertions.
- `QUALIFY` filters on `ROW_NUMBER()` are showcased as a **26ai SQL enhancement**, separately from the main reconciliation logic. https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/Analytic-Functions.html
- Standard `FULL OUTER JOIN` is used to retain unmatched references from **both** data sources. https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/Joins.html

## Quick start — FreeSQL (26ai)

1. Log into https://freesql.com and select **26ai**.
2. Run `sql/01_create_tables.sql` (**Run Script**, once).
3. Run `sql/02_seed_synthetic_data.sql` (**Run Script**, once).
4. Run `sql/03_create_reconciliation_view.sql` (**Run Script**, once).
5. Run `sql/04_detail_report.sql` and `sql/05_exception_summary.sql`.
6. Run `sql/06_json_exception_export.sql` (JSON exception records).
7. Run `sql/07_26ai_qualify_example.sql` (`QUALIFY` example).
8. Run `tests/01_expected_statuses.sql`, `tests/02_count_assertions.sql` and `tests/03_source_data_checks.sql`.
9. Run `sql/08_named_dated_evidence.sql` and `sql/09_compact_overview.sql`, if useful.
10. Run `tests/04_compact_final_pass.sql`; the completed `PASS` result is supplied in `evidence/screenshots/10_final_compact_PASS.png`.
11. Review `docs/RESULTS_LOG.md` and the contributor-provided screenshots in `evidence/`, then publish to a **new** public GitHub repository.

**Do not rerun seed inserts**: the test data uses fixed primary keys. No privileged grants, packages or installed database software are required for the demo. This is not intended for a production banking environment.

## Offline CI check (separate from Oracle SQL tests)

Run `python3 tests/offline_fixture_check.py` for an independent synthetic fixture model check. GitHub Actions also runs it on push. It parses the fixture records from the seed SQL and checks expected classifications with an in-memory SQLite model; **it does not execute Oracle SQL or establish FreeSQL compatibility**. The actual Oracle SQL tests under `tests/` must be run in Oracle FreeSQL; the compact summary test is evidenced, but separate per-reference and aggregate assertion runs have not been captured.

## Expected results (verified for listed counts by supplied Oracle FreeSQL screenshots)

| Result | Count |
|---|---:|
| MATCHED | 3 |
| AMOUNT_MISMATCH | 1 |
| CURRENCY_MISMATCH | 1 |
| MISSING_SETTLEMENT | 1 |
| UNEXPECTED_SETTLEMENT | 1 |
| DUPLICATE_SETTLEMENT | 1 |
| **Distinct reconciled references** | **8** |
| **Exceptions** | **5** |

See [TEST_PLAN](docs/TEST_PLAN.md) for a case-by-case truth table and [ACE_SUBMISSION](docs/ACE_SUBMISSION.md) for the submission description and safeguards.

## Security and limitations

- **Synthetic data only.** No actual bank records, account details, hostnames, connection strings, or credentials.
- **Do not use as a production payments engine.** The script does not initiate or approve transfers.
- Fixed decimal tolerance `0.01` is illustrative and requires business approval in real implementations.
- This is **deterministic SQL rules, not a machine-learning model**, and the project does not claim proprietary AI capabilities.
- Duplicate settlements are explicitly flagged rather than automatically suppressed.
- Real-world reconciliation requires transaction lifecycle/settlement timing, currency conversion, batch control, conflict handling, RBAC, audit, and exception workflow.

## Attribution and references

- Oracle SQL Language Reference — Joins: https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/Joins.html
- Oracle SQL Language Reference — Analytic Functions / QUALIFY: https://docs.oracle.com/en/database/oracle/oracle-database/26/sqlrf/Analytic-Functions.html
- Oracle AI Database 26ai New Features: https://docs.oracle.com/en/database/oracle/oracle-database/26/nfcoa/all-nfg.html

The implementation, sample data, test expectations, and documentation in this repository are original demonstration material. Oracle technology names are trademarks of their respective owners. This repository is not affiliated with or endorsed by Oracle.

## License

MIT — see [LICENSE](LICENSE).
