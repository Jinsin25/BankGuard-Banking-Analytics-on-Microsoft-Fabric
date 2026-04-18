-- ════════════════════════════════════════════════════
-- Customer Analysis Queries
-- Run in Fabric Data Warehouse SQL Editor
-- ════════════════════════════════════════════════════

-- 1. Top 10 Customers by Total Spend
SELECT
    t.customer_id,
    c.segment,
    c.age_group,
    c.state,
    COUNT(t.transaction_id)         AS total_transactions,
    ROUND(SUM(t.amount), 2)         AS total_spend,
    ROUND(AVG(t.amount), 2)         AS avg_per_transaction,
    COUNT(DISTINCT t.channel)       AS channels_used
FROM silver_transactions t
JOIN silver_customers c ON t.customer_id = c.customer_id
GROUP BY t.customer_id, c.segment, c.age_group, c.state
ORDER BY total_spend DESC
LIMIT 10;


-- 2. Spend by Channel and Month
SELECT
    year_month,
    channel,
    COUNT(*)                    AS txn_count,
    ROUND(SUM(amount), 0)       AS total_amount,
    ROUND(AVG(amount), 0)       AS avg_amount
FROM silver_transactions
GROUP BY year_month, channel
ORDER BY year_month DESC, total_amount DESC;


-- 3. Customers with High Risk Score (for review)
SELECT
    r.customer_id,
    r.risk_score,
    r.risk_label,
    r.max_dpd,
    r.npa_loan_count,
    r.declined_count_30d,
    c.segment,
    c.state,
    c.years_with_bank
FROM gold_credit_risk_scores r
JOIN silver_customers c ON r.customer_id = c.customer_id
WHERE r.risk_score >= 51
ORDER BY r.risk_score DESC;
