# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Apache Modules
# ------------------------------------------------------------------------------
command_enable_apache_module() {
    # ${1}=container_path ${2}=apache_module_list_to_enable
    for apache_module_name in ${2}; do
        [ -z "${2}" ] && continue
        adapter_enable_apache_module "${1}" "$(printf '%s' "${apache_module_name}" | tr --squeeze-repeats'\n\r' ' ')"
    done
}

command_disable_apache_module() {
    # ${1}=container_path ${2}=apache_module_list_to_disable
    for apache_module_name in ${2}; do
        [ -z "${2}" ] && continue
        adapter_disable_apache_module "${1}" "$(printf '%s' "${apache_module_name}" | tr --squeeze-repeats'\n\r' ' ')"
    done
}
