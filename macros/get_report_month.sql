{% macro get_report_month() %}

  DATE_TRUNC({{ get_report_week() }}, MONTH)

{% endmacro %}