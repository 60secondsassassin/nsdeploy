# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Container Management
# ------------------------------------------------------------------------------
adapter_get_container_status() {
    # $1=status $2=container_name
    systemctl "${1}" "systemd-nspawn@${2}.service"
}

adapter_set_container_state() {
    # $1=state  $2=container_name
    machinectl "${1}" "${2}"
}

adapter_invoke_container_command() {
    # $1=image_dir  $2=command_string
    systemd-nspawn --directory "${1}" sh -c "${2}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] FACADE - Container Management
# ------------------------------------------------------------------------------
# facade_stop_container_job() {
#     # $1=container_name
#     adapter_get_container_status is-active "${1}" && adapter_stop_container_job stop "${1}" || error
#     return 0
# }

facade_stop_container_job() {
# $1 = container_name
    max=10; count=0
    while adapter_get_container_status is-active "$1"; do
        adapter_set_container_state stop "$1" || return 1

        count=$((count + 1))
        [ "$count" -ge "$max" ] && return 1

        sleep 3
    done
    return 0
}

facade_disable_container_service() {
    # $1=container_name
    adapter_get_container_status is-enabled "${1}" && adapter_set_container_state disable "${1}" || return 1
    return 0
}

facade_remove_container_image() {
    # $1=image_dir  $2=container_name
    adapter_validate_directory "${1}" && adapter_set_container_state remove "${2}" || return 1
    return 0
}
