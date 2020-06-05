{% macro get_max_date() %}

  select cast(max(Date) AS date) from {{ get_big_table_name() }}

{% endmacro %}