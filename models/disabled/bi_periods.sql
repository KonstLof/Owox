{{
    config (
        materialized = 'table',
    )
}}

WITH P2 AS (
SELECT L.Period
      ,cast(D.Date as timestamp) as Date
      ,P.iDperiod as Sort
      ,P.dateBegin
      ,P.dateEnd
  FROM {{ ref('stg_date') }} AS D
  JOIN {{ ref('stg_period') }} AS P
    ON D.Date between P.dateBegin and P.dateEnd
  JOIN {{ ref('dim_period_list') }} AS L
    ON L.idPeriod = P.idPeriod
 WHERE L.idPeriod between 1 and 12
)
SELECT P2.*
      ,CONCAT(P2.Period, ' (', FORMAT_DATE('%Y-%m-%d', P2.DateBegin), ' - ', FORMAT_DATE('%Y-%m-%d', P2.DateEnd), ')') as periodLabel
  FROM P2
 ORDER BY P2.Sort
         ,P2.Date
