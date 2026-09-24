# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Archive extraction
# ------------------------------------------------------------------------------
adapter_expand_archive_content() {
    # $1=archive_path  $2=target_dir
    tar -xjf "${1}" -C "${2}"
}
