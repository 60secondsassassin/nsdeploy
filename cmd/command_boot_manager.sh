# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Boot manager management
# ------------------------------------------------------------------------------
command_install_bootmanager() {
    # $1=image_dir $2=esp_partition_mount_point
    adapter_new_bootmanager_entry "${1}" "${2}"
}

command_remove_bootmanager_entry() {
    # $1=image_dir
    for entry in $(adapter_get_bootmanager_entry "${1}"); do
        adapter_remove_bootmanager_entry "${1}" "${entry}"
    done
}
