# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Filesystem & Directories
# ------------------------------------------------------------------------------
command_expand_archive_content() {
    # ${1}="archive_path|directory_path"
    while IFS='|' read -r archive_path directory_path; do
        [ -z "${archive_path}" ] && continue
        adapter_expand_archive_content "${archive_path}" "${directory_path}"
    done <<EOF
${1}
EOF
}
