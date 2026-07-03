-- ============================================================
--   CUSTOMER CHURN PREDICTION — SQL QUERIES
--   Database Table: customers
-- ============================================================


-- ============================================================
-- SECTION 1 — BASIC EXPLORATION
-- ============================================================

-- 1.1 See all data
SELECT * FROM customers LIMIT 10;

-- 1.2 Total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 1.3 How many churned vs not churned
SELECT
    Churn,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customers
GROUP BY Churn;

-- 1.4 Check for missing values
SELECT
    COUNT(*) - COUNT(tenure)         AS missing_tenure,
    COUNT(*) - COUNT(MonthlyCharges) AS missing_monthly_charges,
    COUNT(*) - COUNT(TotalCharges)   AS missing_total_charges,
    COUNT(*) - COUNT(Contract)       AS missing_contract
FROM customers;

-- 1.5 Basic statistics
SELECT
    ROUND(AVG(tenure), 2)         AS avg_tenure,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2)   AS avg_total_charges,
    MIN(tenure)                   AS min_tenure,
    MAX(tenure)                   AS max_tenure
FROM customers;


-- ============================================================
-- SECTION 2 — CHURN RATE ANALYSIS
-- ============================================================

-- 2.1 Overall churn rate
SELECT
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
    AS churn_rate_percent
FROM customers;

-- 2.2 Churn rate by contract type
SELECT
    Contract,
    COUNT(*)                                                              AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)                       AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 2.3 Churn rate by gender
SELECT
    gender,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY gender;

-- 2.4 Churn rate by internet service type
SELECT
    InternetService,
    COUNT(*)                                                              AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)                       AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- 2.5 Churn rate by payment method
SELECT
    PaymentMethod,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- 2.6 Churn rate by senior citizen status
SELECT
    SeniorCitizen,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY SeniorCitizen;


-- ============================================================
-- SECTION 3 — TENURE ANALYSIS
-- ============================================================

-- 3.1 Average tenure of churned vs loyal customers
SELECT
    Churn,
    ROUND(AVG(tenure), 2) AS avg_tenure_months
FROM customers
GROUP BY Churn;

-- 3.2 Churn by tenure bucket (new / mid / loyal)
SELECT
    CASE
        WHEN tenure BETWEEN 0  AND 12 THEN '0-12 months (New)'
        WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
        WHEN tenure BETWEEN 25 AND 48 THEN '25-48 months'
        ELSE '48+ months (Loyal)'
    END AS tenure_group,
    COUNT(*)                                                              AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)                       AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- 3.3 Monthly churn trend (if you have signup date)
-- SELECT
--     DATE_FORMAT(signup_date, '%Y-%m') AS month,
--     COUNT(*)                          AS total,
--     SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
-- FROM customers
-- GROUP BY month
-- ORDER BY month;


-- ============================================================
-- SECTION 4 — CHARGES ANALYSIS
-- ============================================================

-- 4.1 Average charges — churned vs loyal
SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2)   AS avg_total_charges
FROM customers
GROUP BY Churn;

-- 4.2 Churn rate by monthly charge range
SELECT
    CASE
        WHEN MonthlyCharges < 30  THEN 'Under $30'
        WHEN MonthlyCharges < 60  THEN '$30 - $60'
        WHEN MonthlyCharges < 90  THEN '$60 - $90'
        ELSE 'Above $90'
    END AS charge_range,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY charge_range
ORDER BY churn_rate DESC;

-- 4.3 Total revenue lost due to churn
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost
FROM customers
WHERE Churn = 'Yes';

-- 4.4 Revenue by contract type
SELECT
    Contract,
    ROUND(SUM(MonthlyCharges), 2)  AS total_monthly_revenue,
    ROUND(AVG(MonthlyCharges), 2)  AS avg_monthly_revenue
FROM customers
GROUP BY Contract
ORDER BY total_monthly_revenue DESC;


-- ============================================================
-- SECTION 5 — SERVICE ANALYSIS
-- ============================================================

-- 5.1 Churn rate by tech support
SELECT
    TechSupport,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY TechSupport;

-- 5.2 Churn rate by online security
SELECT
    OnlineSecurity,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY OnlineSecurity;

-- 5.3 Multiple services vs churn
-- Customers with more services = less likely to churn
SELECT
    (CASE WHEN PhoneService    = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN InternetService != 'No' THEN 1 ELSE 0 END +
     CASE WHEN OnlineSecurity  = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN TechSupport     = 'Yes' THEN 1 ELSE 0 END +
     CASE WHEN StreamingTV     = 'Yes' THEN 1 ELSE 0 END)
                                                                          AS services_count,
    COUNT(*)                                                              AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                          AS churn_rate
FROM customers
GROUP BY services_count
ORDER BY services_count;


-- ============================================================
-- SECTION 6 — HIGH RISK CUSTOMER QUERIES
-- ============================================================

-- 6.1 Find all high risk customers
-- (month-to-month + high charges + low tenure)
SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    InternetService,
    PaymentMethod
FROM customers
WHERE
    Churn          = 'No'
    AND Contract   = 'Month-to-month'
    AND tenure     < 12
    AND MonthlyCharges > 65
ORDER BY MonthlyCharges DESC;

-- 6.2 High risk customers — ranked by risk score
SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    (CASE WHEN Contract      = 'Month-to-month' THEN 3 ELSE 0 END +
     CASE WHEN tenure        < 12               THEN 3 ELSE 0 END +
     CASE WHEN MonthlyCharges > 70              THEN 2 ELSE 0 END +
     CASE WHEN TechSupport   = 'No'             THEN 1 ELSE 0 END +
     CASE WHEN OnlineSecurity = 'No'            THEN 1 ELSE 0 END)
                                                                   AS risk_score
FROM customers
WHERE Churn = 'No'
ORDER BY risk_score DESC
LIMIT 100;

-- 6.3 Customers to call this week (top 20 highest risk)
SELECT
    customerID,
    tenure,
    MonthlyCharges,
    Contract,
    PaymentMethod
FROM customers
WHERE
    Churn            = 'No'
    AND Contract     = 'Month-to-month'
    AND tenure       < 6
    AND MonthlyCharges > 60
ORDER BY MonthlyCharges DESC
LIMIT 20;


-- ============================================================
-- SECTION 7 — BUSINESS SUMMARY DASHBOARD QUERIES
-- ============================================================

-- 7.1 Full executive summary
SELECT
    COUNT(*)                                                               AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)                        AS total_churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
                                                                           AS churn_rate_pct,
    ROUND(AVG(MonthlyCharges), 2)                                          AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS revenue_lost_monthly,
    ROUND(AVG(tenure), 2)                                                  AS avg_tenure_months
FROM customers;

-- 7.2 Churn summary by all key segments
SELECT 'Contract'      AS segment, Contract       AS value,
    COUNT(*)           AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers GROUP BY Contract
UNION ALL
SELECT 'Internet'      AS segment, InternetService AS value,
    COUNT(*)           AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers GROUP BY InternetService
UNION ALL
SELECT 'TechSupport'   AS segment, TechSupport     AS value,
    COUNT(*)           AS total,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers GROUP BY TechSupport
ORDER BY churn_rate DESC;

-- 7.3 Monthly revenue at risk (non-churned high-risk customers)
SELECT
    ROUND(SUM(MonthlyCharges), 2) AS revenue_at_risk
FROM customers
WHERE
    Churn            = 'No'
    AND Contract     = 'Month-to-month'
    AND tenure       < 12;
