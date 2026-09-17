select cast(payment_id as varchar) payment_id,cast(user_id as varchar) user_id,
cast(paid_at as date) paid_at,cast(amount_usd as decimal(18,2)) amount_usd,ingested_at
from {{ source('raw','payments') }}