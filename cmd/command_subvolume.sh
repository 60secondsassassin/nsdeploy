# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Snapshot & Subvolume
# ------------------------------------------------------------------------------
command_new_subvolume() {
    # ${1}=subvol_dir
    adapter_new_subvolume "${1}"
}

command_set_subvolume_compression() {
    # ${1}=subvol_dir, ${2}=compression_algorithm
    adapter_set_subvolume_compression "${1}" "${2}"
}

command_set_subvolume_nocow() {
    # ${1}=subvol_dir
    adapter_set_directory_no_cow "${1}"
}

command_new_subvolume_snapshot() {
    # ${1}=image_dir ${2}=template_dir
    adapter_new_subvolume_snapshot "${1}"
}

command_new_container_subvolume() {
    # ${1}=image_dir ${2}=template_dir
    if [ "${1}" = "${2}" ]; then
        adapter_new_subvolume_snapshot "${1}" "${2}"
    else
        adapter_new_subvolume "${1}"
    fi
}

command_new_swapfile() {
    # ${2}=swapfile_path
    adapter_new_swapfile "$(adapter_get_memory_size)" "${2}"
}