#!/bin/sh

CAMNAME="OSCam-Installer"
binary="oscam_bin"

remove_tmp () {
	rm -rf /tmp/cainfo.* /tmp/camd.* /tmp/sc.* /tmp/*.info* /tmp/*.tmp* /tmp/oscam*
	[ -e /tmp/.oscam ] && rm -rf /tmp/.oscam
	[ -e /tmp/.emu.info ] && rm -rf /tmp/.emu.info
	[ -e /tmp/oscam.mem ] && rm -rf /tmp/oscam.mem
}

case "$1" in
	start)
		echo "[SCRIPT] $1: $CAMNAME"
		remove_tmp
		touch /tmp/.emu.info
		echo "$CAMNAME" > /tmp/.emu.info
		/usr/bin/$binary -b -r 2 -c /etc/tuxbox/config --daemon --pidfile /var/tmp/$binary.pid --restart 2
	;;
	stop)
		echo "[SCRIPT] $1: $CAMNAME"
		kill `pidof $binary`
		remove_tmp
	;;
    restart|reload)
		$0 stop
		sleep 2
		$0 start
		exit
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
