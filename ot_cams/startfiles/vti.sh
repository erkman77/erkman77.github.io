#!/bin/sh

CAMNAME="OScam by OSCam-Installer"


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
		echo "OScam by OSCam-Installer" > /tmp/.emu.info
		/usr/bin/oscam_bin -b --config-dir /etc/tuxbox/config/ --daemon --pidfile /var/tmp/oscam_bin.pid --restart 2
	;;
	stop)
		echo "[SCRIPT] $1: $CAMNAME"
		kill `pidof oscam_bin`
		remove_tmp
	;;
	restart)
		$0 stop
		sleep 2
		$0 start
		exit
	;;
	*)
		$0 stop
		exit 0
	;;
esac

exit 0
