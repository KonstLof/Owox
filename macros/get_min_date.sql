{% macro get_min_date() %}

  select cast(min(Date) AS date) from {{ get_big_table_name() }}

{% endmacro %}