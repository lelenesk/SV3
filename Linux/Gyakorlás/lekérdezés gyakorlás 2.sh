while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
do
        if [[ "$f3" -lt 101 ]] ; then
        echo -e "Username: $f1 \nUser ID: $f3\nHome directory path: $f6\n"
        elif [[ "$f1" = "nobody" ]] ; then
        :
        else
        echo -e "Ez itt egy nemszázas user hihi :-P -->\t$f1 \n\t\tez meg itt az UID-je:\t$f3\n"
        fi
done < /etc/passwd
# https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/






#!/bin/bash

file="/etc/passwd" # megadom melyik fájlal szeretnék dolgozni ez van a while végén
#
# a : karaktert használva a sort szétválasztom mezőkre amikre utána tudok hivatkozni
#
while IFS=: read -r f1 f2 f3 f4 f5 f6 f7 #az IFS változónak megadom, hogy a : karakter legyen a delimiter és
#annak mentén bontsa szét a sorokat f1..f7. mezőkre, amikre a továbbiakban hivatkozhatok
# a -r kapcsoló pedig kiszűri hogy a \ karakter ne okozzon gondot
do
        # megadom a feltételeket, amiknek megfelelő adatokat szeretnék látni
        if  [[ f3 -ge 1 && f3 -le 100 ]]  #az f3 mező tartalmazza a UID-t és feltételként megadom a minimális
#maximális értéket. A két && karakterrel csinálok a feltételek között logikai és kapcsolatot
        then
        echo "username: $f1 UID: $f3"  #kiiratom a feltételnek megfelelő sorok megfelelő mezőit
        fi #zárom az if feltételt
done <"$file" #zárom a while ciklust
