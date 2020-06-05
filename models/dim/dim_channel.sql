{{
    config(
        unique_key = 'Channel' 
    )
}}

WITH A AS (
SELECT 'Unknown' AS Channel
 UNION DISTINCT
SELECT Channel
  FROM {{ ref('stg_channel') }}
)
SELECT GENERATE_UUID() as uuidChannel
      ,Channel
  FROM A
