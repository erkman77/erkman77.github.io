#!/bin/bash

if [ -e /etc/opkg ]; then
    opkg install curl > /dev/null 2>&1
	opkg install bash > /dev/null 2>&1
fi

if [ -e /etc/apt/sources.list.d ]; then
			apt install -y curl > /dev/null 2>&1
			apt install -y bash  > /dev/null 2>&1
fi

SESSIONID=`curl -s -X POST "http://localhost/web/session" |grep -o -E "<e2sessionid>(.*)</e2sessionid>" |sed "s|.*<e2sessionid>\(.*\)</e2sessionid>.*|\\1|"` >/dev/null 2>&1
curl -X POST "http://localhost/web/message?text=Edit%20Sky%20Settings...%20please%20stand%20by%20:)%20%20&type=1&timeout=5&sessionid=$SESSIONID" >/dev/null 2>&1

_dir="/etc/enigma2"

old1='1%3a0%3a19%3a84%3a9%3a85'
old2='1%3a0%3a19%3a7A%3a9%3a85'
old3='1%3a0%3a19%3a74%3a9%3a85'
old4='1%3a0%3a19%3a85%3a9%3a85'
old5='1%3a0%3a19%3a11%3a9%3a85'
old6='1%3a0%3a19%3a13E%3a9%3a85'
old7='1%3a0%3a19%3a148%3a9%3a85'
old8='1%3a0%3a19%3a13D%3a9%3a85'
old9='1%3a0%3a19%3a147%3a9%3a85'
old10='1%3a0%3a19%3a105%3a9%3a85'
old11='1%3a0%3a19%3a106%3a9%3a85'
old23='Discovery HD'

old12='1:0:19:84:9:85'
old13='1:0:19:7A:9:85'
old14='1:0:19:74:9:85'
old15='1:0:19:85:9:85'
old16='1:0:19:11:9:85'
old17='1:0:19:13E:9:85'
old18='1:0:19:148:9:85'
old19='1:0:19:13D:9:85'
old20='1:0:19:147:9:85'
old21='1:0:19:105:9:85'
old22='1:0:19:106:9:85'


new1='1%3a0%3a19%3a84%3aB%3a85'
new2='1%3a0%3a19%3a7A%3aB%3a85'
new3='1%3a0%3a19%3a74%3a4%3a85'
new4='1%3a0%3a19%3a85%3a2%3a85'
new5='1%3a0%3a19%3a11%3a6%3a85'
new6='1%3a0%3a19%3a13E%3a6%3a85'
new7='1%3a0%3a19%3a148%3aC%3a85'
new8='1%3a0%3a19%3a13D%3a6%3a85'
new9='1%3a0%3a19%3a147%3aC%3a85'
new10='1%3a0%3a19%3a105%3aC%3a85'
new11='1%3a0%3a19%3a106%3a6%3a85'
new23='National Geographic HD'

new12='1:0:19:84:B:85'
new13='1:0:19:7A:B:85'
new14='1:0:19:74:4:85'
new15='1:0:19:85:2:85'
new16='1:0:19:11:6:85'
new17='1:0:19:13E:6:85'
new18='1:0:19:148:C:85'
new19='1:0:19:13D:6:85'
new20='1:0:19:147:C:85'
new21='1:0:19:105:C:85'
new22='1:0:19:106:6:85'

for file in "$_dir"/*.tv; do
  if [ -f "$file" ]; then
    echo "Bearbeite $file..."
    sed -i \
      -e "s/$old1/$new1/g" \
      -e "s/$old2/$new2/g" \
      -e "s/$old3/$new3/g" \
      -e "s/$old4/$new4/g" \
      -e "s/$old5/$new5/g" \
      -e "s/$old6/$new6/g" \
      -e "s/$old7/$new7/g" \
      -e "s/$old8/$new8/g" \
      -e "s/$old9/$new9/g" \
      -e "s/$old10/$new10/g" \
      -e "s/$old11/$new11/g" \
      -e "s/$old12/$new12/g" \
      -e "s/$old13/$new13/g" \
      -e "s/$old14/$new14/g" \
      -e "s/$old15/$new15/g" \
      -e "s/$old16/$new16/g" \
      -e "s/$old17/$new17/g" \
      -e "s/$old18/$new18/g" \
      -e "s/$old19/$new19/g" \
      -e "s/$old20/$new20/g" \
      -e "s/$old21/$new21/g" \
      -e "s/$old22/$new22/g" \
      -e "s/$old23/$new23/g" "$file"
  fi
done

if [ -e /etc/enigma2/whitelist_streamrelay ]; then
  sed -i \
    -e "s/$old12/$new12/g" \
    -e "s/$old13/$new13/g" \
    -e "s/$old14/$new14/g" \
    -e "s/$old15/$new15/g" \
    -e "s/$old16/$new16/g" \
    -e "s/$old17/$new17/g" \
    -e "s/$old18/$new18/g" \
    -e "s/$old19/$new19/g" \
    -e "s/$old20/$new20/g" \
    -e "s/$old21/$new21/g" \
    -e "s/$old22/$new22/g" "/etc/enigma2/whitelist_streamrelay"
fi

if [ -e /etc/enigma2/icamref.json ]; then
  sed -i \
    -e "s/$old12/$new12/g" \
    -e "s/$old13/$new13/g" \
    -e "s/$old14/$new14/g" \
    -e "s/$old15/$new15/g" \
    -e "s/$old16/$new16/g" \
    -e "s/$old17/$new17/g" \
    -e "s/$old18/$new18/g" \
    -e "s/$old19/$new19/g" \
    -e "s/$old20/$new20/g" \
    -e "s/$old21/$new21/g" \
    -e "s/$old22/$new22/g" \
	-e "s/$old23/$new23/g" "/etc/enigma2/icamref.json"
fi

_picon_dirs=(
  "/media/hdd/picon"
  "/media/usb/picon"
  "/usr/share/enigma2/picon"
)

declare -A file_to_name=(
["1_0_19_84_9_85_C00000_0_0_0.png"]="1_0_19_84_B_85_C00000_0_0_0.png"
["1_0_19_7A_9_85_C00000_0_0_0.png"]="1_0_19_7A_B_85_C00000_0_0_0.png"
["1_0_19_74_9_85_C00000_0_0_0.png"]="1_0_19_74_4_85_C00000_0_0_0.png"
["1_0_19_85_9_85_C00000_0_0_0.png"]="1_0_19_85_2_85_C00000_0_0_0.png"
["1_0_19_11_9_85_C00000_0_0_0.png"]="1_0_19_13E_6_85_C00000_0_0_0.png"
["1_0_19_13E_9_85_C00000_0_0_0.png"]="1_0_19_148_C_85_C00000_0_0_0.png"
["1_0_19_148_9_85_C00000_0_0_0.png"]="1_0_19_13D_6_85_C00000_0_0_0.png"
["1_0_19_13D_9_85_C00000_0_0_0.png"]="1_0_19_147_C_85_C00000_0_0_0.png"
["1_0_19_147_9_85_C00000_0_0_0.png"]="1_0_19_11_6_85_C00000_0_0_0.png"
["1_0_19_105_9_85_C00000_0_0_0.png"]="1_0_19_105_C_85_C00000_0_0_0.png"
["1_0_19_106_9_85_C00000_0_0_0.png"]="1_0_19_106_6_85_C00000_0_0_0.png"
["1_0_19_84_9_85_FFFF0000_0_0_0.png"]="1_0_19_84_B_85_FFFF0000_0_0_0.png"
["1_0_19_7A_9_85_FFFF0000_0_0_0.png"]="1_0_19_7A_B_85_FFFF0000_0_0_0.png"
["1_0_19_74_9_85_FFFF0000_0_0_0.png"]="1_0_19_74_4_85_FFFF0000_0_0_0.png"
["1_0_19_85_9_85_FFFF0000_0_0_0.png"]="1_0_19_85_2_85_FFFF0000_0_0_0.png"
["1_0_19_11_9_85_FFFF0000_0_0_0.png"]="1_0_19_13E_6_85_FFFF0000_0_0_0.png"
["1_0_19_13E_9_85_FFFF0000_0_0_0.png"]="1_0_19_148_C_85_FFFF0000_0_0_0.png"
["1_0_19_148_9_85_FFFF0000_0_0_0.png"]="1_0_19_13D_6_85_FFFF0000_0_0_0.png"
["1_0_19_13D_9_85_FFFF0000_0_0_0.png"]="1_0_19_147_C_85_FFFF0000_0_0_0.png"
["1_0_19_147_9_85_FFFF0000_0_0_0.png"]="1_0_19_11_6_85_FFFF0000_0_0_0.png"
["1_0_19_105_9_85_FFFF0000_0_0_0.png"]="1_0_19_105_C_85_FFFF0000_0_0_0.png"
["1_0_19_106_9_85_FFFF0000_0_0_0.png"]="1_0_19_106_6_85_FFFF0000_0_0_0.png"
["1_0_19_84_9_85_21_0_0_0.png"]="1_0_19_84_B_85_21_0_0_0.png"
["1_0_19_7A_9_85_21_0_0_0.png"]="1_0_19_7A_B_85_21_0_0_0.png"
["1_0_19_74_9_85_21_0_0_0.png"]="1_0_19_74_4_85_21_0_0_0.png"
["1_0_19_85_9_85_21_0_0_0.png"]="1_0_19_85_2_85_21_0_0_0.png"
["1_0_19_11_9_85_21_0_0_0.png"]="1_0_19_13E_6_85_21_0_0_0.png"
["1_0_19_13E_9_85_21_0_0_0.png"]="1_0_19_148_C_85_21_0_0_0.png"
["1_0_19_148_9_85_21_0_0_0.png"]="1_0_19_13D_6_85_21_0_0_0.png"
["1_0_19_13D_9_85_21_0_0_0.png"]="1_0_19_147_C_85_21_0_0_0.png"
["1_0_19_147_9_85_21_0_0_0.png"]="1_0_19_11_6_85_21_0_0_0.png"
["1_0_19_105_9_85_21_0_0_0.png"]="1_0_19_105_C_85_21_0_0_0.png"
["1_0_19_106_9_85_21_0_0_0.png"]="1_0_19_106_6_85_21_0_0_0.png"

)

for _picon_dir in "${_picon_dirs[@]}"; do
  for old_name in "${!file_to_name[@]}"; do

    if [ -f "$_picon_dir/$old_name" ]; then
      echo "Found: $_picon_dir/$old_name"

      mv "$_picon_dir/$old_name" "$_picon_dir/${file_to_name[$old_name]}"
      echo "Rename: $_picon_dir/${file_to_name[$old_name]}"
    fi
  done
done

echo " Create National Geograpic Picon"
wget -O /tmp/1_0_19_82_6_85_C00000_0_0_0.png i.tv-lounge.eu/ot_picons/1_0_19_82_6_85_C00000_0_0_0.png > /dev/null 2>&1
wget -O /tmp/1_0_19_77_4_85_21_0_0_0.png i.tv-lounge.eu/ot_picons/1_0_19_77_4_85_21_0_0_0.png > /dev/null 2>&1
if [ ! -d "/usr/share/enigma2/picon" ]; then
    mkdir -p "/usr/share/enigma2/picon"
fi

cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_C00000_0_0_0.png  > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_C00000_0_0_0.png  > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_21_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_77_4_85_21_0_0_0.png /usr/share/enigma2/picon/1_0_19_77_4_85_21_0_0_0.png > /dev/null 2>&1

if [ -d "/media/usb/picon" ]; then
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_C00000_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_21_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_FFFF0000_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_77_4_85_21_0_0_0.png /media/usb/picon/1_0_19_77_4_85_21_0_0_0.png > /dev/null 2>&1
fi

if [ -d "/media/hdd/picon" ]; then
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_C00000_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_21_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_FFFF0000_0_0_0.png > /dev/null 2>&1
cp /tmp/1_0_19_77_4_85_21_0_0_0.png /media/hdd/picon/1_0_19_77_4_85_21_0_0_0.png > /dev/null 2>&1

fi

SESSIONID=`curl -s -X POST "http://localhost/web/session" |grep -o -E "<e2sessionid>(.*)</e2sessionid>" |sed "s|.*<e2sessionid>\(.*\)</e2sessionid>.*|\\1|"` #>/dev/null 2>&1
curl -s -X POST 'http://127.0.0.1/web/servicelistreload?mode=0&sessionid=$SESSIONID' > /dev/null 2>&1
curl -s -X POST 'http://127.0.0.1/web/servicelistreload?mode=0&sessionid=$SESSIONID' > /dev/null 2>&1

echo "Done"
