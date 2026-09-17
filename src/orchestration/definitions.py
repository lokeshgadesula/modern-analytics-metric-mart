from pathlib import Path
try:
 from dagster import Definitions,asset
 from dagster_dbt import DbtCliResource,dbt_assets
except ImportError as e: raise RuntimeError('pip install -e ".[stack]"') from e
PROJECT=Path(__file__).resolve().parents[2]/"analytics"
@asset(group_name="ingestion")
def raw_snowflake_sources(): return {"status":"ready"}
@dbt_assets(manifest=PROJECT/"target"/"manifest.json")
def metric_assets(context,dbt:DbtCliResource):
 yield from dbt.cli(["build"],context=context).stream()
defs=Definitions(assets=[raw_snowflake_sources,metric_assets],
 resources={"dbt":DbtCliResource(project_dir=str(PROJECT),profiles_dir=str(PROJECT))})
