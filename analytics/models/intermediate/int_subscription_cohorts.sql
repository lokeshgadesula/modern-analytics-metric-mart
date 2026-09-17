select user_id,date_trunc('month',min(started_at)) cohort_month
from {{ ref('stg_subscriptions') }} group by 1