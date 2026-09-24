# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Boot manager management
# ------------------------------------------------------------------------------
adapter_new_bootmanager_entry() {
    # $1=image_dir $2=esp_partition_mount_point
    adapter_invoke_container_command "${1}" "bootctl --esp-path=${2} install"
}

adapter_get_bootmanager_entry() {
    # $1=image_dir
    adapter_invoke_container_command "${1}" \
    "efibootmgr | grep "Linux Boot Manager" | cut --delimiter "*" --fields 1 | cut --delimiter "t" --fields 2"
}

adapter_remove_bootmanager_entry() {
    # $1=image_dir $2=bootmanager_entry
    adapter_invoke_container_command "${1}" "efibootmgr --delete-bootnum --bootnum ${2}"
}