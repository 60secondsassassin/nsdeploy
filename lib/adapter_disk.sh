# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Mount Management
# ------------------------------------------------------------------------------
adapter_get_disk_mount() {
    # $1=disk_path
    # findmnt --source "${1}" --noheadings --output TARGET
    grep --extended-regexp " - .+ ${1}[1-9][0-9]* " /proc/self/mountinfo | cut --delimiter=" " --fields=5
}

adapter_remove_disk_mount() {
    # $1=mount_point
    umount --recursive --force "${1}"
}

adapter_add_partition_mount() {
    # $1=partuuid $2=mount_point
    mount PARTUUID="${1}" "${2}"
}

adapter_add_directory_bind_mount() {
    # $1=source_dir $2=mount_point
    mount --bind "${1}" "${2}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] FACADE — Mount Management
# ------------------------------------------------------------------------------
facade_remove_disk_mount() {
    # $1=disk_path
    max=10; count=0
    while adapter_get_disk_mount "${1}"; do
        for disk_mount in $(adapter_get_disk_mount "${1}"); do
            adapter_remove_disk_mount "${disk_mount}"
        done
        count=$((count + 1))
        [ "$count" -ge "$max" ] && return 1
        sleep 3
    done
    return 0
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — disk management
# ------------------------------------------------------------------------------
adapter_remove_partition_table() {
    # $1=disk_path
    wipefs --all --force --quiet "${1}"
}

adapter_get_disk_type() {
    # $1=disk_path
    grep -q 0 "/sys/block/$(basename "${1}")/queue/rotational"
}

adapter_get_disk_size() {
    # $1=disk_path
    echo $(( $(blockdev --getsz "${1}") / 2 ))
}

adapter_remove_disk_content() {
    # $1=disk_path
    blkdiscard "${1}"
}

adapter_new_partition_table() {
    # $1=disk_path $2=partition_table_type
    parted "${1}" --script mklabel "${2}"
}   

# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Partition management
# ------------------------------------------------------------------------------
adapter_new_partition() {
    # $1=disk_path $2=part_start $3=part_end
    parted "${1}" --script unit MiB mkpart primary "${2}" "${3}"
}

adapter_set_partition_flag() {
    # $1=disk_path $2=part_num
    parted "${1}" unit MiB set "${2}" boot on print
}

adapter_get_partition_identifier() {
    # $1=partition_path
    blkid --match-tag PARTUUID --output value "${1}"
}

adapter_get_partition_type() {
    # $1=partition_path
    blkid --match-tag TYPE --output value "${1}"
}

# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — filesystem management
# ------------------------------------------------------------------------------
adapter_initialize_partition_vfat() {
    # $1=part_path, $2=label
    mkfs.vfat -n "${2}" "${1}"
}

adapter_initialize_partition_btrfs() {
    # $1=part_path, $2=label
    mkfs.btrfs -f -L "${2}" "${1}"
}

adapter_initialize_partition_swap() {
    # $1=part_path, $2=label
    mkswap -L "${2}" "${1}"
}
