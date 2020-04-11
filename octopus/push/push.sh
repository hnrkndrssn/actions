#!/bin/bash
set -e

cmd=$(basename "$0" .sh)

run() {
    echo ""

    args=()
    if isGlob "${INPUT_PACKAGE}"; then
        for package in ${INPUT_PACKAGE}
        do
            args+=("--package=${package}")
        done
    else
        OIFS=$IFS
        IFS=', ' read -ra PACKAGES <<< "${INPUT_PACKAGE}"
        for package in "${PACKAGES[@]}"
        do
            args+=("--package=${package}")
        done
    fi
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

    echo "executing octo $cmd ${args[@]} ${optionalArgs[@]}"
    octo $cmd "${args[@]}" "${optionalArgs[@]}"
}

isSet() {
    [ ! -z "${1}" ]
}

isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

isGlob() {
    [[ "${1}" =~ \*  ]]
}
run