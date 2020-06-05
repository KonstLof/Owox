SELECT DISTINCT sourceMedium
  FROM {{ ref('stg_ad_cost') }}
 UNION DISTINCT
SELECT DISTINCT sourceMedium
  FROM {{ ref('stg_big_table') }}
