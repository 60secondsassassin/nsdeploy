# ------------------------------------------------------------------------------
# [COMPORTEMENT] STRATEGY
# ------------------------------------------------------------------------------
strategy_set_strategy() {
    # $1=option  $2=container_name
    while IFS='|' read -r strategy_option strategy_function; do
        if [ "${1}" = "${strategy_option}" ]; then
            ${strategy_function} "${2}"
            return 0
        fi
    done <<EOF
${COMMANDS}
EOF
    return 1
}
