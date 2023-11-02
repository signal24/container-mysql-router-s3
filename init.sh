#!/bin/sh

if [ -n "$S3_BUCKET" ]; then
    mkdir /tmp/mysqlrouter
    # mount-s3 --prefix "${S3_PREFIX:-/}" "${S3_BUCKET}" /tmp/mysqlrouter
    s3fs ${S3_BUCKET}:${S3_PREFIX:-/} /tmp/mysqlrouter -o use_cache=/tmp -o allow_other
fi

if [ -f /tmp/mysqlrouter/mysqlrouter.conf ]; then
    exec mysqlrouter --config /tmp/mysqlrouter/mysqlrouter.conf
else
    exec sudo -E -u mysqlrouter /run.sh mysqlrouter
fi
