# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Btrfs subvolume
# ------------------------------------------------------------------------------
adapter_new_subvolume() {
    # $1=subvol_path
    btrfs subvolume create "${1}"
}

adapter_remove_subvolume() {
    # $1=subvol_path
    btrfs subvolume delete "${1}"
}

adapter_new_subvolume_snapshot() {
    # $1=source_subvol  $2=target_subvol
    btrfs subvolume snapshot "${1}" "${2}"
}

adapter_set_subvolume_compression() {
    # $1=mount_point, $2=compression_algorithm
    btrfs property set "${1}" compression "${2}"
}

adapter_new_swapfile() {
    # $1=size_in_kb  $2=swapfile_path
    btrfs filesystem mkswapfile --size "${1}"k "${2}"
}
