with c as (select * from {{ ref('int_subscription_cohorts') }}),
a as (select distinct user_id,date_trunc('month',activity_date) activity_month from {{ ref('int_user_activity') }}),
x as (select c.cohort_month,a.activity_month,c.user_id,
datediff('month',c.cohort_month,a.activity_month) month_number from c join a using(user_id)
where a.activity_month>=c.cohort_month),
s as (select cohort_month,count(distinct user_id) cohort_size from c group by 1)
select x.cohort_month,x.month_number,count(distinct x.user_id) retained_users,s.cohort_size,
count(distinct x.user_id)::float/nullif(s.cohort_size,0) retention_rate
from x join s using(cohort_month) group by 1,2,4 order by 1,2