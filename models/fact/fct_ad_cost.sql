WITH T AS (
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,A.adCost
      ,0 AS prevAdCost
  FROM {{ ref('fct_ad_cost_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.dateBegin AND P.dateEnd
 WHERE coalesce(A.adCost, 0) <> 0
 UNION ALL
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,0 AS adCost
      ,A.adCost AS prevAdCost
  FROM {{ ref('fct_ad_cost_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.prevDateBegin AND P.prevDateEnd
 WHERE coalesce(A.adCost, 0) <> 0
)
SELECT idPeriod
      ,countryISOCode
      ,uuidChannel
      ,uuidSourceMedium
      ,uuidCampaign
      ,uuidContent
      ,uuidTerm
      ,SUM(adCost) AS adCost
      ,SUM(prevAdCost) AS prevAdCost
  FROM T
 GROUP BY idPeriod
         ,countryISOCode
         ,uuidChannel
         ,uuidSourceMedium
         ,uuidCampaign
         ,uuidContent
         ,uuidTerm
