#!/bin/sh
set -e

function main() {
    echo ""

    if isSet "${INPUTS_SPACE}"; then
        optionalArgs[0]="--space=${INPUTS_SPACE}"
    fi

    if isSet "${INPUTS_OVERWRITE_MODE}"; then
        optionalArgs[1]="--overwrite-mode=${INPUTS_OVERWRITE_MODE}"
    fi

    if isFlagSet "${INPUTS_USE_DELTA_COMPRESSION}"; then
        optionalArgs[2]="--use-delta-compression"
    fi

    if isFlagSet "${INPUTS_DEBUG}"; then
        optionalArgs[3]="--debug"
    fi

    if isFlagSet "${INPUTS_IGNORE_SSL_ERRORS}"; then
        optionalArgs[4]="--ignoreSslErrors"
    fi

    if isSet "${INPUTS_TIMEOUT}"; then
        optionalArgs[5]="--timeout=${INPUTS_TIMEOUT}"
    fi

    if isSet "${INPUTS_LOG_LEVEL}"; then
        optionalArgs[6]="--logLevel=${INPUTS_LOG_LEVEL}"
    fi

    octo --package=${INPUTS_PACKAGE} \
         --server=${INPUTS_OCTOPUS_SERVER} \
         --server=${INPUTS_OCTOPUS_SERVER} \
         --apiKey=${INPUTS_OCTOPUS_API_KEY} \
         "${optionalArgs[@]}"
}

function isSet() {
    [ ! -z "${1}" ]
}

function isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

main
