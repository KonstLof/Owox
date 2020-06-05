WITH T AS (
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,1 as signUp
      ,0 AS prevSignUp
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.dateBegin AND P.dateEnd
 WHERE A.signupServerSide = 1
 UNION ALL
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidChannel
      ,A.uuidSourceMedium
      ,A.uuidCampaign
      ,A.uuidContent
      ,A.uuidTerm
      ,0 as signUp
      ,1 AS prevprevSignUp
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.prevDateBegin AND P.prevDateEnd
 WHERE A.signupServerSide = 1
)
SELECT idPeriod
      ,countryISOCode
      ,uuidChannel
      ,uuidSourceMedium
      ,uuidCampaign
      ,uuidContent
      ,uuidTerm
      ,SUM(signUp) AS signUp
      ,SUM(prevSignUp) AS prevSignUp
  FROM T
 GROUP BY idPeriod
         ,countryISOCode
         ,uuidChannel
         ,uuidSourceMedium
         ,uuidCampaign
         ,uuidContent
         ,uuidTerm
