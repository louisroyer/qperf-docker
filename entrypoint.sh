#!/usr/bin/env bash
if [ ! -z "$ENTRYPOINT" ]; then
	echo "[$(date --iso-8601=s)] Running ${ENTRYPOINT}" > /dev/stderr
	$ENTRYPOINT
fi

if [ ! -z "$WORKDIR" ]; then
	echo "[$(date --iso-8601=s)] Change working directory to $WORKDIR" > /dev/stderr
	cd "$WORKDIR"
fi

qperf "$@"

if [ ! -z "$EXITPOINT" ]; then
	echo "[$(date --iso-8601=s)] Running ${EXITPOINT}" > /dev/stderr
	$EXITPOINT
fi
