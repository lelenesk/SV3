mkdir -p felmero/alfelmero
cd felmero
touch negyedeves feleves zaro
cd alfelmero
touch al_negyedeves al_feleves al_zaro

--------ellenőrzés----------------
cd ~
tree
--------ellenőrzés----------------

chmod 744 felmero/feleves
chmod 744 felmero/negyedeves
chmod 744 felmero/zaro

--------ellenőrzés----------------
ls -lR
(Azért nem: "chmod 744 -R felmero/" mert ez nem csak a fájlokra vonatkozna, hanem a felmero mappára is ami nem szerepel a feladat leírásában)
--------ellenőrzés----------------

sudo groupadd tanar1

--------ellenőrzés----------------
cat /etc/group
--------ellenőrzés----------------

sudo useradd matek_tanar -N -g tanar1
sudo useradd kemia_tanar -N -g tanar1
sudo useradd angol_tanar -N -g tanar1

--------ellenőrzés----------------
cat /etc/passwd
--------ellenőrzés----------------

sudo chgrp tanar1 -R felmero/alfelmero
sudo chmod 474 -R felmero/alfelmero

--------ellenőrzés----------------
sudo -i
cd /home/linuxadmin/
tree -pug
--------ellenőrzés----------------

















