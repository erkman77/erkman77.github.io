#!/bin/bash +x

old="oscam/install/sender"
new="ot_tune/settings"

if cat /usr/bin/icam_autoupdate | grep $old
then
echo "Fixing autoupdate..."
sed -i "s#$old#$new#g" /usr/bin/icam_autoupdate 

echo -e "\e[32m all done ...\e[0m"
  echo -e "\e[33m ... doing restart \e[0m"
  sleep 3
  reboot

else  

echo "Nothing to do, autoupdate seems to be ok"

fi

