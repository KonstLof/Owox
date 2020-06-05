{% macro get_report_week() %}

  DATE_TRUNC(CURRENT_DATE(), WEEK(SUNDAY))

{% endmacro %}