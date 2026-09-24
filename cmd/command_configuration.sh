# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Config Management
# ------------------------------------------------------------------------------
command_write_configuration_file() {
    # ${1}=container_config_path ${2}=container_path ${3}=config_file_extension
    facade_write_configuration_file "${1}" "${2}" "${3}"
    return 0
}

command_update_configuration_line() {
    # ${1}=container_path ${2}=file_path|old_config_value|new_config_value
    while IFS='|' read -r file_path old_config_value new_config_value; do
        [ -z "${file_path}" ] && continue
        adapter_update_configuration_line "${1}" "${old_config_value}" "${new_config_value}" "${file_path}"
    done <<EOF
${2}
EOF
}

command_remove_configuration_line() {
    # ${1}=remove_config_value ${2}=container_name
    while IFS='|' read -r file_path config_value; do
        [ -z "${file_path}" ] && continue
        adapter_remove_configuration_line "${2}" "${config_value}" "${file_path}"
    done <<EOF
${1}
EOF
}

command_new_directory_inside_image() {
    # $1=container_path  $2=directory_path|directory_mode|user_name|group_name
    while IFS='|' read -r directory_path directory_mode user_name group_name; do
        [ -z "${directory_path}" ] && continue
        adapter_new_directory_inside_image "${1}" "${user_name}" "${group_name}" "${directory_mode}" "${directory_path}"
    done <<EOF
${2}
EOF
}

command_new_nspawn_file() {
    # $1=container_name $2=template_name $3=nspawn_config_dir $4=nspawn_template_content
    if [ "${1}" = "${2}" ]; then
        adapter_new_nspawn_file "${4}" "${3}/${1}.nspawn"
    else
        adapter_copy_nspawn_file "${3}/${2}.nspawn" "${3}/${1}.nspawn"
    fi
    return 0
}

command_set_hostname() {
    # $1=image_dir $2=container_hostname $3=hostname_file
    adapter_set_hostname "${1}" "${2}" "${3}"
}
