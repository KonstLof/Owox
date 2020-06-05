{% macro get_report_year() %}

  DATE_TRUNC({{ get_report_week() }}, YEAR)

{% endmacro %}