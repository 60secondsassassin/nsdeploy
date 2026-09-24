# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Session & Services
# ------------------------------------------------------------------------------
command_set_container_default_target() {
    # $1=image_dir  $2=session_type
    adapter_set_default_target "${1}" "${2}"
}

command_enable_service() {
    # $1=image_dir $2=service_name
    adapter_enable_service "${1}" "$(printf '%s' "${2}" | tr --squeeze-repeats '\n\r' ' ')"
}

command_disable_service() {
    # $1=image_dir $2=service_name
    adapter_disable_service "${1}" "$(printf '%s' "${2}" | tr --squeeze-repeats '\n\r' ' ')"
}
