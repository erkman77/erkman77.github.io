#!/bin/sh

NAME="OSCam by OSCam-Installer"
BINARY="oscam_bin"
remove_tmp() {
    rm -rf /tmp/*.info* /tmp/*.tmp* /tmp/*share* /tmp/*.pid* /tmp/*sbox* /tmp/oscam* /tmp/.oscam
}

case "$1" in
start)
    echo "[SCRIPT] $1: ${NAME}"
    remove_tmp
    sleep 1
    /usr/bin/${BINARY} &
    sleep 1
    pidof ${BINARY} >/tmp/${BINARY}.pid
    ;;
stop)
    echo "[SCRIPT] $1: ${NAME}"
    killall -9 ${BINARY} 2>/dev/null
    sleep 1
    remove_tmp
    ;;
*)
    $0 stop
    exit 1
    ;;
esac

exit 0
