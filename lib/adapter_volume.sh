# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Volume
# ------------------------------------------------------------------------------
adapter_get_container_binding_configuration() {
    # $1=source  $2=target  $3=nspawn_file
    grep --fixed-strings --quiet Bind=${1}:${2} ${3}
}

adapter_set_container_binding_configuration() {
    # $1=source  $2=target  $3=nspawn_file
    sed -i "/\[Files\]/a Bind=${1}:${2}" "${3}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] FACADE - Volume
# ------------------------------------------------------------------------------
facade_set_container_binding_configuration() {
    # $1=source  $2=target  $3=nspawn_file
    adapter_get_container_binding_configuration "${1}" "${2}" "${3}" || \
        adapter_set_container_binding_configuration "${1}" "${2}" "${3}" || return 1
    return 0
}
