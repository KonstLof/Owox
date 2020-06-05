{{
    config(
        unique_key = 'tableName',
    )
}}

SELECT 'dim_campaign' as tableName
      ,(SELECT MAX(idCampaign) FROM {{ ref('dim_campaign') }}) AS currentSequence
 UNION ALL
SELECT 'dim_channel' as tableName
      ,(SELECT MAX(idChannel) FROM {{ ref('dim_channel') }}) AS currentSequence
 UNION ALL
SELECT 'dim_content' as tableName
      ,(SELECT MAX(idContent) FROM {{ ref('dim_content') }}) AS currentSequence
 UNION ALL
SELECT 'dim_source_medium' as tableName
      ,(SELECT MAX(idSourceMedium) FROM {{ ref('dim_source_medium') }}) AS currentSequence
 UNION ALL
SELECT 'dim_term' as tableName
      ,(SELECT MAX(idTerm) FROM {{ ref('dim_term') }}) AS currentSequence
