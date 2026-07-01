Create database Intership_project

select * from trnx_16
select *from trnx_20_NEW

--- Creating Fact_table by merging all the transaction table--

SELECT *
INTO fact_table
FROM
(
    SELECT * FROM trnx_16
    UNION ALL
    SELECT * FROM trnx_17
    UNION ALL
    SELECT * FROM trnx_18
    UNION ALL
    SELECT * FROM trnx_19_NEW
    UNION ALL
    SELECT * FROM trnx_20_NEW
    UNION ALL
    SELECT * FROM trnx_21_NEW
) t;

select * from fact_table

-- ============================================================
-- SECTION 2: PRIMARY KEY CHECKS
-- ============================================================

-- Check for duplicate PKs across all tables
SELECT 'A1'         AS tbl, COUNT(*) - COUNT(DISTINCT A1) AS duplicate_pks FROM district
UNION ALL
SELECT 'account',                  COUNT(*) - COUNT(DISTINCT account_id)                  FROM account
UNION ALL
SELECT 'client',                   COUNT(*) - COUNT(DISTINCT client_id)                   FROM client
UNION ALL
SELECT 'disp',                     COUNT(*) - COUNT(DISTINCT disp_id)                     FROM disp
UNION ALL
SELECT 'card',                     COUNT(*) - COUNT(DISTINCT card_id)                     FROM card
UNION ALL
SELECT 'loan',                     COUNT(*) - COUNT(DISTINCT loan_id)                     FROM loan
UNION ALL
SELECT '[order]',                  COUNT(*) - COUNT(DISTINCT order_id)                    FROM [order]
UNION ALL
SELECT 'fact_table',         COUNT(*) - COUNT(DISTINCT trans_id)                    FROM fact_table;

--Check for NULL PKs

SELECT 'district'         AS tbl, SUM(CASE WHEN A1 IS NULL THEN 1 ELSE 0 END) AS null_pks FROM district
UNION ALL
SELECT 'account',                  SUM(CASE WHEN account_id   IS NULL THEN 1 ELSE 0 END) FROM account
UNION ALL
SELECT 'client',                   SUM(CASE WHEN client_id    IS NULL THEN 1 ELSE 0 END) FROM client
UNION ALL
SELECT 'disp',                     SUM(CASE WHEN disp_id      IS NULL THEN 1 ELSE 0 END) FROM disp
UNION ALL
SELECT 'card',                     SUM(CASE WHEN card_id      IS NULL THEN 1 ELSE 0 END) FROM card
UNION ALL
SELECT 'loan',                     SUM(CASE WHEN loan_id      IS NULL THEN 1 ELSE 0 END) FROM loan
UNION ALL
SELECT '[order]',                  SUM(CASE WHEN order_id     IS NULL THEN 1 ELSE 0 END) FROM [order]
UNION ALL
SELECT 'fact_table',         SUM(CASE WHEN trans_id     IS NULL THEN 1 ELSE 0 END) FROM fact_table;

-- ============================================================
-- SECTION 3: FOREIGN KEY / REFERENTIAL INTEGRITY CHECKS
-- ============================================================

-- account.district_id ? district.district_id
SELECT COUNT(*) AS orphan_accounts
FROM account a
WHERE NOT EXISTS (SELECT 1 FROM district d WHERE d.A1 = a.district_id);

-- client.district_id ? district.district_id
SELECT COUNT(*) AS orphan_clients
FROM client c
WHERE NOT EXISTS (SELECT 1 FROM district d WHERE d.A1 = c.district_id);

-- disp.account_id ? account.account_id
SELECT COUNT(*) AS orphan_disp_accounts
FROM disp dp
WHERE NOT EXISTS (SELECT 1 FROM account a WHERE a.account_id = dp.account_id);

-- disp.client_id ? client.client_id
SELECT COUNT(*) AS orphan_disp_clients
FROM disp dp
WHERE NOT EXISTS (SELECT 1 FROM client c WHERE c.client_id = dp.client_id);

-- card.disp_id ? disp.disp_id
SELECT COUNT(*) AS orphan_cards
FROM card ca
WHERE NOT EXISTS (SELECT 1 FROM disp dp WHERE dp.disp_id = ca.disp_id);

-- loan.account_id ? account.account_id
SELECT COUNT(*) AS orphan_loans
FROM loan l
WHERE NOT EXISTS (SELECT 1 FROM account a WHERE a.account_id = l.account_id);

-- order.account_id ? account.account_id
SELECT COUNT(*) AS orphan_orders
FROM [order] o
WHERE NOT EXISTS (SELECT 1 FROM account a WHERE a.account_id = o.account_id);

-- fact_table.account_id ? account.account_id
SELECT COUNT(*) AS orphan_transactions
FROM fact_table f
WHERE NOT EXISTS (SELECT 1 FROM account a WHERE a.account_id = f.account_id);


-- ============================================================
-- SECTION 4: DATE FORMAT CHECK
-- ============================================================

-- loan.date — already imported as proper DATE by SQL Server
SELECT
    MIN(date) AS min_loan_date,
    MAX(date) AS max_loan_date
FROM loan;

-- account.date — same, already proper DATE
SELECT
    MIN(date) AS min_account_date,
    MAX(date) AS max_account_date
FROM account;

-- card.issued
SELECT---- In this query issued is in number format. (1)
    MIN(issued) AS min_card_date,
    MAX(issued) AS max_card_date
FROM card;

-- Check data type to confirm whether (1) is correct or not
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'card' AND COLUMN_NAME = 'issued';
-- The data type is nvarchar 

-- Preview the conversion before applying
SELECT TOP 5
    card_id,
    issued AS issued_raw,
    CONVERT(DATE,
        '19' + LEFT(issued, 2)          -- YY ? 19YY
             + SUBSTRING(issued, 3, 2)  -- MM
             + SUBSTRING(issued, 5, 2), -- DD
    112) AS issued_parsed
FROM card;
-- Expected: 931107 00:00:00 ? 1993-11-07

-- Add new column and fill the table with correct date
ALTER TABLE card ADD issued_parsed DATE;
GO

UPDATE card
SET issued_parsed = CONVERT(DATE,
    '19' + LEFT(issued, 2)
         + SUBSTRING(issued, 3, 2)
         + SUBSTRING(issued, 5, 2),
112);
GO

-- STEP 4: Verify
SELECT
    MIN(issued_parsed) AS min_card_date,
    MAX(issued_parsed) AS max_card_date
FROM card;


-- fact_table transaction dates
SELECT
    MIN(Date) AS min_trnx_date,
    MAX(Date) AS max_trnx_date
FROM fact_table;


-- ============================================================
-- SECTION 5: NULL CHECKS ON KEY COLUMNS
-- ============================================================

SELECT 'loan'             AS tbl, 'status'        AS col, SUM(CASE WHEN status        IS NULL THEN 1 ELSE 0 END) AS null_count FROM loan
UNION ALL SELECT 'loan',           'amount',               SUM(CASE WHEN amount        IS NULL THEN 1 ELSE 0 END) FROM loan
UNION ALL SELECT 'account',        'frequency',            SUM(CASE WHEN frequency     IS NULL THEN 1 ELSE 0 END) FROM account
UNION ALL SELECT 'account',        'Account_type',         SUM(CASE WHEN Account_type  IS NULL THEN 1 ELSE 0 END) FROM account
UNION ALL SELECT 'client',         'birth_number',         SUM(CASE WHEN birth_number  IS NULL THEN 1 ELSE 0 END) FROM client
UNION ALL SELECT 'fact_table','amount',              SUM(CASE WHEN amount        IS NULL THEN 1 ELSE 0 END) FROM fact_table
UNION ALL SELECT 'fact_table','balance',             SUM(CASE WHEN balance       IS NULL THEN 1 ELSE 0 END) FROM fact_table
UNION ALL SELECT 'fact_table','Type',                SUM(CASE WHEN [Type]        IS NULL THEN 1 ELSE 0 END) FROM fact_table;


-- ============================================================
-- SECTION 6: TRANSACTION DATA QUALITY ISSUES
-- ============================================================

-- account_partern_id = 0 (placeholder — should be NULL)
SELECT COUNT(*) AS rows_with_zero_partner_id
FROM fact_table
WHERE account_partern_id = 0;

-- Fix: replace 0 with NULL
UPDATE fact_table
SET account_partern_id = NULL
WHERE account_partern_id = 0;
GO

-- Sky Bank anomaly in trnx_19 — bank filled for non-transfer rows
SELECT operation, bank, COUNT(*) AS row_count
FROM fact_table
WHERE bank = 'Sky Bank'
GROUP BY operation, bank
ORDER BY row_count DESC;


-- Fix: null out bank where operation is not a transfer
UPDATE fact_table
SET bank = NULL
WHERE bank IS NOT NULL
  AND operation NOT IN ('Remittance to Another Bank', 'Electronic funds transfer');
GO

-- bank and account_partern_id must always come together
SELECT
    CASE
        WHEN bank IS NOT NULL AND account_partern_id IS NULL THEN 'bank filled but partner NULL'
        WHEN bank IS NULL AND account_partern_id IS NOT NULL THEN 'partner filled but bank NULL'
    END AS issue_type,
    COUNT(*) AS row_count
FROM fact_table
WHERE (bank IS NOT NULL AND account_partern_id IS NULL)
   OR (bank IS NULL AND account_partern_id IS NOT NULL)
GROUP BY
    CASE
        WHEN bank IS NOT NULL AND account_partern_id IS NULL THEN 'bank filled but partner NULL'
        WHEN bank IS NULL AND account_partern_id IS NOT NULL THEN 'partner filled but bank NULL'
    END;

    -- See the exact problem row
SELECT 
    trans_id,
    account_id,
    Date,
    [Type],
    operation,
    amount,
    balance,
    bank,
    account_partern_id
FROM fact_table
WHERE bank IS NOT NULL 
AND account_partern_id IS NULL;

--  To fix this let's set bank to NULL so both columns are consistent
UPDATE fact_table
SET bank = NULL
WHERE bank IS NOT NULL 
AND account_partern_id IS NULL;
GO

-- Verify
SELECT COUNT(*) AS remaining_issues
FROM fact_table
WHERE (bank IS NOT NULL AND account_partern_id IS NULL)
   OR (bank IS NULL AND account_partern_id IS NOT NULL);



-- ============================================================
-- SECTION 7: DOMAIN / ENUM VALUE CHECKS
-- ============================================================

-- loan.status — allowed: A, B, C, D only
SELECT COUNT(*) AS invalid_loan_status
FROM loan WHERE status NOT IN ('A','B','C','D');

-- card.type — allowed: classic, junior, gold only
SELECT COUNT(*) AS invalid_card_type
FROM card WHERE type NOT IN ('classic','junior','gold');

-- disp.type — allowed: OWNER, USER only
SELECT COUNT(*) AS invalid_disp_type
FROM disp WHERE type NOT IN ('OWNER','USER');

-- fact_table.Type — allowed: Credit, Withdrawal only
SELECT COUNT(*) AS invalid_transaction_type
FROM fact_table WHERE [Type] NOT IN ('Credit','Withdrawal');

-- account.Account_type — allowed: Savings, Salary, NRI only
SELECT COUNT(*) AS invalid_account_type
FROM account
WHERE Account_type NOT IN ('Savings account', 'NRI account', 'Salary account');



-- ============================================================
-- SECTION 8: BUSINESS RULE CHECKS
-- ============================================================

-- 8.1 One account must have at most one loan
SELECT account_id, COUNT(*) AS loan_count
FROM loan GROUP BY account_id HAVING COUNT(*) > 1;


-- 8.2 Every account must have exactly one OWNER in disp
SELECT a.account_id
FROM account a
WHERE NOT EXISTS (
    SELECT 1 FROM disp d
    WHERE d.account_id = a.account_id AND d.type = 'OWNER'
);

-- 8.3 Transaction amounts must be positive
SELECT COUNT(*) AS negative_or_zero_amounts
FROM fact_table WHERE amount <=0;

-- 8.5 Loan duration must be 12, 24, 36, 48, or 60 months only
SELECT COUNT(*) AS invalid_durations
FROM loan WHERE duration NOT IN (12,24,36,48,60);

-- 8.6 Loan monthly payment = amount / duration (allow ±1 for rounding)
SELECT COUNT(*) AS payment_mismatch
FROM loan
WHERE ABS(payments - (CAST(amount AS FLOAT) / duration)) > 1;


-- ============================================================
-- SECTION 9: ROW COUNT SUMMARY
-- ============================================================

SELECT 'district'         AS table_name, COUNT(*) AS row_count FROM district
UNION ALL SELECT 'account',              COUNT(*) FROM account
UNION ALL SELECT 'client',               COUNT(*) FROM client
UNION ALL SELECT 'disp',                 COUNT(*) FROM disp
UNION ALL SELECT 'card',                 COUNT(*) FROM card
UNION ALL SELECT 'loan',                 COUNT(*) FROM loan
UNION ALL SELECT '[order]',              COUNT(*) FROM [order]
UNION ALL SELECT 'fact_table',     COUNT(*) FROM fact_table
ORDER BY row_count DESC;















































