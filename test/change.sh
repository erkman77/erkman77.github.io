
Version_new="11111"
_oscambin="oscam-erki"
wget -O /tmp/oscam_update.sh https://i.tv-lounge.eu/test/oscam_update.sh
camname=$(cat <<EOF
sed -i '3s/.*/CAMNAME=\"OSCam v$Version_new\"/' /tmp/oscam_update.sh
EOF
)
eval $camname
bin=$(cat <<EOF
sed -i '4s/.*/binary=\"$_oscambin\"/' /tmp/oscam_update.sh
EOF
)
eval $bin
mv /tmp/oscam_update.sh /usr/script/$_oscambin.sh
chmod +x /usr/script/$_oscambin.sh