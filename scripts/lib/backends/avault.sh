#!/usr/bin/env sh

_AVAULT="${HELM_SECRETS_AVAULT_PATH:-${HELM_SECRETS_AVAULT_BIN:-avault}}"

_avault() {
    # shellcheck disable=SC2086
    set -- ${SECRET_BACKEND_ARGS} "$@"
    $_AVAULT "$@"
}

_avault_backend_is_file_encrypted() {
    _avault_backend_is_encrypted <"${1}"
}

_avault_backend_is_encrypted() {
    grep -q -m 1 '$ANSIBLE_VAULT;1.1;AES256' -
}

_avault_backend_encrypt_file() {
    fatal "Encrypting files is not supported!"
}

_avault_backend_decrypt_file() {
    type="${1}"
    input="${2}"
    # if omit then output to stdout
    output="${3:-}"


    if [ "${input}" = "${output}" ]; then
         fatal "avault: inline decryption is not supported!"
    else
        _avault decrypt "${input}"
    fi
}

_avault_backend_decrypt_literal() {
    fatal "avault: Decrypting literal is not supported!"
}



