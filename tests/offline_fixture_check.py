"""Validate synthetic SQL seed fixtures independently, without an Oracle login.

This is a lightweight local *model check* of the data scenarios, not a substitute
for executing the actual Oracle SQL scripts and tests in FreeSQL.
"""
from collections import Counter
from pathlib import Path
import re
import sqlite3

ROOT = Path(__file__).resolve().parent.parent
text = (ROOT / 'sql' / '02_seed_synthetic_data.sql').read_text(encoding='utf-8')

payments = re.findall(
    r"INTO ace26_payments_p6 VALUES \('([^']+)',\s*(\d+(?:\.\d+)?),'([^']+)',DATE '([^']+)'\)",
    text,
)
settlements = re.findall(
    r"INTO ace26_settlement_p6 VALUES \((\d+),'([^']+)',\s*(\d+(?:\.\d+)?),'([^']+)',DATE '([^']+)'\)",
    text,
)
assert len(payments) == 7, f'Expected 7 payment fixtures, found {len(payments)}'
assert len(settlements) == 8, f'Expected 8 settlement fixtures, found {len(settlements)}'

with sqlite3.connect(':memory:') as conn:
    conn.execute('CREATE TABLE payments (ref TEXT PRIMARY KEY, amount REAL, currency TEXT)')
    conn.execute('CREATE TABLE settlements (id INTEGER PRIMARY KEY, ref TEXT, amount REAL, currency TEXT)')
    conn.executemany('INSERT INTO payments VALUES (?,?,?)', [(ref, float(amount), curr) for ref, amount, curr, _ in payments])
    conn.executemany('INSERT INTO settlements VALUES (?,?,?,?)', [(int(i), ref, float(amt), curr) for i, ref, amt, curr, _ in settlements])
    rows = conn.execute('''
        WITH st AS (
            SELECT ref, COUNT(*) AS n, MAX(amount) AS amount, MAX(currency) AS currency
            FROM settlements GROUP BY ref
        )
        SELECT COALESCE(p.ref, st.ref),
            CASE WHEN p.ref IS NULL THEN 'UNEXPECTED_SETTLEMENT'
                 WHEN st.ref IS NULL THEN 'MISSING_SETTLEMENT'
                 WHEN st.n > 1 THEN 'DUPLICATE_SETTLEMENT'
                 WHEN p.currency <> st.currency THEN 'CURRENCY_MISMATCH'
                 WHEN ABS(p.amount - st.amount) > 0.01 THEN 'AMOUNT_MISMATCH'
                 ELSE 'MATCHED' END
        FROM payments p FULL OUTER JOIN st ON p.ref = st.ref
        ORDER BY 1
    ''').fetchall()

expected = {
    'P100':'MATCHED', 'P101':'MATCHED', 'P102':'AMOUNT_MISMATCH',
    'P103':'MISSING_SETTLEMENT', 'P104':'DUPLICATE_SETTLEMENT',
    'P105':'CURRENCY_MISMATCH', 'P106':'MATCHED',
    'PX99':'UNEXPECTED_SETTLEMENT',
}
assert dict(rows) == expected, f'Fixture mismatch: {dict(rows)!r}'
assert Counter(code for _, code in rows)['MATCHED'] == 3
print('PASS: all 8 expected synthetic reconciliation classifications match')
print('Note: this is an offline SQLite model test, NOT an Oracle 26ai execution test')
