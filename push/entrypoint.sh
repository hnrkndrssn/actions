#!/bin/sh
set -e

function main() {
    echo ""

    set "--package=${INPUT_PACKAGE}" "--server=${INPUT_OCTOPUS_SERVER}" "--apikey=${INPUT_OCTOPUS_API_KEY}"

    if isSet "${INPUT_SPACE}"; then
        set -- "$@" "--space=${INPUT_SPACE}"
    fi

    if isSet "${INPUT_OVERWRITE_MODE}"; then
        set -- "$@" "--overwrite-mode=${INPUT_OVERWRITE_MODE}"
    fi

    if isFlagSet "${INPUT_USE_DELTA_COMPRESSION}"; then
        set -- "$@" "--use-delta-compression"
    fi

    if isFlagSet "${INPUT_DEBUG}"; then
        set -- "$@" "--debug"
    fi

    if isFlagSet "${INPUT_IGNORE_SSL_ERRORS}"; then
        set -- "$@" "--ignoreSslErrors"
    fi

    if isSet "${INPUT_TIMEOUT}"; then
        set -- "$@" "--timeout=${INPUT_TIMEOUT}"
    fi

    if isSet "${INPUT_LOG_LEVEL}"; then
        set -- "$@" "--logLevel=${INPUT_LOG_LEVEL}"
    fi

    octo "$@"
}

function isSet() {
    [ ! -z "${1}" ]
}

function isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

main
