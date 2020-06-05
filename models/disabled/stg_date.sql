SELECT Date
  FROM UNNEST(GENERATE_DATE_ARRAY(( {{ get_min_date() }} ), ( {{ get_max_date() }} ), INTERVAL 1 DAY)) AS Date
 ORDER BY Date