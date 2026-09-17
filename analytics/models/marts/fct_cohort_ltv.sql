with c as (select * from {{ ref('int_subscription_cohorts') }}),
r as (select user_id,date_trunc('month',paid_at) revenue_month,sum(amount_usd) revenue
from {{ ref('stg_payments') }} group by 1,2),
x as (select c.cohort_month,r.revenue_month,datediff('month',c.cohort_month,r.revenue_month) month_number,
sum(r.revenue) revenue from c join r using(user_id) where r.revenue_month>=c.cohort_month group by 1,2,3),
s as (select cohort_month,count(distinct user_id) customers from c group by 1)
select x.cohort_month,x.month_number,x.revenue,
sum(x.revenue) over(partition by x.cohort_month order by x.month_number)/nullif(s.customers,0) cumulative_ltv_per_customer
from x join s using(cohort_month) order by 1,2