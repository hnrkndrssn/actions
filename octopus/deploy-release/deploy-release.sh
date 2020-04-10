#!/bin/bash
set -e

cmd=$(basename "$0" .sh)

run() {
    echo ""

    args=()
    args+=("--project=${INPUT_PROJECT}")
    args+=("--releaseNumber=${INPUT_RELEASE_NUMBER}")
    OIFS=$IFS
    IFS=', ' read -ra ENVIRONMENTS <<< "${INPUT_DEPLOY_TO}"
    for environment in "${ENVIRONMENTS[@]}"
    do
        args+=("--deployTo=${environment}")
    done
    IFS=$OIFS
    args+=("--server=${INPUT_OCTOPUS_SERVER}")
    args+=("--apikey=${INPUT_OCTOPUS_API_KEY}")

    optionalArgs=()
    if isSet "${INPUT_SPACE}"; then
        optionalArgs+=("--space=${INPUT_SPACE}")
    fi

    if isSet "${INPUT_CHANNEL}"; then
        optionalArgs+=("--channel=${INPUT_CHANNEL}")
    fi

    if isFlagSet "${INPUT_PROGRESS}"; then
        optionalArgs+=("--progress")
    fi

    if isFlagSet "${INPUT_FORCE_PACKAGE_DOWNLOAD}"; then
        optionalArgs+=("--forcePackageDownload")
    fi

    if isFlagSet "${INPUT_WAIT_FOR_DEPLOYMENT}"; then
        optionalArgs+=("--waitForDeployment")
    fi

    if isSet "${INPUT_DEPLOYMENT_TIMEOUT}"; then
        optionalArgs+=("--deploymentTimeout=${INPUT_DEPLOYMENT_TIMEOUT}")
    fi

    if isFlagSet "${INPUT_CANCEL_ON_TIMEOUT}"; then
        optionalArgs+=("--cancelOnTimeout")
    fi

    if isSet "${INPUT_CHECK_SLEEP_CYCLE}"; then
        optionalArgs+=("--deploymentCheckSleepCycle=${INPUT_CHECK_SLEEP_CYCLE}")
    fi

    if isFlagSet "${INPUT_USE_GUIDED_FAILURE}"; then
        optionalArgs+=("--guidedFailure=${INPUT_USE_GUIDED_FAILURE}")
    fi

    if isSet "${INPUT_SPECIFIC_MACHINES}"; then
        optionalArgs+=("--specificMachines=${INPUT_SPECIFIC_MACHINES}")
    fi

    if isSet "${INPUT_EXCLUDE_MACHINES}"; then
        optionalArgs+=("--excludeMachines=${INPUT_EXCLUDE_MACHINES}")
    fi

    if isFlagSet "${INPUT_FORCE}"; then
        optionalArgs+=("--force")
    fi

    if isSet "${INPUT_SKIP_STEPS}"; then
        OIFS=$IFS
        IFS=', ' read -ar STEPS <<< "${INPUT_SKIP_STEPS}"
        for step in "${STEPS[@]}"
        do
            optionalArgs+=("--skip=${step}")
        done
        IFS=$OIFS
    fi

    if isFlagSet "${INPUT_NO_RAW_LOG}"; then
        optionalArgs+=("--noRawLog")
    fi

    if isSet "${INPUT_RAW_LOG_FILE}"; then
        optionalArgs+=("--rawLogFile=${INPUT_RAW_LOG_FILE}")
    fi

    if isSet "${INPUT_PROMPTED_VARIABLES}"; then
        OIFS=$IFS
        IFS=', ' read -ar VARIABLES <<< "${INPUT_PROMPTED_VARIABLES}"
        for variable in "${VARIABLES[@]}"
        do
            optionalArgs+=("--variable=${variable}")
        done
        IFS=$OIFS
    fi

    if isSet "${INPUT_DEPLOY_AT}"; then
        optionalArgs+=("--deployAt=${INPUT_DEPLOY_AT}")
    fi

    if isSet "${INPUT_NO_DEPLOY_AFTER}"; then
        optionalArgs+=("--noDeployAfter=${INPUT_NO_DEPLOY_AFTER}")
    fi

    if isSet "${INPUT_TENANTS}"; then
        OIFS=$IFS
        IFS=', ' read -ar TENANTS <<< "${INPUT_TENANTS}"
        for tenant in "${TENANTS[@]}"
        do
            optionalArgs+=("--tenant=${tenant}")
        done
        IFS=$OIFS
    fi

    if isSet "${INPUT_TENANT_TAGS}"; then
        OIFS=$IFS
        IFS=', ' read -ar TENANTTAGS <<< "${INPUT_TENANT_TAGS}"
        for tenanttag in "${TENANTTAGS[@]}"
        do
            optionalArgs+=("--tenantTag=${tenanttag}")
        done
        IFS=$OIFS
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

run