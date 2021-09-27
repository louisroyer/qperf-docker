#!/usr/bin/env bash
SERVER_KEY=${WORKDIR}/server.key
SERVER_CRT=${WORKDIR}/server.crt
if [ ! -f "$SERVER_KEY" -o ! -f "$SERVER_CRT" ]; then
	openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=US/ST=NC/L=Local/O=Dev/CN=qperf-server.qperf-net" -keyout "$SERVER_KEY" -out "$SERVER_CRT" 
	if [ ! -z "$OWNER" ]; then
		chown $OWNER $SERVER_KEY $SERVER_CRT
	fi
fi
