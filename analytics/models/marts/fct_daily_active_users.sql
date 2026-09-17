select activity_date,count(distinct user_id) daily_active_users
from {{ ref('int_user_activity') }} group by 1 order by 1