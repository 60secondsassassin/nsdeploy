# ------------------------------------------------------------------------------
# [COMPORTEMENT] TEMPLATE METHOD
# ------------------------------------------------------------------------------
envir() {
    # $1=image_name
    SCRIPT_DIR="$(dirname "${0}")"

    if [ -f "${SCRIPT_DIR}/machines/${1}/${1}.env" ]; then
        . "${SCRIPT_DIR}/machines/${1}/${1}.env"
    fi

    for file in "${SCRIPT_DIR}/cmd"/*.sh; do
        [ -f "${file}" ] && . "${file}"
    done

    for file in "${SCRIPT_DIR}/lib"/*.sh; do
        [ -f "${file}" ] && . "${file}"
    done

    for file in "${SCRIPT_DIR}/env"/*.env; do
        [ -f "${file}" ] && . "${file}"
    done
}

main() {
    # ${1}=image_name ${2}=disk_path
    envir "${1}"

    mac_address="$(adapter_get_network_device_mac_address)"
    p="$(command_set_partition_prefix "${2}")"
    work_directory="$(adapter_new_temporary_directory "${TEMPORARY_DIRECTORY_PREFIX}")"

    command_remove_disk_mount "${2}${p}"

    command_remove_disk_partition "${2}"

    command_new_partition_table "${2}" "${PARTITION_TABLE_TYPE}"

    command_new_partition "${2}" "${DISK_PARTITION}"

    command_set_partition_flag "${2}" "${PARTITION_FLAG}"

    command_initialize_partition "${2}${p}" "${DISK_PARTITION}"

    command_add_partition_mount "${2}${p}" "2|${work_directory}"

    command_new_subvolume "${work_directory}" "${SUBVOLUME_PATH}"



}

main my_image /dev/sdx