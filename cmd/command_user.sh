# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Users & Permissions
# ------------------------------------------------------------------------------
command_new_user_account() {
    # $1=image_dir $2=user_name|user_comment|user_homepath
    while IFS='|' read -r user_name user_comment user_homepath; do
        [ -z "${user_name}" ] && continue
        adapter_new_user_account "${1}" "${user_homepath}" "${user_comment}" "${user_name}"
    done <<EOF
${2}
EOF
}

command_add_user_group() {
    # $1=image_dir $2=user_name|group_name
    while IFS='|' read -r user_name group_name; do
        [ -z "${user_name}" ] && continue
        adapter_add_user_group "${1}" "${group_name}" "${user_name}"
    done <<EOF
${2}
EOF
}

command_remove_user_group() {
    # $1=image_dir $2=user_name|group_name
    while IFS='|' read -r user_name group_name; do
        [ -z "${user_name}" ] && continue
        adapter_remove_user_group "${1}" "${group_name}" "${user_name}"
    done <<EOF
${2}
EOF
}

