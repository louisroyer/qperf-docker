#!/usr/bin/env bash
TLS_SECRET=/qperf/tls-secret.log
if [ ! -z "$OWNER" ]; then
	if [ ! -z "$OWNER" ]; then
		chown $OWNER $TLS_SECRET
	fi
fi
