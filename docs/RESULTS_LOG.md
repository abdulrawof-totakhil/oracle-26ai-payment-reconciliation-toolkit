# Execution results — observed in supplied Oracle FreeSQL screenshots

**Contributor:** Abdulrawof Totakhil  
**Environment shown:** Oracle FreeSQL, Oracle AI Database 26ai  
**Execution date visible:** 2026-10-28 (timestamps shown in screenshots)  
**Dataset:** Fictional payments and settlements

| Check | Expected | Observed | Evidence |
|---|---:|---:|---|
| Source payment rows | 7 | 7 | `evidence/screenshots/03_source_counts.png` |
| Settlement rows | 8 | 8 | `evidence/screenshots/03_source_counts.png` |
| Reconciled reference rows | 8 | 8 | `evidence/screenshots/05_reconciliation_detail.png` |
| Matched | 3 | 3 | `evidence/screenshots/06_exception_summary.png` |
| Amount mismatch | 1 | 1 | `evidence/screenshots/06_exception_summary.png` |
| Currency mismatch | 1 | 1 | `evidence/screenshots/06_exception_summary.png` |
| Missing settlement | 1 | 1 | `evidence/screenshots/06_exception_summary.png` |
| Unexpected settlement | 1 | 1 | `evidence/screenshots/06_exception_summary.png` |
| Duplicate settlement | 1 | 1 | `evidence/screenshots/06_exception_summary.png` |
| QUALIFY returned rows | 7 | 7 | `evidence/screenshots/07_26ai_qualify.png` |
| QUALIFY latest P104 settlement ID | 5 | 5 | `evidence/screenshots/07_26ai_qualify.png` |
| JSON array returned | Yes | Yes (array visible; contents truncated on screen) | `evidence/screenshots/08_json_exception_report.png` |
| Final distinct references | 8 | 8 | `evidence/screenshots/09_final_named_dated_check.png` |
| Final matched/exceptions/categories | 3 / 5 / 6 | 3 / 5 / 6 | `evidence/screenshots/09_final_named_dated_check.png` |
| Compact final TEST_RESULT | PASS | **PASS: 8 references, 3 matched, 5 exceptions** | `evidence/screenshots/10_final_compact_PASS.png` |
| Individual reference assertions | 8 PASS rows | **Not yet evidenced** | Run `tests/01_expected_statuses.sql` |
| Aggregate assertion | PASS | **Not yet evidenced** | Run `tests/02_count_assertions.sql` |

Execution results were transcribed from contributor screenshots, not generated in an Oracle database by the report author.

## Scope notes

- The reconciliation view performs deterministic rule-based classification; it is not AI or machine learning.
- The example `QUALIFY` statement is for latest-settlement reporting only; the primary reconciliation view still flags duplicated references.
- JSON export is intended for a downstream interface, but no external REST API or automatic bank integration is implemented.
