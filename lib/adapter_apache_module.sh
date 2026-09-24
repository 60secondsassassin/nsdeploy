# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Apache module management
# ------------------------------------------------------------------------------
adapter_enable_apache_module() {
    # $1=image_dir  $2=module_name
    adapter_invoke_container_command "${1}" "a2enmod ${2}"
}

adapter_disable_apache_module() {
    # $1=image_dir  $2=module_name
    adapter_invoke_container_command "${1}" "a2dismod ${2}"
}
