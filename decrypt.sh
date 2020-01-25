#!/usr/bin/env bash

function main() {
    IFS='|' read -r -a PAIRS <<< "${PLUGIN_FILE_TO_PATH_MAPPING}"
    for ITEM in "${PAIRS[@]}"; do
        IFS=':' read -r -a ELEMENTS <<< "${ITEM}"
        if [ "${#ELEMENTS[@]}" -eq 2 ]; then
            SRC="${ELEMENTS[0]}"
            DEST="${ELEMENTS[1]}"
            openssl enc -aes-256-cbc -md sha256 -pbkdf2 -d -in "${SRC}" -k "${PLUGIN_DECRYPT_KEY}" > "${DEST}"
        else
            echo "PLUGIN_FILE_TO_PATH_MAPPING is incorrectly formatted!"
        fi
    done
}

if [ -z "${PLUGIN_FILE_TO_PATH_MAPPING}" ]; then
    echo "This script needs to know what to decrypt!"
    exit 1
fi

main
