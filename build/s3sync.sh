#!/usr/bin/env bash

if [[ -e /etc/.s3cfg ]]; then
    echo "-"
else
    echo "running init ..."
 #  S3_CMD_FLAGS="--dry-run --skip-existing --delete-removed"
 #  ACCESS_KEY=""
 #  SECRET_KEY=""
 #  S3_PATH=""          #eg s3://abc..com/to
 # SOURCE_DIR=""
 #  BUCKET_LOCATION="US"
 #  MIME_TYPE=""
 #  CRONTIMING="1,31 * * * *"

    echo ${ACCESS_KEY}
    echo ${SECRET_KEY}

    if [ -z "${ACCESS_KEY}" ]; then
           echo "empty ACCESS_KEY"
           exit 1;
    fi
    if [ -z "${SECRET_KEY}" ]; then
        echo "empty SECRET_KEY"
        exit 1;
    fi
    if [ -z "${S3_PATH}" ]; then
           echo "empty S3_PATH"
           exit 1;
    fi
    if [ -z "${SOURCE_DIR}" ]; then
           echo "empty SOURCE_DIR"
           exit 1;
    fi
    if [ -z "${S3_CMD_FLAGS}" ]; then
        S3_CMD_FLAGS=" "
        echo "empty S3_CMD_FLAGS default is no flags."
    fi
    if [ -z "${BUCKET_LOCATION}" ]; then
        BUCKET_LOCATION="US"
        echo "empty BUCKET_LOCATION setting default ["${BUCKET_LOCATION}"]"
    fi
    if [ -z "${LOOP_DELAY}" ]; then
        LOOP_DELAY="200"

        echo "empty LOOP_DELAY setting default ["$LOOP_DELAY"]"
    fi

    echo "creating configuration to /etc/.s3cfg"

    sed -i s#{{ACCESS_KEY}}#${ACCESS_KEY}#g /etc/.s3cfg.template
    sed -i s#{{SECRET_KEY}}#${SECRET_KEY}#g /etc/.s3cfg.template
    sed -i s#{{BUCKET_LOCATION}}#${BUCKET_LOCATION}#g /etc/.s3cfg.template
    sed -i s#{{MIME_TYPE}}#${MIME_TYPE}#g /etc/.s3cfg.template

    mv /etc/.s3cfg.template /etc/.s3cfg
fi

echo -n "Starting backup... from ${SOURCE_DIR} to ${S3_PATH}"

s3cmd -c /etc/.s3cfg sync ${S3_CMD_FLAGS} ${SOURCE_DIR} ${S3_PATH}
RETVAL=$?

if [ "$RETVAL" -eq "0" ]; then
    echo "done OK!"
else
    echo "FAIL!"
fi

sleep ${LOOP_DELAY};

exit $RETVAL;