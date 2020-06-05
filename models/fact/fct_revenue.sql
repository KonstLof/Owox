WITH T AS (
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,A.transactionRevenue AS Revenue
      ,0 AS prevRevenue
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.dateBegin AND P.dateEnd
 WHERE coalesce(A.transactionRevenue, 0) <> 0
 UNION ALL
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,0 AS Revenue
      ,A.transactionRevenue AS prevRevenue
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.prevDateBegin AND P.prevDateEnd
 WHERE coalesce(A.transactionRevenue, 0) <> 0
)
SELECT idPeriod
      ,countryISOCode
      ,uuidChannel
      ,uuidSourceMedium
      ,uuidCampaign
      ,uuidContent
      ,uuidTerm
      ,SUM(Revenue) AS Revenue
      ,SUM(prevRevenue) AS prevRevenue
  FROM T
 GROUP BY idPeriod
         ,countryISOCode
         ,uuidChannel
         ,uuidSourceMedium
         ,uuidCampaign
         ,uuidContent
         ,uuidTerm
