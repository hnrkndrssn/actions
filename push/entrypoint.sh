#!/bin/bash
set -e

function main() {
    echo ""

    args=()
    args+=("--package=${INPUT_PACKAGE}")
    args+=("--server=${INPUT_OCTOPUS_SERVER}")
    args+=("--apikey=${INPUT_OCTOPUS_API_KEY}")

    if isSet "${INPUT_SPACE}"; then
        args+=("--space=${INPUT_SPACE}")
    fi

    if isSet "${INPUT_OVERWRITE_MODE}"; then
        args+=("--overwrite-mode=${INPUT_OVERWRITE_MODE}")
    fi

    if isFlagSet "${INPUT_USE_DELTA_COMPRESSION}"; then
        args+=("--use-delta-compression")
    fi

    if isFlagSet "${INPUT_DEBUG}"; then
        args+=("--debug")
    fi

    if isFlagSet "${INPUT_IGNORE_SSL_ERRORS}"; then
        args+=("--ignoreSslErrors")
    fi

    if isSet "${INPUT_TIMEOUT}"; then
        args+=("--timeout=${INPUT_TIMEOUT}")
    fi

    if isSet "${INPUT_LOG_LEVEL}"; then
        args+=("--logLevel=${INPUT_LOG_LEVEL}")
    fi

    echo "octo ${args[@]}"
    #octo "${args[@]}"
}

function isSet() {
    [ ! -z "${1}" ]
}

function isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

main
