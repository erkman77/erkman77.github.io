#!/bin/sh

CAMNAME="OScam-Installer"
BINARY="ncam_bin"

case "$1" in
    start)
        ulimit -s 1024
        /usr/bin/oscam_bin -b -c /etc/tuxbox/config/ncam --pidfile /tmp/oscam.pid
        ;;
    stop)
        kill -9 `ps -ax | grep -Fi oscam_bin | grep -v grep|grep -vE 'dpkg|opkg' | awk {'print $1'}` &> /dev/null 2>&1;
        ;;
    restart|reload)
        $0 stop
        sleep 1
        $0 start
        ;;
    version)
        echo "$CAMNAME"
        ;;
    info)
        echo "$CAMNAME"
        ;;
    *)
        echo "Usage: $0 start|stop|restart"
        exit 1
        ;;
esac
exit 0