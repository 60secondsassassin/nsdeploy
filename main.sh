#!/bin/sh

# ------------------------------------------------------------------------------
# [COMPORTEMENT] TEMPLATE METHOD
# ------------------------------------------------------------------------------
method_new_image() {
    # $1=container_name
    command_stop_container_job "${1}"
    command_disable_container "${1}"
    command_remove_container_image "${1}"
    command_remove_dropin_directory "${1}"
#     command_initialize_container_subvolume_snapshot "${1}"
    command_initialize_container_subvolume "${1}"
    command_update_zypper_repository "${1}"
    command_install_rpm_package "${1}"
    command_uninstall_rpm_package "${1}"
    command_expand_archive_content "${1}"
    command_new_dropin_directory "${1}"
    method_edit_image "${1}"
}

method_edit_image() {
    # $1=container_name
    command_stop_container_job "${1}"
    command_set_default_target "${1}"
    command_enable_service "${1}"
    command_disable_service "${1}"
    command_new_configuration_directory "${1}"
    command_remove_configuration "${1}"
    command_enable_apache_module "${1}"
    command_disable_apache_module "${1}"
    command_set_user_permission "${1}"
    command_new_user_account "${1}"
    command_set_hostname "${1}"
    command_new_configuration "${1}"
    command_set_configuration "${1}"
    command_new_nspawn_file "${1}"
    command_set_volume_configuration "${1}"
    command_enable_container "${1}"
}

main() {
    # $1=option  $2=container_name
    ENVIRONEMENT_PATH=$(cd "$(dirname "${0}")" && pwd)

    while read -r source; do
        source "${source}"
    done <<EOF
$(find "${ENVIRONEMENT_PATH}" -mindepth 2 -type f -name "*.sh")
EOF

    cor_validate_root_permission

    IMAGE_NAME="${2}"

    global_environment_file=$(find "${ENVIRONEMENT_PATH}/env/" -maxdepth 1 -type f -name "*.env" | head -n 1)

    
    cor_validate_global_variable "${global_environment_file}"
    source "${global_environment_file}"

    set -x

    [ -f "${LOG_FILE}" ] && mv "${LOG_FILE}" "${LOG_FILE}.old"

    cor_validate_container_variable "${IMAGE_NAME}"
    source "${ENVIRONEMENT_PATH}/machines/${IMAGE_NAME}/${IMAGE_NAME}.env"

    strategy_set_strategy "${1}" "${2}" || command_show_usage
}

# ------------------------------------------------------------------------------
# Lancement
# ------------------------------------------------------------------------------
main "${1}" "${2}"

