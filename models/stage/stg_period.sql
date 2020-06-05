WITH P AS (
SELECT 1 AS idPeriod, DATE_SUB({{ get_report_week() }}, INTERVAL 1*7-1 DAY) AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 2 AS idPeriod, DATE_SUB( {{ get_report_week() }}, INTERVAL 2*7-1 DAY) AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 3 AS idPeriod, DATE_SUB( {{ get_report_week() }}, INTERVAL 4*7-1 DAY) AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 4 AS idPeriod, DATE_SUB( {{ get_report_week() }}, INTERVAL 12*7-1 DAY) AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 5 AS idPeriod, DATE_SUB( {{ get_report_week() }}, INTERVAL 24*7-1 DAY) AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 6 AS idPeriod, DATE_TRUNC(DATE_SUB({{ get_report_month() }}, INTERVAL 1 DAY), MONTH) AS dateBegin, DATE_SUB({{ get_report_month() }}, INTERVAL 1 DAY) AS dateEnd
 UNION ALL
SELECT 7 AS idPeriod, {{ get_report_month() }} AS dateBegin, {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 8 AS idPeriod, {{ get_report_year() }} AS dateBegin, LEAST(DATE_SUB(DATE_ADD({{ get_report_year() }}, INTERVAL 1 QUARTER), INTERVAL 1 DAY), {{ get_report_week() }}) AS dateEnd
 UNION ALL
SELECT 9 AS idPeriod, DATE_ADD({{ get_report_year() }}, INTERVAL 1 QUARTER) AS dateBegin, DATE_SUB(DATE_ADD( {{ get_report_year() }}, INTERVAL 2 QUARTER), INTERVAL 1 DAY) AS dateEnd
 UNION ALL
SELECT 10 AS idPeriod, DATE_ADD({{ get_report_year() }}, INTERVAL 2 QUARTER) AS dateBegin, DATE_SUB(DATE_ADD( {{ get_report_year() }}, INTERVAL 3 QUARTER), INTERVAL 1 DAY) AS dateEnd
 UNION ALL
SELECT 11 AS idPeriod, DATE_ADD({{ get_report_year() }}, INTERVAL 3 QUARTER) AS dateBegin, DATE_SUB(DATE_ADD( {{ get_report_year() }}, INTERVAL 4 QUARTER), INTERVAL 1 DAY) AS dateEnd
 UNION ALL
SELECT 12 AS idPeriod, {{ get_report_year() }} AS dateBegin,  {{ get_report_week() }} AS dateEnd
 UNION ALL
SELECT 13 AS idPeriod, ({{ get_min_date() }}) AS dateBegin,  ({{ get_max_date() }}) AS dateEnd
)
SELECT P.idPeriod
      ,P.dateBegin
      ,LEAST(P.dateEnd, {{ get_report_week() }}) AS dateEnd
  FROM P
 WHERE P.dateBegin <= {{ get_report_week() }}
    OR P.dateEnd <= {{ get_report_week() }}
 ORDER BY P.idPeriod