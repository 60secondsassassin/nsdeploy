# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Config Management
# ------------------------------------------------------------------------------
adapter_write_configuration_file() {
    # $1=image_dir  $2=config_path  $3=config_mode  $4=config_user  $5=config_group  $6=config_content
    # adapter_invoke_container_command "${1}" "printf '%s' \"${6}\" | tail -n +2 | tee \"${2}\""
    adapter_invoke_container_command "${1}" "printf '%s' \"${6}\" | tee \"${2}\""
}

adapter_update_configuration_line() {
    # $1=image_dir  $2=old_value  $3=new_value  $4=file_path
    adapter_invoke_container_command "${1}" "grep -Fq \"${3}\" \"${4}\" || sed -i 's@${2}@${3}@g' \"${4}\""
}

adapter_remove_configuration_line() {
    # $1=image_dir  $2=config_value  $3=file_path
    adapter_invoke_container_command "${1}" "grep -v \"${2}\" \"${3}\" | tee \"${3}\".temp >/dev/null && mv \"${3}\".temp \"${3}\""
}

adapter_set_hostname() {
    # $1=image_dir  $2=hostname $3=hostname_file
    adapter_invoke_container_command "${1}" "printf '%s' ${2} | tee \"${3}\""
}

adapter_new_directory_inside_image() {
    # $1=image_dir  $2=user  $3=group  $4=mode  $5=path
    adapter_invoke_container_command "${1}" "install -d -o ${2} -g ${3} -m ${4} \"${5}\""
}

adapter_new_nspawn_file() {
    # $1=nspawn_template_content $2=container_nspawn_file
    printf '%s' "${1}" | tee "${2}"
}

adapter_copy_nspawn_file() {
    # $1=template_nspawn_file $2=container_nspawn_file
    cp --reflink "${1}" "${2}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] FACADE - New config files
# ------------------------------------------------------------------------------
facade_write_configuration_file() {
    # $1=image_dir $2=config_dir $3=file_extension
    files="$(adapter_search_file "${2}" "${3}")"
    [ -n "${files}" ] || return 1

    for file in ${files}; do
        facade_read_configuration_file "${1}" "${file}"
    done
    return 0
}

facade_read_configuration_file() {
    # $1=image_dir $2=file_path
    IFS='|' read -r config_path config_mode config_user config_group < "${2}"
    config_content=$(tail -n +2 "${2}")
    adapter_write_configuration_file "${1}" "${config_path}" "${config_mode}" "${config_user}" "${config_group}" "${config_content}"
}
