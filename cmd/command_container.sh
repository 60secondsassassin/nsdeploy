# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Container Lifecycle
# ------------------------------------------------------------------------------
command_stop_container_job() {
    # $1=container_name
    facade_stop_container_job "${1}"
}

command_enable_container() {
    # $1=container_name $2=container_state
    adapter_set_container_state "${2}" "${1}"
}

command_disable_container() {
    # $1=container_name
    facade_disable_container_service "${1}"
}

command_remove_container_image() {
    # $1=image_dir $2=container_name
    facade_remove_container_image "${1}" "${2}"
}

command_new_dropin_directory() {
    # ${1}=dropin_directory_path
    adapter_new_directory "${1}"
}

command_remove_dropin_directory() {
    # $1=dropin_directory_path
    facade_remove_directory "${1}"
}
