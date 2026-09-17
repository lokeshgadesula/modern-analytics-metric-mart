{% test max_null_rate(model, column_name, max_rate=0.01) %}
select * from (select count_if({{ column_name }} is null)::float/nullif(count(*),0) null_rate from {{ model }})
where null_rate > {{ max_rate }}
{% endtest %}