#!/bin/bash
set -e

cmd=$(basename "$0" .sh)

run() {
    echo ""

    args=()
    args+=("--project=${INPUT_PROJECT}")
    args+=("--packageVersion=${INPUT_PACKAGE_VERSION}")
    args+=("--server=${INPUT_OCTOPUS_SERVER}")
    args+=("--apikey=${INPUT_OCTOPUS_API_KEY}")

    optionalArgs=()
    if isSet "${INPUT_SPACE}"; then
        optionalArgs+=("--space=${INPUT_SPACE}")
    fi

    if isSet "${INPUT_VERSION}"; then
        optionalArgs+=("--version=${INPUT_VERSION}")
    fi

    if isSet "${INPUT_CHANNEL}"; then
        optionalArgs+=("--channel=${INPUT_CHANNEL}")
    fi

    if isSet "${INPUT_PACKAGE}"; then
        OIFS=$IFS
        $IFS=', ' read -ar PACKAGES <<< "${INPUT_PACKAGE}"
        for package in "${PACKAGES[@]}"
        do
            optionalArgs+=("--package=${package}")
        done
        IFS=$OIFS
    fi

    if isSet "${INPUT_PACKAGES_FOLDER}"; then
        optionalArgs+=("--packagesFolder=${INPUT_PACKAGES_FOLDER}")
    fi

    if isSet "${INPUT_RELEASE_NOTES}"; then
        optionalArgs+=("--releaseNotes=${INPUT_RELEASE_NOTES}")
    fi

    if isSet "${INPUT_RELEASE_NOTES_FILE}"; then
        optionalArgs+=("--releaseNotesFile=${INPUT_RELEASE_NOTES_FILE}")
    fi

    if isFlagSet "${INPUT_IGNORE_EXISTING}"; then
        optionalArgs+=("--ignoreExisting")
    fi

    if isFlagSet "${INPUT_IGNORE_CHANNEL_RULES}"; then
        optionalArgs+=("--ignoreChannelRules")
    fi

    if isSet "${INPUT_PACKAGE_PRERELEASE}"; then
        optionalArgs+=("--packagePrerelease=${INPUT_PACKAGE_PRERELEASE}")
    fi

    if isFlagSet "${INPUT_WHAT_IF}"; then
        optionalArgs+=("--whatIf")
    fi

    if isFlagSet "${INPUT_DEPLOYMENT_PROGRESS}"; then
        optionalArgs+=("--progress")
    fi

    if isFlagSet "${INPUT_DEPLOYMENT_FORCE_PACKAGE_DOWNLOAD}"; then
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

    if isSet "${INPUT_DEPLOYMENT_CHECK_SLEEP_CYCLE}"; then
        optionalArgs+=("--deploymentCheckSleepCycle=${INPUT_DEPLOYMENT_CHECK_SLEEP_CYCLE}")
    fi

    if isFlagSet "${INPUT_DEPLOYMENT_GUIDED_FAILURE}"; then
        optionalArgs+=("--guidedFailure=${INPUT_DEPLOYMENT_GUIDED_FAILURE}")
    fi

    if isSet "${INPUT_DEPLOYMENT_SPECIFIC_MACHINES}"; then
        optionalArgs+=("--specificMachines=${INPUT_DEPLOYMENT_SPECIFIC_MACHINES}")
    fi

    if isSet "${INPUT_DEPLOYMENT_EXCLUDE_MACHINES}"; then
        optionalArgs+=("--excludeMachines=${INPUT_DEPLOYMENT_EXCLUDE_MACHINES}")
    fi

    if isFlagSet "${INPUT_DEPLOYMENT_FORCE}"; then
        optionalArgs+=("--force")
    fi

    if isSet "${INPUT_DEPLOYMENT_SKIP_STEPS}"; then
        OIFS=$IFS
        IFS=', ' read -ar STEPS <<< "${INPUT_DEPLOYMENT_SKIP_STEPS}"
        for step in "${STEPS[@]}"
        do
            optionalArgs+=("--skip=${step}")
        done
        IFS=$OIFS
    fi

    if isFlagSet "${INPUT_DEPLOYMENT_NO_RAW_LOG}"; then
        optionalArgs+=("--noRawLog")
    fi

    if isSet "${INPUT_DEPLOYMENT_RAW_LOG_FILE}"; then
        optionalArgs+=("--rawLogFile=${INPUT_DEPLOYMENT_RAW_LOG_FILE}")
    fi

    if isSet "${INPUT_DEPLOYMENT_VARIABLE}"; then
        OIFS=$IFS
        IFS=', ' read -ar VARIABLES <<< "${INPUT_DEPLOYMENT_VARIABLE}"
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

    if isSet "${INPUT_DEPLOYMENT_TENANT}"; then
        OIFS=$IFS
        IFS=', ' read -ar TENANTS <<< "${INPUT_DEPLOYMENT_TENANT}"
        for tenant in "${TENANTS[@]}"
        do
            optionalArgs+=("--tenant=${tenant}")
        done
        IFS=$OIFS
    fi

    if isSet "${INPUT_DEPLOYMENT_TENANT_TAG}"; then
        OIFS=$IFS
        IFS=', ' read -ar TENANTTAGS <<< "${INPUT_DEPLOYMENT_TENANT_TAG}"
        for tenanttag in "${TENANTTAGS[@]}"
        do
            optionalArgs+=("--tenantTag=${tenanttag}")
        done
        IFS=$OIFS
    fi

    if isSet "${INPUT_DEPLOY_TO}"; then
        OIFS=$IFS
        IFS=', ' read -ra ENVIRONMENTS <<< "${INPUT_DEPLOY_TO}"
        for environment in "${ENVIRONMENTS[@]}"
        do
            optionalArgs+=("--deployTo=${environment}")
        done
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