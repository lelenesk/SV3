#!/bin/bash 

#Beadandó fájlok neve: user_manager.sh, nagyfile, userid
#A fájlműveleteket a “vizsgabash” könyvtár tartalmával kell elvégezni

#Elérési út Linuxos környezetben: /home/felhasználóneved/vizsgabash
mkdir -p /home/linuxadmin/vizsgabash/sportolo/{vivo,bokszolo,uszo}

#Hozzuk létre az alábbi lokális felhasználói csoportokat
groupadd vivo
groupadd bokszolo
groupadd uszo

#Hozzuk létre az alábbi felhasználókat, és add meg úgy a jelszavukat, hogy titkosítottan kerüljön letárolásra.
#Rakjuk bele az alábbi csoportokba az alábbi felhasználókat
sudo useradd vivo_1 -N -g vivo -p v31sz0
sudo useradd vivo_2 -N -g vivo -p v31sz0
sudo useradd bokszolo_1 -N -g bokszolo -p b31sz0
sudo useradd bokszolo_2 -N -g bokszolo -p b31sz0
sudo useradd uszo_1 -N -g uszo -p u31sz0
sudo useradd uszo_2 -N -g uszo -p u31sz0

#Állítsuk be az alábbi jogosultságokat:
#/home/felhasználóneved/vizsgabash/sportolo/vivo mappára és a benne lévő fájlokra:
#tulajdonos felhasználó vivo_1 írás, olvasás, futtatás joggal
#tulajdonos csoport vivo írás és olvasás joggal
#más ne férjen hozzá

chown vivo_1:vivo /home/linuxadmin/vizsgabash/sportolo/vivo
chmod 760 -R /home/linuxadmin/vizsgabash/sportolo/vivo

#/home/felhasználóneved/vizsgabash/sportolo/bokszolo mappára és a benne lévő fájlokra (bejárhatóságra figyelj)
#tulajdonos felhasználó bokszolo_2 írás, olvasás joggal
#tulajdonos csoport bokszolo olvasás joggal
#más ne férjen hozzá

chown bokszolo_2:bokszolo /home/linuxadmin/vizsgabash/sportolo/bokszolo
chmod 640 -R /home/linuxadmin/vizsgabash/sportolo/bokszolo

#/home/felhasználóneved/vizsgabash/sportolo/uszo
#tulajdonos felhasználó uszo_1 olvasás joggal
#tulajdonos csoport uszo olvasás joggal
#más ne férjen hozzá

chown uszo_1:uszo /home/linuxadmin/vizsgabash/sportolo/uszo
chmod 440 -R /home/linuxadmin/vizsgabash/sportolo/uszo


#Irasd a /home/felhasználóneved/vizsgabash/userid fájlba a létrehozott mappastruktúra lekérdezését a jogosultságokkal együtt.
tree -pug /home/linuxadmin/vizsgabash >> userid.txt

#Listázzuk ki a 3 megabájtál nagyobb fájlokat a var könyvtárból és az eredményt írd bele a /home/felhasználóneved/vizsgabash/nagyfile fájlba.
find /var -type f -size +3M > /home/linuxadmin/vizsgabash/nagyfile.txt

#Másold át a passwd fájlt a  /home/felhasználóneved/vizsgabash mappába és a következő lekérdezés eredményét írasd a   /home/felhasználóneved/vizsgabash/userid fájlba.
cp /etc/passwd /home/linuxadmin/vizsgabash/copied_passwd

#Az első sort amely tartalmazza az 'uszo' szót.
cat /home/linuxadmin/vizsgabash/copied_passwd |cut -f1,4 -d:| grep uszo | tr ',' ' ' | head -1 >> /home/linuxadmin/vizsgabash/userid.txt

#Utoljára létrehozott 3 useraccount adatait.
cat /home/linuxadmin/vizsgabash/copied_passwd | last -3 >> /home/linuxadmin/vizsgabash/userid.txt

#A felhasználói (tehát nem a linux által létrehozott/foglalt) accountok adatait.
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
        if [[ "$f3" -gt 1000 ]] ; then
        $f1 >> /home/linuxadmin/vizsgabash/userid.txt
        else
        echo "Nincs nem rendszer által létrehozott user"
        fi
done < /home/linuxadmin/vizsgabash/copied_passwd