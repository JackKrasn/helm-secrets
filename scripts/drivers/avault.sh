#!/usr/bin/env sh

_AVAULT="${HELM_SECRETS_AVAULT_PATH:-avault}"

_avault() {
    # shellcheck disable=SC2086
    set -- ${SECRET_DRIVER_ARGS} "$@"

    # In case of an error, give us stderr
#     # https://github.com/variantdev/vals/issues/60
#     if ! $_VALS "$@" 2>/dev/null; then
#         $_VALS "$@" >/dev/null
#     fi
    if ! $_AVAULT "$@" 2>/dev/null; then
            $_AVAULT "$@" >/dev/null
    fi
}

driver_is_file_encrypted() {
    input="${1}"

    grep -q '$ANSIBLE_VAULT;1.1;AES256' "${input}"
}

driver_encrypt_file() {
    echo "Encrypting files is not supported!"
    exit 1
}

driver_decrypt_file() {
    input="${2}"
    _avault decrypt "${input}"
}

driver_edit_file() {
    echo "Editing files is not supported!"
    exit 1
}
