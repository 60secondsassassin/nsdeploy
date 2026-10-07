# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Memory
# ------------------------------------------------------------------------------
adapter_get_memory_size() {
    # returns KiB, matching /proc/meminfo and adapter_get_disk_size()
    cat /proc/meminfo | grep "MemTotal" | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
    # free --kibi | grep "Mem:" | tr --squeeze-repeats ' ' | cut --delimiter=' ' --fields=2
}
