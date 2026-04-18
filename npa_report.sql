-- ════════════════════════════════════════════════════
-- NPA Summary Report
-- Run this in the Fabric Data Warehouse SQL Editor
-- (Connect to the bankguard Lakehouse SQL endpoint)
-- ════════════════════════════════════════════════════

-- 1. Overall NPA Ratio
--    This is the headline number in every bank's quarterly report
SELECT
    COUNT(*)                                            AS total_loans,
    SUM(outstanding_amount)                             AS total_loan_book,
    SUM(CASE WHEN is_npa = 1 THEN 1 ELSE 0 END)       AS npa_loan_count,
    SUM(CASE WHEN is_npa = 1 THEN outstanding_amount
             ELSE 0 END)                                AS gross_npa_amount,

    -- Gross NPA Ratio = NPA Amount / Total Loan Book
    ROUND(
        SUM(CASE WHEN is_npa = 1 THEN outstanding_amount ELSE 0 END)
        / SUM(outstanding_amount) * 100, 2
    )                                                   AS gross_npa_ratio_pct,

    SUM(provision_amount)                               AS total_provisions,

    -- Net NPA = Gross NPA - Provisions
    SUM(CASE WHEN is_npa = 1 THEN outstanding_amount ELSE 0 END)
    - SUM(provision_amount)                             AS net_npa_amount

FROM silver_loans;


-- 2. NPA Breakdown by Loan Type
SELECT
    loan_type,
    npa_category,
    COUNT(*)                                AS loan_count,
    ROUND(SUM(outstanding_amount), 0)       AS outstanding,
    ROUND(SUM(provision_amount), 0)         AS provisions,
    ROUND(AVG(dpd), 0)                      AS avg_dpd
FROM silver_loans
GROUP BY loan_type, npa_category
ORDER BY loan_type, avg_dpd DESC;


-- 3. Customers with Most Overdue Loans
--    (Useful for the collections team)
SELECT
    l.customer_id,
    l.loan_type,
    l.outstanding_amount,
    l.dpd,
    l.npa_category,
    c.segment,
    c.state
FROM silver_loans l
JOIN silver_customers c ON l.customer_id = c.customer_id
WHERE l.dpd > 30
ORDER BY l.dpd DESC, l.outstanding_amount DESC
LIMIT 20;
