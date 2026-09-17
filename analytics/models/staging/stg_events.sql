select cast(event_id as varchar) event_id, cast(user_id as varchar) user_id,
lower(event_name) event_name, cast(event_ts as timestamp_ntz) event_ts,
cast(event_ts as date) activity_date, ingested_at
from {{ source('raw','events') }}