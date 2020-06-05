{{ config(materialized = 'table') }}

SELECT P.*
      ,case P.idPeriod
         when 1 then DATE_SUB(P.dateBegin, INTERVAL 1*7 DAY)
         when 2 then DATE_SUB(P.dateBegin, INTERVAL 2*7 DAY)
         when 3 then DATE_SUB(P.dateBegin, INTERVAL 4*7 DAY)
         when 4 then DATE_SUB(P.dateBegin, INTERVAL 12*7 DAY)
         when 5 then DATE_SUB(P.dateBegin, INTERVAL 24*7 DAY)
         when 6 then DATE_TRUNC(DATE_SUB(P.dateBegin, INTERVAL 1 DAY), MONTH)
         when 7 then DATE_TRUNC(DATE_SUB(P.dateBegin, INTERVAL 1 DAY), MONTH)
         when 8 then DATE_SUB(P.dateBegin, INTERVAL 3 MONTH)
         when 9 then DATE_SUB(P.dateBegin, INTERVAL 3 MONTH)
         when 10 then DATE_SUB(P.dateBegin, INTERVAL 3 MONTH)
         when 11 then DATE_SUB(P.dateBegin, INTERVAL 3 MONTH)
         when 12 then DATE_SUB(DATE_SUB(P.dateBegin, INTERVAL 1 DAY), INTERVAL DATE_DIFF(P.dateEnd, P.dateBegin, DAY) DAY)
         when 13 then P.dateBegin
        end as prevDateBegin
      ,case P.idPeriod
         when 7 then DATE_SUB(P.dateEnd, INTERVAL 1 MONTH)
         when 13 then P.dateEnd
         else DATE_SUB(P.dateBegin, INTERVAL 1 DAY)
        end as prevDateEnd
  FROM {{ ref('stg_period') }} AS P
 ORDER BY P.idPeriod
 