#!/bin/bash

echo "Add meg a választott csoportot:"
read groupname
echo "Add meg a keresett felhasznalót:"
read name
echo "***"

GROUP_ID=(`getent group $groupname | cut -d: -f3 | tr ',' ' '`)
CURRENT_USER_ID=(`getent group $USER | cut -d: -f3 |  tr ',' ' '`)
SEARCHED_USER_ID=(`getent group $name | cut -d: -f3 |  tr ',' ' '`)
#GROUP_1=$(sudo groupmems -l -g $groupname)
GROUP_A=(`cat /etc/passwd |cut -f1,4 -d:| grep $SEARCHED_USER_ID | cut -f1 -d:| cut -d: -f4`) 
GROUP_B=(`getent group $groupname | cut -d: -f4`)
GROUP1=$GROUP_A+$GROUP_B

if [ -z "$GROUP_1" ]; then
        GROUP_S=$groupname;
        ECHO "NEM JÓ ÁG"
else
        GROUP_S=$GROUP_1;
fi

for counter in $CURRENT_USER_ID; do
        echo -e "Választott csoport id: $GROUP_ID\nKeresett felhasználó id: $SEARCHED_USER_ID\n(Jelenlegi felhasználó i>        done
for tag in $GROUP_S;
        do
        MAPPS=$(sudo find / -user $tag -type d)
        echo -e "\n$tag Mappái:\n$MAPPS\n"
        done




  GNU nano 6.2                                                                                       ezazezaz.sh *
#!/bin/bash

echo "Add meg a választott csoportot:"
read groupname
echo "Add meg a keresett felhasznalót:"
read name
echo "***"

GROUP_ID=(`getent group $groupname | cut -d: -f3 | tr ',' ' '`)
CURRENT_USER_ID=(`getent group $USER | cut -d: -f3 |  tr ',' ' '`)
SEARCHED_USER_ID=(`getent group $name | cut -d: -f3 |  tr ',' ' '`)
#GROUP_1=$(sudo groupmems -l -g $groupname)
GROUP_A=(`cat /etc/passwd |cut -f1,4 -d:| grep $SEARCHED_USER_ID | cut -f1 -d:| cut -d: -f4 | tr ',' ' '`)
GROUP_B=(`getent group $groupname | cut -d: -f4 | tr ',' ' '`)
GROUP_1=$GROUP_A $GROUP_B

if [ -z "$GROUP_1" ]; then
        GROUP_S=$groupname;
        echo "NEM JÓ ÁG"
else
        GROUP_S=$GROUP_1;
fi

for group in $GROUP_S; do
        GROUPUSERS=$(`sudo groupmems -l -g $group`)
        done

for counter in $CURRENT_USER_ID; do
        echo -e "Választott csoport id: $GROUP_ID\nKeresett felhasználó id: $SEARCHED_USER_ID\n(Jelenlegi felhasználó  id:) $CURRENT_USER_ID\n$name Felhasználó csoportjai:\n$GROUP_S\n"
        done
for tag in $GROUPUSERS; do
        MAPPS=$(`sudo find / -user $tag -type d`)
        echo -e "\nMappái:\n$MAPPS\n"
        done