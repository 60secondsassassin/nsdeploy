# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Mount Management
# ------------------------------------------------------------------------------
command_remove_disk_mount() {
    # ${1}=disk_path
    facade_remove_disk_mount "${1}"
}

command_add_partition_mount() {
    # ${1}=partition_path ${2}=partition_num|mount_path
    while read -r part_num mount_path; do
        partuuid=$(adapter_get_partition_identifier "${1}${part_num}")
        adapter_add_partition_mount "${partuuid}" "${mount_path}"
    done <<EOF
${2}
EOF
}

command_add_directory_bind_mount() {
    # ${1}=work_directory ${2}=source_dir|mount_path
    while read -r source_dir mount_path; do
        adapter_add_directory_bind_mount "${source_dir}" "${1}/${mount_path}"
    done <<EOF
${2}
EOF
}

# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Disk Management
# ------------------------------------------------------------------------------
command_remove_disk_partition() {
    # ${1}=disk_path
    adapter_remove_partition_table "${1}" || return 1
    adapter_get_disk_type "${1}" && adapter_remove_disk_content "${1}"
    return 0
}

command_new_partition_table() {
    # ${1}=disk_path ${2}=partition_table_type
    adapter_new_partition_table "${1}" "${2}"
}

command_set_partition_prefix() {
    # ${1}=disk_path
    case "${1}" in
        /dev/[shv]d[a-z]*)
            printf "%s" ""
            ;;
        *)
            printf "%s" "p"
            ;;
    esac
}

# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Partition Management
# ------------------------------------------------------------------------------
command_new_partition() {
    # ${1}=disk_path ${2}=part_num|part_type|part_label|part_start|part_end
    while read -r part_num part_type part_label part_start part_end; do
        adapter_new_partition "${1}" "${part_start}" "${part_end}"
    done <<EOF
${2}
EOF
}

command_set_partition_flag() {
    # ${1}=disk_path ${2}=part_num
    adapter_set_partition_flag "${1}" "${2}"
}

# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Filesystem Management
# ------------------------------------------------------------------------------
command_initialize_partition() {
    # ${1}=partition_path ${2}=part_num|part_type|part_label|part_start|part_end
    while read -r part_num part_type part_label part_start part_end; do
        case "${part_type}" in
            vfat)
                adapter_initialize_partition_vfat "${1}${part_num}" "${part_label}"
                ;;
            btrfs)
                adapter_initialize_partition_btrfs "${1}${part_num}" "${part_label}"
                ;;
            swap) 
                adapter_initialize_partition_swap "${1}${part_num}" "${part_label}"
                ;;
            *)
                return 1
                ;;
        esac
    done <<EOF
${2}
EOF
}


# ciph:~ # echo $(( $(sfdisk --show-size /dev/nvme0n1) - $(grep MemTotal /proc/meminfo | tr -dc '0-9') ))
