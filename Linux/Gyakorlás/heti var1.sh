 #!/bin/bash

echo "Add meg a választott csoportot"
read keresettcsoport

echo -e "A csoport id-ja a következő: \c"
cat /etc/group | cut -d : -f1,3| grep $keresettcsoport | cut -d : -f2

echo -e "A csoport tagjai: "
cut -d: -f1,4 /etc/passwd | grep ":$(getent group $keresettcsoport |cut -d: -f3)$" | cut -d: -f1
getent group $keresettcsoport | cut -d: -f4

cut -d: -f1,4 /etc/passwd | grep ":$(getent group $keresettcsoport |cut -d: -f3)$" | cut -d: -f1 >csoporttagok.txt
getent group $keresettcsoport | cut -d: -f4 | tr ',' '\n' >>csoporttagok.txt
#cat csoporttagok.txt
for tag in `cat csoporttagok.txt`
do
find $HOME -user $tag -type d 
done


Így is lehet, ez sokkal egyszerűbb, csak akkor az ID kell hozzá
cat /etc/passwd |cut -f1,4 -d:| grep $keresettcsoportID | cut -f1 -d:| cut -d: -f4
getent group $keresettcsoport | cut -d: -f4



#!/bin/bash

SAMBA_GROUP_ID=(`getent group sambashare | cut -d: -f3 | tr ',' ' '`) ; echo $SAMBA_GROUP_ID

OWN_GROUP_ID=(`getent group $USER | cut -d: -f3 |  tr ',' ' '`) ; echo $OWN_GROUP_ID

SAMBA_GROUP_MEMBER_LIST=$(cat /etc/passwd |cut -f1,4 -d:| grep $SAMBA_GROUP_ID | cut -f1 -d:| cut -d: -f4) ; echo $SAMBA_GROUP_MEMBER_LIST
MY_GROUP_MEMBER_LIST=$(cat /etc/passwd |cut -f1,4 -d: | grep $OWN_GROUP_ID | cut -f1 -d:) ; echo $MY_GROUP_MEMBER_LIST

for member in $SAMBA_GROUP_MEMBER_LIST ; do
echo -e "\n $member felhasználó mappái: \n"
find / -user $member -type d 2> /dev/null
done

for member in $MY_GROUP_MEMBER_LIST ; do
echo -e "\n $member felhasználó mappái: \n"
find / -user $member -type d 2> /dev/null
done


