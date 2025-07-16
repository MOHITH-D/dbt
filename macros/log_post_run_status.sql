{% macro log_post_run_status() %}
  {% set model_name = this.identifier %}
  {% set run_id = invocation_id %}
  {% set end_time = modules.datetime.datetime.now() %}
  {% set env = target.name %}
  {% set status = 'Success' %}

  {% set result = run_query("SELECT start_time FROM dbt_metadata.temp_start_time WHERE model_name = '" ~ model_name ~ "' AND run_id = '" ~ run_id ~ "'") %}

  {% if result and result.columns and result.columns[0].values() | length > 0 %}
    {% set start_time = result.columns[0].values()[0] %}
    {% set duration = (end_time - start_time).total_seconds() %}
  {% else %}
    {% set start_time = end_time %}
    {% set duration = 0 %}
  {% endif %}

  {% do run_query("
    INSERT INTO dbt_metadata.control_table (
      run_id, model_name, status, start_time, end_time, duration_seconds, row_count, environment, error_message
    ) VALUES (
      '" ~ run_id ~ "', '" ~ model_name ~ "', '" ~ status ~ "',
      '" ~ start_time ~ "', '" ~ end_time ~ "', " ~ duration ~ ",
      NULL, '" ~ env ~ "', NULL
    )
  ") %}
{% endmacro %}
