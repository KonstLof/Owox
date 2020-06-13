{% macro get_load_end() %}

  cast(if( {{ var('end_date') }} = '1900-01-01', {{ get_report_week() }}, {{ var('end_date') }}) as date)

{% endmacro %}