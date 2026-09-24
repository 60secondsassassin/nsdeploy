# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Users & Permissions
# ------------------------------------------------------------------------------
adapter_new_user_account() {
    # $1=image_dir  $2=home_dir  $3=comment  $4=user
    adapter_invoke_container_command "${1}" "useradd --user-group --create-home --home-dir \"${2}\" --comment \"${3}\" ${4}"
}

adapter_add_user_group() {
    # $1=image_dir  $2=groups  $3=user
    adapter_invoke_container_command "${1}" "usermod --append --groups ${2} ${3}"
}

adapter_remove_user_group() {
    # $1=image_dir  $2=groups  $3=user
    adapter_invoke_container_command "${1}" "usermod --remove --groups ${2} ${3}"
}

adapter_set_user_password() {
    # $1=image_dir  $2=user  $3=password
    adapter_invoke_container_command "${1}" "printf '%s\n' \"${3}\" \"${3}\" | passwd ${2}"
}
