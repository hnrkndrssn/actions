#!/bin/bash
set -e

run() {
    echo ""

    args=()
    args+=("--package=${INPUT_PACKAGE}")
    args+=("--server=${INPUT_OCTOPUS_SERVER}")
    args+=("--apikey=${INPUT_OCTOPUS_API_KEY}")

    optionalArgs=()
    if isSet "${INPUT_SPACE}"; then
        optionalArgs+=("--space=${INPUT_SPACE}")
    fi

    if isSet "${INPUT_OVERWRITE_MODE}"; then
        optionalArgs+=("--overwrite-mode=${INPUT_OVERWRITE_MODE}")
    fi

    if isFlagSet "${INPUT_USE_DELTA_COMPRESSION}"; then
        optionalArgs+=("--use-delta-compression")
    fi

    if isFlagSet "${INPUT_DEBUG}"; then
        optionalArgs+=("--debug")
    fi

    if isFlagSet "${INPUT_IGNORE_SSL_ERRORS}"; then
        optionalArgs+=("--ignoreSslErrors")
    fi

    if isSet "${INPUT_TIMEOUT}"; then
        optionalArgs+=("--timeout=${INPUT_TIMEOUT}")
    fi

    if isSet "${INPUT_LOG_LEVEL}"; then
        optionalArgs+=("--logLevel=${INPUT_LOG_LEVEL}")
    fi

    echo "executing octo ${args[@]} ${optionalArgs[@]}"
    octo push "${args[@]}" "${optionalArgs[@]}"
}

isSet() {
    [ ! -z "${1}" ]
}

isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

run