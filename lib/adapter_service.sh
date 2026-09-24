# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — In container Service Management
# ------------------------------------------------------------------------------
adapter_enable_service() {
    # $1=image_dir  $2=service_name
    adapter_invoke_container_command "${1}" "systemctl enable ${2}"
}

adapter_disable_service() {
    # $1=image_dir  $2=service_name
    adapter_invoke_container_command "${1}" "systemctl disable ${2}"
}

adapter_set_default_target() {
    # $1=image_dir  $2=target
    adapter_invoke_container_command "${1}" "systemctl set-default ${2}.target"
}
