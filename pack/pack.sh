#!/bin/bash
set -e

cmd=$(basename "$0" .sh)

run() {
    echo ""

    args=()
    args+=("pack")
    args+=("--id=${INPUT_PACKAGE_ID}")

    optionalArgs=()
    if isSet "${INPUT_FORMAT}"; then
        optionalArgs+=("--format=${INPUT_FORMAT}")
    fi

    if isSet "${INPUT_VERSION}"; then
        optionalArgs+=("--version=${INPUT_VERSION}")
    fi

    if isSet "${INPUT_OUT_FOLDER}"; then
        optionalArgs+=("--outFolder=${INPUT_OUT_FOLDER}")
    fi

    if isSet "${INPUT_BASE_PATH}"; then
        optionalArgs+=("--basePath=${INPUT_BASE_PATH}")
    fi

    if isSet "${INPUT_LOG_LEVEL}"; then
        optionalArgs+=("--logLevel=${INPUT_LOG_LEVEL}")
    fi

    if isSet "${INPUT_AUTHOR}"; then
        OIFS=$IFS
        IFS=', ' read -ra AUTHORS <<< "${INPUT_AUTHOR}"
        for author in "${AUTHORS[@]}"
        do
            optionalArgs+=("--author=${author}")
        done
    fi

    if isSet "${INPUT_TITLE}"; then
        optionalArgs+=("--title=${INPUT_TITLE}")
    fi

    if isSet "${INPUT_DESCRIPTION}"; then
        optionalArgs+=("--description=${INPUT_DESCRIPTION}")
    fi

    if isSet "${INPUT_RELEASE_NOTES}"; then
        optionalArgs+=("--releaseNotes=${INPUT_RELEASE_NOTES}")
    fi

    if isSet "${INPUT_RELEASE_NOTES_FILE}"; then
        optionalArgs+=("--releaseNotesFile=${INPUT_RELEASE_NOTES_FILE}")
    fi

    if isSet "${INPUT_COMPRESSION_LEVEL}"; then
        optionalArgs+=("--compressionLevel=${INPUT_COMPRESSION_LEVEL}")
    fi

    if isFlagSet "${INPUT_VERBOSE}"; then
        optionalArgs+=("--verbose")
    fi

    if isSet "${INPUT_INCLUDE}"; then
        OIFS=$IFS
        IFS=", " read -ra INCLUDES <<< "${INPUT_INCLUDE}"
        for include in "${INCLUDES[@]}"
        do
            optionalArgs+=("--include=${include}")
        done
        IFS=$OIFS
    fi

    if isFlagSet "${INPUT_OVERWRITE}"; then
        optionalArgs+=("--overwrite")
    fi

    echo "execuing octo $cmd ${args[@]} ${optionalArgs[@]}"
    octo $cmd "${args[@]}" "${optionalArgs[@]}"
}

isSet() {
    [ ! -z "${1}" ]
}

isFlagSet() {
    [ ! -z "${1}" ] && [ "${1}" == "true" ]
}

run