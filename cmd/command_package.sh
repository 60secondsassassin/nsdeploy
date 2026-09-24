# ------------------------------------------------------------------------------
# [COMPORTEMENT] COMMAND — Package Management
# ------------------------------------------------------------------------------
command_update_zypper_repository() {
    update_repository
}

command_install_rpm_package() {
    # $1=image_dir $2=package_name
    adapter_install_rpm_package "${1}" "$(printf '%s' "${2}" | tr --squeeze-repeats '\n\r' ' ')"
}

command_uninstall_rpm_package() {
    # $1=image_dir $2=package_name
    adapter_uninstall_rpm_package "${1}" "$(printf '%s' "${2}" | tr --squeeze-repeats '\n\r' ' ')"
}

command_install_rpm_package_language() {
    # $1=image_dir
    installed_package=$(adapter_get_installed_rpm_package "${1}")
    installed_package_language=$(adapter_get_installed_rpm_package_language "${1}")
    available_package_language=$(adapter_get_available_rpm_package_language "${1}")

    install_package_language=""

    for package in ${installed_package}; do
        package_language="${package}-lang"
        if printf '%s' "${available_package_language}" | grep --quiet --line-regexp -- "${package_language}"; then
            if ! printf '%s' "${installed_package_language}" | grep --quiet --line-regexp -- "${package_language}"; then
                install_package_language="${install_package_language} ${package_language}"
            fi
        fi
    done

    if [ -n "${install_package_language}" ]; then
        adapter_install_rpm_package "${1}" "$(printf '%s' "${install_package_language}" | tr --squeeze-repeats '\n\r' ' ')"
    fi
}

command_new_rpm_repository() {
    # $1=image_dir $2=priority|repository_url|repository_name
    while IFS='|' read -r priority repository_url repository_name; do
        [ -z "${repository_url}" ] && continue
        adapter_new_rpm_repository "${1}" "${priority}" "${repository_url}" "${repository_name}"
    done <<EOF
${2}
EOF
}


# command_install_rpm_package_language() {
#     installed_package=$(adapter_get_installed_rpm_package "${1}")
#     installed_package_language=$(adapter_get_installed_rpm_package_language "${1}")
#     available_package_language=$(adapter_get_available_rpm_package_language "${1}")

#     # 1. On calcule la liste des langues manquantes
#     missing_package_language=$(printf '%s\n' "${available_package_language}" | grep -Fvx "${installed_package_language}")

#     # 2. On génère la liste des "-lang" attendus pour les paquets installés
#     wanted_languages=$(printf '%s-lang\n' ${installed_package_language})

#     # 3. L'intersection des deux listes nous donne directement les paquets à installer !
#     install_package_language=$(printf '%s\n' "${wanted_languages}" | grep -Fix "${missing_package_language}" | tr -s '[:space:]' ' ')

#     if [ -n "${install_package_language}" ]; then
#         adapter_install_rpm_package "${1}" "${install_package_language}"
#     fi
# }
