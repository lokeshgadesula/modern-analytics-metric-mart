# Modern Analytics Platform & Metric Mart

Complete portfolio reference project for **Snowflake + dbt + Dagster**.

## Architecture
`Snowflake RAW -> Dagster assets -> dbt staging -> intermediate -> marts -> tests/alerts`

Metric marts:
- Daily Active Users
- Subscription cohort retention
- Cohort lifetime value (realized cumulative revenue/customer)

Quality:
- dbt source freshness
- unique/not-null schema tests
- custom `max_null_rate` generic test
- Slack webhook alert helper
- CI metric tests

## Local verification
```bash
python -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
pytest -q
```

## Snowflake/dbt/Dagster
```bash
pip install -e ".[stack]"
cp .env.example .env
dbt build --project-dir analytics --profiles-dir analytics
dagster dev -m orchestration.definitions
```

