# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Help
# ------------------------------------------------------------------------------
command_show_usage() {
    # no args
    printf '%s\n' "${SCRIPT_OPTION}"
    exit 2
}

command_show_error_message() {
    # no args
    printf '%s\n' "! Missing environment file"
    exit 2
}
