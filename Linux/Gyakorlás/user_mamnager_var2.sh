#!/bin/bash
cd "/home/chump/vizsgabash/"

groupadd vivo
groupadd bokszolo
groupadd uszo

useradd -p v31sz0 -g vivo vivo_1
useradd -p v31sz0 -g vivo vivo_2
useradd -p b31sz0 -g bokszolo bokszolo_1
useradd -p b31sz0 -g bokszolo bokszolo_2
useradd -p u31sz0 -g bokszolo uszo_1
useradd -p u31sz0 -g bokszolo uszo_2

mkdir sportolo
mkdir sportolo/vivo
mkdir sportolo/bokszolo
mkdir sportolo/uszo

# Ez egy újonnan létrehozott mappaszerkezet, fájlok nem lesznek benne.
# A létrehozott fájlokra a default és az umask szerinti engedélyek
# lesznek alkalmazva
chmod -R u=rwx,g=rwx,o= sportolo/vivo
chown vivo_1:vivo sportolo/vivo

chmod -R u=rwx,g=rx,o= sportolo/bokszolo
chown bokszolo_2:bokszolo sportolo/bokszolo

chmod -R u=rx,g=rx,o= sportolo/uszo
chown uszo_1:uszo sportolo/uszo

ls -l > userid

find /var/ -size +3M 1> nagyfile 2> /dev/null

cp /etc/passwd .
grep uszo ./passwd | head --lines=1 >> userid
cat ./passwd | tail --lines=3 >> userid
cat ./passwd | grep -E ':[1-9][0-9]{3,}:[0-9]' | grep -Ev '^(nobody)' >> userid