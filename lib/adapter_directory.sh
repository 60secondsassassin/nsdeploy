# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — File management
# ------------------------------------------------------------------------------
adapter_get_file_name() {
    # $1=path
    printf '%s' "$(basename "${1}")"
}

adapter_validate_file() {
    # $1=file_path
    [ -f "${1}" ]
}

adapter_search_file() {
    # $1=file_directory_path $2=file_extension
    find "${1}" -maxdepth 1 -type f -name "*.${2}" 2>>"$LOG_FILE"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Directory management
# ------------------------------------------------------------------------------
adapter_get_directory_path() {
    # $1=path
    printf '%s' "$(cd "$(dirname "${1}")" && pwd)"
}

adapter_validate_directory() {
    # $1=directory_path
    [ -d "${1}" ]
}

adapter_new_directory() {
    # $1=directory_path
    mkdir --parents "${1}"
}

adapter_new_temporary_directory() {
    # $1=directory_prefix
    mktemp --tmpdir --directory "${1}".XXXXXX
}

adapter_remove_directory_acl() {
    # $1=directory_path
    setfacl -Rbn "${1}"
}

adapter_set_directory_default_acl() {
    # $1=permissions $2=directory_path
    setfacl -Rdm "${1}" "${2}"
}

adapter_set_directory_no_cow() {
    # $1=directory_path
    chattr +C "${1}"
}

adapter_remove_directory() {
    # $1=directory_path
    rm -R "${1}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] FACADE
# ------------------------------------------------------------------------------
facade_remove_directory() {
    # $1=dropin_dir
    adapter_validate_directory "${1}" && adapter_remove_directory "${1}" || return 1
    return 0
}
