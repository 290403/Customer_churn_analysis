--Customer churn prediction analysis project insights

--1. Revenue Lost due to churn
--total amount of money is losing because customers leave.
select sum(monthlycharges) as revenue_lost
from customer_churn
where churn='Yes'

--2.High Value customers who are likely to churn

select CustomerID, MonthlyCharges, Tenure
from customer_churn
where churn='Yes'
order by MonthlyCharges desc
--business impact : company can target high risk customers with discounts or special offers.

--3.Contract type with highest churn
select contract, 
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2)as churn_rate
from customer_churn
group by contract
--month to month contract type customers are leaving the most.
---business impact : month to month customer churn more, so company can offer annual plans , give renewal disocunts.

4.--Which customers generate the most value?
select contract, round(avg(monthlycharges*tenure),2)as avg_clv
from customer_churn
group by contract

--5.Whcih services make customers stay longer?
select OnlineSecurity
, round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate
from customer_churn
group by OnlineSecurity

--6.payment methods associated with high churn
select paymentmethod,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2) as churn_rate
from customer_churn
group by paymentmethod
--Company can encourage customers to switch to payment methods with lower churn.

--7.Customer segmentation
select case when Tenure<=12 then 'New' else 'Old' end as customer_group,
round(100*sum(case when churn='Yes' then 1 else 0 end)/count(*),2)as churn_rate
from customer_churn
group by customer_group
--company can improve the first few months of cusotmer experience

--8.revenue by churn segment
select churn, sum(monthlycharges)as revenue
from customer_churn
group by churn

--it will help in estimating how much revenue can be saved through retention campaigns.

--9.top reasons behind churn(segmentation)
select contract, internetservice, techsupport , count(*) as customers
from customer_churn where churn = 'Yes'
group by contract , internetservice, techsupport
order by customers desc

--10.Customers eligible for retention campaign
SELECT CustomerID,
       MonthlyCharges,
       Contract
FROM customers
WHERE Contract='Month-to-month'
AND Tenure < 12
AND MonthlyCharges >
(
    SELECT AVG(MonthlyCharges)
    FROM customers
);