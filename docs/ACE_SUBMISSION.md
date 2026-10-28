# Oracle ACE — prepared GitHub contribution

**Category:** GitHub Repository (not Screenshots and documentation of code/products in use)

**Proposed title:** Oracle AI Database 26ai - Open Source Payment Reconciliation and Exception Toolkit

**Repository name:** `oracle-26ai-payment-reconciliation-toolkit`

**Date:** Use the actual completion/publication date, not a backdated or fabricated date.

**Repository URL:** Add the actual public GitHub repository URL after publishing. A local ZIP or `https://github.com` is *not* a repository link.

## Suggested submission description

This original open-source code project demonstrates payment-to-settlement reconciliation using Oracle AI Database 26ai and fully synthetic data. The repository includes SQL scripts to create sample tables, load independent source and settlement records, classify matching and exceptional transactions using an aggregate-first FULL OUTER JOIN, export exceptions as JSON, and demonstrate Oracle 26ai's QUALIFY clause. It also provides independent expected-result tests, a reproducible runbook, and a design explanation. The examples detect missing settlements, unexpected settlements, duplicated settlement references, amount mismatches, and currency mismatches without accessing real financial data. Source data, reconciliation results, QUALIFY and JSON generation were executed in Oracle FreeSQL and are documented with contributor-provided screenshots. The compact summary validation returned PASS; separate per-reference assertions are included for reproducibility and are not yet documented as executed.

## Suggested reviewer comment

Dear Oracle ACE Review Team, this is a **new GitHub source-code contribution**, distinct from my previously submitted SQL Diagnostics and Data Quality Toolkit. It contains a runnable reconciliation prototype, documented exception rules, and automated SQL assertions. Please review the repository URL and README. The underlying FreeSQL dataset is synthetic; no real database identifiers or customer records are included.

## Before submission
1. Execute the SQL on FreeSQL with version 26ai selected; verify results.
2. Record actual execution output and date in `docs/RESULTS_LOG.md`.
3. Publish **this code** in a **new public repository**, not as another copy of the previous project.
4. Verify the public link in an incognito window.
5. Submit the actual repository URL under GitHub Repository when permitted.
6. If the ACE portal still raises ORA-00001, do not repeatedly submit or change the category just to circumvent a possible restriction. Contact Oracle ACE support for clarification.

Points and acceptance are not guaranteed.
