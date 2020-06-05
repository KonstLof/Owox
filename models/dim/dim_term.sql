{{
    config(
        unique_key = 'Term' 
    )
}}

WITH A AS (
SELECT 'Unknown' AS Term
 UNION DISTINCT
SELECT Term
  FROM {{ ref('stg_term') }}
)
SELECT GENERATE_UUID() as uuidTerm
      ,Term
  FROM A
