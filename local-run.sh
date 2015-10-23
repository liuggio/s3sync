#!/usr/bin/env bash

if [ "$#" -lt 4 ]
then
    echo "Usage: $0 ACCESS_KEY SECRET_KEY SOURCE_DIR S3_PATH [S3_CMD_FLAGS]"
	exit 1
fi

docker run   \
    -e ACCESS_KEY="${1}" \
    -e SECRET_KEY="${2}" \
    -e SOURCE_DIR="${3}" \
    -e S3_PATH="${4}" \
    -e S3_CMD_FLAGS="${5}" \
    --rm  \
    -t -i s3sync
