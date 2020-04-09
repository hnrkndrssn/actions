#!/bin/sh
set -e

function main() {
    echo ""

    if isSet "${INPUT_SPACE}"; then
        optionalArgs[0]="--space=${INPUT_SPACE}"
    fi

    if isSet "${INPUT_OVERWRITE_MODE}"; then
        optionalArgs[1]="--overwrite-mode=${INPUT_OVERWRITE_MODE}"
    fi

    if isFlagSet "${INPUT_USE_DELTA_COMPRESSION}"; then
        optionalArgs[2]="--use-delta-compression"
    fi

    if isFlagSet "${INPUT_DEBUG}"; then
        optionalArgs[3]="--debug"
    fi

    if isFlagSet "${INPUT_IGNORE_SSL_ERRORS}"; then
        optionalArgs[4]="--ignoreSslErrors"
    fi

    if isSet "${INPUT_TIMEOUT}"; then
        optionalArgs[5]="--timeout=${INPUT_TIMEOUT}"
    fi

    if isSet "${INPUT_LOG_LEVEL}"; then
        optionalArgs[6]="--logLevel=${INPUT_LOG_LEVEL}"
    fi

    octo --package=${INPUT_PACKAGE} \
         --server=${INPUT_OCTOPUS_SERVER} \
         --apiKey=${INPUT_OCTOPUS_API_KEY} \
         "${optionalArgs[@]}"
}

function isSet() {
    [ ! -z "${1}" ]
}

function isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

main
