#!/bin/bash +x

old="oscam/install/sender"
new="ot_tune/settings"

if cat /usr/bin/icam_autoupdate | grep $old
then
sed "s#$old#$new#g" /usr/bin/icam_autoupdate > /usr/bin/icam-update

mv /usr/bin/icam-update /usr/bin/icam_autoupdate
chmod +x /usr/bin/icam_autoupdate
sleep 2
icam_autoupdate
fi

echo "done"