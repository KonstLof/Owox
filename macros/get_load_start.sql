{% macro get_load_start() %}

  cast(if( {{ var('start_date') }} = '1900-01-01', DATE_SUB({{ get_report_week() }}, INTERVAL 6 DAY), {{ var('start_date') }}) as date)

{% endmacro %}