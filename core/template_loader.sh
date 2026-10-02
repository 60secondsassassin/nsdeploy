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

template_physical() {
    # ${1}=image_name ${2}=disk_path
    if [ "$#" -ne 2 ]; then
        printf '%s\n' "Usage: template_physical image_name disk_path" >&2
        return 2
    fi

    envir "${1}"

    partition_prefix="$(command_set_partition_prefix "${2}")"
    work_directory="$(adapter_new_temporary_directory "${TEMPORARY_DIRECTORY_PREFIX}")"

    command_remove_disk_mount "${2}${partition_prefix}" || return 1

    command_remove_disk_partition "${2}" || return 1

    command_new_partition_table "${2}" "${PARTITION_TABLE_TYPE}" || return 1

    command_new_partition "${2}" "${DISK_PARTITION}" || return 1

    command_set_partition_flag "${2}" "${PARTITION_FLAG}" || return 1

    command_initialize_partition "${2}${partition_prefix}" "${DISK_PARTITION}" || return 1

    command_add_partition_mount "${2}${partition_prefix}${ROOT_PARTITION_NUMBER}" "${work_directory}" || return 1

    command_set_subvolume_compression "${work_directory}" "${SUBVOLUME_COMPRESSION_ALGORITHM}" || return 1

    command_new_subvolume "${work_directory}" "${SUBVOLUME}" || return 1

    command_update_zypper_repository || return 1

    command_install_rpm_package "${work_directory}" "${BASE_RPM_PACKAGE}" || return 1

    command_add_directory_bind_mount "${work_directory}" "${BIND_MOUNT_DIRECTORY}" || return 1

    command_add_partition_mount "${2}${partition_prefix}" "${DISK_PARTITION_MOUNT}" || return 1

    if [ "${GRAPHICAL_TARGET}" = "true" ]; then
        command_install_rpm_package "${work_directory}" "${GRAPHICAL_RPM_PACKAGE}" || return 1
        command_install_rpm_package_language "${work_directory}" || return 1
    fi



}