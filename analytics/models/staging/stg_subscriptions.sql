select cast(subscription_id as varchar) subscription_id,cast(user_id as varchar) user_id,
cast(started_at as date) started_at,cast(ended_at as date) ended_at,lower(status) status,ingested_at
from {{ source('raw','subscriptions') }}