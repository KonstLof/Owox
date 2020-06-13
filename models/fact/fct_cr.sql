WITH U AS (
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidCampaign
      ,count(distinct A.idUser) as Users
      ,0 AS prevUsers
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.DateBegin AND P.DateEnd
 WHERE A.signupServerSide = 1
 GROUP BY P.idPeriod
         ,A.countryISOCode
         ,A.uuidCampaign
 UNION ALL
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidCampaign
      ,0 as Users
      ,count(distinct A.idUser) AS prevUsers
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.prevDateBegin AND P.prevDateEnd
 WHERE A.signupServerSide = 1
 GROUP BY P.idPeriod
         ,A.countryISOCode
         ,A.uuidCampaign
),
C AS (
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidCampaign
      ,count(distinct A.idClient) as Clients
      ,0 AS prevClients
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.DateBegin AND P.DateEnd
 GROUP BY P.idPeriod
         ,A.countryISOCode
         ,A.uuidCampaign
 UNION ALL
SELECT P.idPeriod
      ,A.countryISOCode
      ,A.uuidCampaign
      ,0 as Clients
      ,count(distinct A.idClient) AS prevClients
  FROM {{ ref('fct_big_table') }} AS A
  JOIN {{ ref('dim_period') }} AS P
    ON A.Date BETWEEN P.prevDateBegin AND P.prevDateEnd
 GROUP BY P.idPeriod
         ,A.countryISOCode
         ,A.uuidCampaign
)
,U1 as (
SELECT idPeriod
      ,countryISOCode
      ,sum(Users) AS Users
      ,sum(prevUsers) AS prevUsers
  FROM U
 GROUP BY idPeriod
         ,countryISOCode
)
,C1 as (
SELECT idPeriod
      ,countryISOCode
      ,sum(Clients) AS Clients
      ,sum(prevClients) AS prevClients
  FROM C
 GROUP BY idPeriod
         ,countryISOCode
)
SELECT U1.idPeriod
      ,U1.countryISOCode
      ,U1.Users
      ,C1.Clients
      ,U1.prevUsers
      ,C1.prevClients
  FROM U1
  JOIN C1
    ON C1.idPeriod = U1.idPeriod
   AND C1.countryISOCode = U1.countryISOCode
