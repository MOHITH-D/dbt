{% macro set_start_time() %}
  {% set model_name = this.identifier %}
  {% set run_id = invocation_id %}
  {% set start_time = modules.datetime.datetime.now() %}

  {% do run_query("DELETE FROM dbt_metadata.temp_start_time WHERE model_name = '" ~ model_name ~ "' AND run_id = '" ~ run_id ~ "'") %}
  {% do run_query("INSERT INTO dbt_metadata.temp_start_time (model_name, run_id, start_time) VALUES ('" ~ model_name ~ "', '" ~ run_id ~ "', '" ~ start_time ~ "')") %}
{% endmacro %}
