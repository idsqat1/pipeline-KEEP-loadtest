#!/bin/bash

ARTIFACT_SIZE=200        # the size in MB of the artifact to upload and download.
BuildNumber=1

#------------------------------------------------------------------------------
# Function to generate artifact with random data.
#------------------------------------------------------------------------------

function GenerateRandomArtifacts() {
    local directory=$1
    local size=$2
    local exitCode=0

    rm -rf ${directory}
    mkdir -p ${directory}

    for (( i=1; i<=${size} && ${exitCode}==0; i++ ))
    do
        local outputFile=$(printf '%s/random%d.%03d' ${directory} ${BuildNumber} ${i})
        echo "== Generating ${outputFile} ==" >> dd.out
        dd if=/dev/urandom of=${outputFile} bs=1M count=1 >> dd.out 2>&1
        exitCode=$?
    done

    rm -f dd.out
    return ${exitCode}
}

#------------------------------------------------------------------------------

GenerateRandomArtifacts artifacts${BuildNumber} ${ARTIFACT_SIZE}
