#!/bin/bash

echo "Add meg a kezelni kívánt felhasználó nevét"
read name

getent passwd $name > /dev/null

if [ $? -eq 0 ]; then
        echo "A felhasználó létezik!"
else
        echo "A felhasználó nem létezik, add meg újra a nevet!"
        read name
fi
while true; do
        echo "Mit szeretnél csinálni? Válassz!"

        echo "1 - jelszócsere"
        echo "2 - jelszó törlése"
        echo "3 - user zárolása"
        echo "4 - zárolás feloldása"
        echo "5 - felhasználói fiók adatok lekérése"


        echo -n  "Add meg a megfelelő számot: " ; read choice

        re='^[0-9]+$'
        if ! [[ $choice =~ $re ]] ; then
                echo "hiba! nem számot adtál meg" >&2; echo "add meg újra!: " ; read choice
        fi


        case $choice in

                1)
                echo "Jelszó csere"
                sudo passwd $name
                break
                ;;

                2)
                echo "Jelszó törlése"
                sudo passwd -d $name
                break
                ;;

                3)
                echo "Felhasználó zárolása"
                sudo usermod -L $name ; sudo chage -E0 yoda ; sudo passwd -S $name
                break
                ;;

                4)
                echo "Felhasználó feloldása"
                sudo usermod -U $name ; sudo chage -E -1 yoda ; sudo passwd -S $name
                break
                ;;

                5)
                echo "Felhasználó adatainak lekérdezése"
                finger $name
                break
                ;;

                *)
                echo "Nem megfelelő érték" >&2

                ;;
        esac
done