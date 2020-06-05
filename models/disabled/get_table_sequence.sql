{% macro _get_table_sequence(tableName) %}

SELECT currentSequence
  FROM {{ ref('dim_sequence') }}
 WHERE tableName = {{ tableName }}

{% endmacro %}