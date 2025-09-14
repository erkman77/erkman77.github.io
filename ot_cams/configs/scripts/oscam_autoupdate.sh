#!/bin/bash


_scriptversion=32

_url=i.tv-lounge.eu
_stream=\[streamrelay\]
SEARCH_PATH="/usr/tuxbox/config"
_start=""
clear

if [ -e /etc/opkg ]; then
  _exec_cmd="opkg"
elif [ -e /etc/apt/sources.list.d ]; then
  _exec_cmd="apt -y"
 else
  echo "neither opkg nor apt was found ... bailing out"
  exit 0
fi

$_exec_cmd install curl > /dev/null 2>&1

if curl -s --head ${_url}/ot_tune/settings/satellites.xml | grep 200 > /dev/null; then
	#compare script version
	wget -O /tmp/oscam_autoupdate ${_url}/ot_cams/update/oscam_autoupdate.txt > /dev/null 2>&1
	_script_new=$(sed -n '4p' /tmp/oscam_autoupdate)
    X=15
	  _script_new=$(echo "$_script_new" | cut -c $((X + 1))-)
  if [[ "${_script_new}" != "${_scriptversion}" ]]; then
  	echo "Update OSCam autoupdate"
  	sleep 2
	cp /tmp/oscam_autoupdate /usr/bin/oscam_autoupdate
	chmod +x /usr/bin/oscam_autoupdate
	exec "$0" "$@"
  fi

  #compare oscam version
  wget -O /tmp/version.txt ${_url}/version.txt > /dev/null 2>&1
  file="/tmp/version.txt"
  search="version="
  X=8 
  content=$(grep "$search" "$file")

  if [ -n "$content" ]; then
    Version_new=$(echo "$content" | cut -c $((X + 1))-)
  fi

  ps xuww | grep -i oscam | grep -vE 'grep|tail' | awk '{print $11}'|uniq > /tmp/oscam
  ps xuww | grep -i oscam | grep -vE 'grep|tail' | awk '{for (i=11; i<=26; i++) printf "%s%s", $i, (i<26 ? OFS : ORS)}'|uniq > /tmp/oscam_start
  ps xuww | grep -i oscam | grep -vE 'grep|tail' | awk '{print $11}' | uniq | awk -F/ 'BEGIN {OFS="/"} {NF--; print}' > /tmp/oscam_path
  _oscam_path=$(head -n 1 /tmp/oscam_path)
  _start=$(head -n 1 /tmp/oscam_start)
  _myoscambin=$(head -n 1 /tmp/oscam)
  _oscambin=$(basename "$_myoscambin")


  if [[ -z "$_myoscambin" || "$_myoscambin" == "/bin/bash" ]]; then
	echo -e "\e[31m\nNo running OSCam found\n\e[0m"
	exit 0
  fi

  $_myoscambin -V > /tmp/version2.txt
  Version_old=$(  $_myoscambin --build-info | grep -i 'version:' | grep -o '[0-9]\{5\}'   )  
  _find_extra="/tmp/version2.txt"
  _neon_is_set="ARM NEON (SIMD/MPE) support:             yes"
  _emu_is_set="Emulator support:                        yes"

  if grep -q "$_neon_is_set" "$_find_extra" 2>/dev/null; then
	_neon="-neon"
  fi

  if grep -q "$_emu_is_set" "$_find_extra" 2>/dev/null; then
	_emu="-emu"
  fi

  echo -e "Found running OSCam\nBin file: ${_oscambin}\nVersion: ${Version_old}${_neon}${_emu}\nLocation: ${_oscam_path}"

  if [[ "$Version_new" != "$Version_old" ]]; then
    echo -e "\nUpdating to Version: $Version_new${_neon}${_emu}\n"

	#find arch und backup old oscam 
	#cp ${_myoscambin} ${_myoscambin}_bak
    if [ -n "$(uname -m | grep armv7l)" ]; then
      _arch=arm
    elif [ -n "$(uname -m | grep aarch64)" ]; then
      _arch=aarch64
    elif [ -n "$(uname -m | grep mips)" ]; then
      _arch=mipsel
    else
      echo -e "\e[31m Sorry, your device does not have the proper Emu \e[0m"
      exit 1
    fi

	#kill_oscam
	if [ -f /etc/init.d/softcam.${_oscambin} ]; then
		/etc/init.d/softcam.${_oscambin} stop > /dev/null 2>&1
		_file=$(find /etc/init.d/softcam* -type f -exec grep -l "${_oscambin}" {} +)
		$_file stop > /dev/null 2>&1
		sleep 2
	fi
	if [ -f /usr/camscript/Ncam_${_oscambin}.sh ]; then
		/usr/camscript/Ncam_${_oscambin}.sh stop > /dev/null 2>&1
		sleep 2
	fi
	if [ -f /usr/script/${_oscambin}.emu ]; then
		/usr/script/${_oscambin}.emu stop > /dev/null 2>&1
		sleep 2
	fi
	if [ -f /usr/script/${_oscambin}.sh ]; then
		/usr/script/${_oscambin}.sh stop > /dev/null 2>&1
		sleep 2
	fi
	if [ -f /usr/script/${_oscambin}_cam.sh ]; then
		/usr/script/${_oscambin}_cam.sh stop > /dev/null 2>&1
		sleep 2
	fi

	if [ -f /usr/emu_scripts/EGcam_${_oscambin}.sh ]; then
		/usr/emu_scripts/EGcam_${_oscambin}.sh stop > /dev/null 2>&1
		sleep 2
	fi
	if [ -f /etc/cam.d/${_oscambin}.sh ]; then
		/etc/cam.d/${_oscambin}.sh stop > /dev/null 2>&1
		sleep 2
	fi

	killall -9 ${_oscambin} > /dev/null 2>&1
	kill `pidof ${_oscambin}` > /dev/null 2>&1
 
	# replace oscam  
    if [ -e /etc/apt/sources.list.d  ]; then
		systemctl stop ${_oscambin}.service > /dev/null 2>&1
        wget -O $_myoscambin ${_url}/ot_cams/oscam/oscam-dream_${_arch}-$Version_new${_neon}${_emu} > /dev/null 2>&1
		chmod +x $_myoscambin
		systemctl start ${_oscambin}.service > /dev/null 2>&1
    else
		wget -O $_myoscambin ${_url}/ot_cams/oscam/oscam-${_arch}-$Version_new${_neon}${_emu} > /dev/null 2>&1
		chmod +x $_myoscambin
    fi

	#bh
	if [ -f /usr/camscript/Ncam_${_oscambin}.sh ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/EMUNAME=\"OSCam ${_oscam_version}${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		sed -i "19s/.*/         \/usr\/softcams\/\$binary -b -r 2 -c \/etc\/tuxbox\/config/" /tmp/oscam_update.sh
		_start="/usr/camscript/Ncam_${_oscambin}.sh restart"
		mv /tmp/oscam_update.sh /usr/camscript/Ncam_${_oscambin}.sh
		chmod +x /usr/camscript/Ncam_${_oscambin}.sh
		echo "OSCam ${_oscam_version}${_neon}${_emu}" > /etc/CurrentBhCamName

	    if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
	    fi
		sleep 2
	fi

	#egami
	if [ -f /usr/emu_scripts/EGcam_${_oscambin}.sh ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/CAMNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		sed -i "19s/.*/         \/usr\/bin\/\$binary -b -r 2 -c \/etc\/tuxbox\/config/" /tmp/oscam_update.sh
		_start="/usr/emu_scripts/EGcam_${_oscambin}.sh restart"
		mv /tmp/oscam_update.sh /usr/emu_scripts/EGcam_${_oscambin}.sh
		cp  /usr/emu_scripts/EGcam_${_oscambin}.sh /usr/bin/StartEGCam  > /dev/null 2>&1
		chmod +x /usr/emu_scripts/EGcam_${_oscambin}.sh
		chmod +x /usr/bin/StartEGCam  > /dev/null 2>&1
		echo "OSCam v$Version_new${_neon}${_emu}" > /etc/CurrentEGCamName	
	
		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		fi
		sleep 2
	fi

	if [ -e /etc/apt/sources.list.d  ]; then
      systemctl stop ${_oscambin}.service > /dev/null 2>&1
	fi

	#newenigma
	if [ -f /usr/script/${_oscambin}.emu ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh
		sed -i "3s/.*/EMUNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /usr/script/${_oscambin}.emu
		_start="/usr/script/${_oscambin}.emu restart"
		chmod +x /usr/script/${_oscambin}.emu

		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
	    fi
		sleep 2
	fi

	#vti
	if [ -f /usr/script/${_oscambin}_cam.sh ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/CAMNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /usr/script/${_oscambin}_cam.sh
		chmod +x /usr/script/${_oscambin}_cam.sh
		ln -sf /usr/script/${_oscambin}_cam.sh /etc/init.d/current_cam.sh > /dev/null 2>&1
		chmod +x /etc/init.d/current_cam.sh 
		_start="/usr/script/${_oscambin}_cam.sh restart"
		cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		sleep 2
	fi

	if [ -f /usr/script/${_oscambin}.sh ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/CAMNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /usr/script/${_oscambin}.sh
		_start="/usr/script/${_oscambin}.sh restart"
		chmod +x /usr/script/${_oscambin}.sh

		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		fi
		sleep 2
	fi

	#
	if [ -f /usr/script/${_oscambin}.emu ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/EMUNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /usr/script/${_oscambin}.emu
		chmod +x /usr/script/${_oscambin}.emu
		_start="/usr/script/${_oscambin}.emu restart"
	
		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		fi
		sleep 2
	fi

	#nfnr
	if [ -f /usr/emu/start/${_oscambin}.emu ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/EMUNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /usr/emu/start/${_oscambin}.emu
		chmod +x /usr/emu/start/${_oscambin}.emu

		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
		  cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		fi
		#/usr/script/${_oscambin}.emu start > /dev/null 2>&1
		_start="/usr/emu/start/${_oscambin}.emu restart"
		sleep 2
	fi

	#n
	if [ -f /etc/cam.d/${_oscambin}.sh ]; then
		wget -O /tmp/oscam_update.sh ${_url}/ot_cams/startfiles/oscam_update.sh > /dev/null 2>&1
		sed -i "3s/.*/CAMNAME=\"OSCam $Version_new${_neon}${_emu}\"/" /tmp/oscam_update.sh
		sed -i "4s/.*/binary=\"${_oscambin}\"/" /tmp/oscam_update.sh
		mv /tmp/oscam_update.sh /etc/cam.d/${_oscambin}.sh
		chmod +x /etc/cam.d/${_oscambin}.sh
		_start="/etc/cam.d/${_oscambin.sh} restart"

		if [ -r /etc/tuxbox/config/${_oscambin} ]; then
	      cp /etc/tuxbox/config/${_oscambin}/* /etc/tuxbox/config > /dev/null 2>&1
		fi
		sleep 2
	fi

	if [ -f /etc/init.d/softcam.${_oscambin} ]; then
		_start="/etc/init.d/softcam.${_oscambin} restart"
		#$_file start > /dev/null 2>&1
		sleep 2
	fi

	if [ -e /etc/apt/sources.list.d  ]; then
      systemctl start ${_oscambin}.service > /dev/null 2>&1
	fi

    #echo "OSCam changed from $Version_old${_neon}${_emu} to $Version_new${_neon}${_emu}"
    echo -e "\nOSCam changed to $Version_new${_neon}${_emu}\n"
    eval $_start > /dev/null 2>&1
    curl --noproxy '*' --data value="OSCam-Installer v${Version_new}" "http://127.0.0.1/api/saveconfig?key=config.misc.softcams" > /dev/null 2>&1
    else
    echo -e "\nOSCam up2date\n"
  fi

  find "$SEARCH_PATH" -name "oscam.conf" 2>/dev/null | while read -r file; do
  if ! grep -q "\[streamrelay\]" "$file"; then
        {
            echo "[streamrelay]"
            echo "stream_relay_enabled = 1"
            echo "stream_relay_ctab = 098D"
            echo "stream_relay_user = stream"
            echo "stream_relay_buffer_time = 500"
        } >> "$file"
  fi
  done

  rm /tmp/version* > /dev/null 2>&1
  rm /tmp/oscam > /dev/null 2>&1
  rm /tmp/oscam_* > /dev/null 2>&1
  unset _emu
  unset _neon
else
  echo -e "\e[31m\nHost not reachable\n\e[0m"
fi