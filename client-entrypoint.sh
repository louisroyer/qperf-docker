#!/usr/bin/env bash
if [ ! -z "$STARTUP_SLEEP" ]; then
	echo "[$(date --iso-8601=s)] Starting client in ${STARTUP_SLEEP} seconds." > /dev/stderr
	sleep "${STARTUP_SLEEP}"
fi
