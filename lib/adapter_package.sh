# ------------------------------------------------------------------------------
# [STRUCTURATION] ADAPTER — Zypper
# ------------------------------------------------------------------------------
adapter_update_zypper_repository() {
    zypper --non-interactive --gpg-auto-import-keys ref
}

adapter_install_rpm_package() {
    # $1=image_dir  $2=package_name
    zypper --installroot ${1} install --no-recommends --force-resolution -y ${2}
}

adapter_uninstall_rpm_package() {
    # $1=image_dir  $2=package_name
    zypper --installroot ${1} remove --clean-deps --force-resolution -y ${2}
}

adapter_get_installed_rpm_package() {
    # $1=image_dir
    zypper --installroot ${1} search --installed-only --type package | tr --delete ' ' | cut --only-delimited --delimiter="|" --fields=2 | grep --invert-match --extended-regexp -- "-lang$"
}

adapter_get_installed_rpm_package_language() {
    # $1=image_dir
    zypper --installroot ${1} search --installed-only --type package "*-lang" | tr --delete ' ' | cut --only-delimited --delimiter="|" --fields=2
}


adapter_get_available_rpm_package_language() {
    # $1=image_dir
    zypper --installroot ${1} search --not-installed-only --type package "*-lang" | tr --delete ' ' | cut --only-delimited --delimiter="|" --fields=2
}

adapter_new_rpm_repository() {
    # $1=image_dir  $2=priority  $3=repository_url  $4=repository_name
    adapter_invoke_container_command "${1}" "zypper addrepo --check --gpgcheck --refresh --priority ${2} \"${3}\" \"${4}\""
}
