# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Network devices
# ------------------------------------------------------------------------------
adapter_get_network_device_mac_address() {
    # ip link | grep --after-context=1 --extended-regexp "eth[0-9]|enp[0-9]*" | tail --lines=1 | tr --squeeze-repeats ' ' | cut --delimiter=" " --fields=3
    cat /sys/class/net/eth[0-9]/address /sys/class/net/enp[0-9]*/address 2>/dev/null
}