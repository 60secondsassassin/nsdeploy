# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Volume Management
# ------------------------------------------------------------------------------
command_set_container_binding_configuration() {
    # $1=config_file_path  $2=volume_source|volume_target
    while IFS='|' read -r volume_source volume_target; do
        [ -z "${volume_source}" ] && continue
        facade_set_container_binding_configuration "${volume_source}" "${volume_target}" "${1}"
    done <<EOF
${2}
EOF
}
