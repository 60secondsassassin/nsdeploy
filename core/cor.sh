# ------------------------------------------------------------------------------
# [COMPORTEMENT] CHAIN OF RESPONSIBILITY
# ------------------------------------------------------------------------------
cor_validate_global_variable() {
    # $1=global_env_file
    [ -f "${1}" ] || error "Fichier global .env introuvable"
}

cor_validate_container_variable() {
    # $1=container_name
    [ -n "${1}" ] || print_usage

    machine_environment_file="${ENVIRONEMENT_PATH}/machines/${1}/${1}.env"
    [ -f "${machine_environment_file}" ] || error "Container .env introuvable : ${machine_environment_file}"
}

cor_validate_root_permission() {
    id --groups --name | grep root || error "Vous devez disposez d'un accès root"
}
