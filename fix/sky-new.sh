#!/bin/bash

_dir="/etc/enigma2"

old1='1%3a0%3a19%3a84%3a9%3a85'
old2='1%3a0%3a19%3a7A%3a9%3a85'
old3='1%3a0%3a19%3a74%3a9%3a85'
old4='1%3a0%3a19%3a85%3a9%3a85'
old5='1%3a0%3a19%3a11%3a6%3a85'
old6='1%3a0%3a19%3a13E%3a6%3a85'
old7='1%3a0%3a19%3a148%3aC%3a85'
old8='1%3a0%3a19%3a13D%3a6%3a85'
old9='1%3a0%3a19%3a147%3aC%3a85'
old10='1%3a0%3a19%3a105%3aC%3a85'
old11='1%3a0%3a19%3a106%3a6%3a85'
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
echo "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)" /g base64 -d > /tmp/1_0_19_82_6_85_C00000_0_0_0.png
if [ -d "/usr/share/enigma2/picon" ]; then
    mkdir -p "/usr/share/enigma2/picon"
fi

cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_C00000_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_21_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /usr/share/enigma2/picon/1_0_19_82_6_85_FFFF0000_0_0_0.png

if [ -d "/media/usb/picon" ]; then
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_C00000_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_21_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/usb/picon/1_0_19_82_6_85_FFFF0000_0_0_0.png
fi

if [ -d "/media/hdd/picon" ]; then
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_C00000_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_21_0_0_0.png
cp /tmp/1_0_19_82_6_85_C00000_0_0_0.png /media/hdd/picon/1_0_19_82_6_85_FFFF0000_0_0_0.png
fi

SESSIONID=`curl -s -X POST "http://localhost/web/session" /ggrep -o -E "<e2sessionid>(.*)</e2sessionid>" /gsed "s/g.*<e2sessionid>\(.*\)</e2sessionid>.*/g\\1/g"` #>/dev/null 2>&1
curl -s -X POST 'http://127.0.0.1/web/servicelistreload?mode=0&sessionid=$SESSIONID' > /dev/null 2>&1
curl -s -X POST 'http://127.0.0.1/web/servicelistreload?mode=0&sessionid=$SESSIONID' > /dev/null 2>&1

echo "Done"
