
#FONTOS
MINDEN SCRIPT LEGELSŐ SORA: '#!/bin/bash' (idézőjel nem kell, itt adjuk meg a héjat, jelen esetben bashben fog futni)
vagy "#!/usr/bin/env bash"   KOMPATIBIlIS MEGADÁS


#LÉPÉSEK: 
#1.hozzunk létre egy fájlt,2.tegyük futtathatóvá
touch sajatscript1.sh ; chmod +x sajatscript1.sh && mcedit sajatscript1.sh #(azonnal szerkeszthető lesz DECSAKHA jogosultság is ok)
#3.majd futtasuk:
./sajatscript1.sh 
#vagy
bash sajatscript1.sh  #nincs értelme, mert az első sor amúgy is meghív már egy bash-t és abban fog futni
#vagy
source sajatscript1.sh #így nem kell futtathatóvá tenni a srciptet

#ÁLTALÁNOSSÁGBAN:
IF,THEN,ELIF,ELSE HASZNÁLHATÓ, EXIT is van és kell (kis betűkkel írjuk)
-LT -GT szintén használható (lessthen, greaterthen stb...)
WHILE,TRUE,BREAK,DO,DONE,FOR,CASE,ESAC szintén használható
DATUM --> Változókat általában csupa nagybetűvel írjuk
${DATUM} --> MINDIG hivatkozzunk {} között rá, különben a bash nem feltétlen tudja meddig terjed a karkaterlánc
Az = jelnél sose hagyjunk szóközt
értéket mindig = jellel, számokat mindig szövegesen (lt,gt) hasonlítunk össze


$0 Scriptünk neve
$# parancssori paraméterek száma
$? legutoljára végrehajtot parancs kimeneti értéke
$$ futó srcipt PID-je (folyamat azonosítója)
$! a háttérben utoljára végrehajtot parancs folyamatazonosítója
$1,$2,$3......$10 ezek a változók sorrendben hivatkoznak a megadott paramétekre
$* minden parancsosori paraméter egyben (karakterláncként)
$@ minden parancsosori paraméter külön, idézőjelek között
-n --> teszteli hogy üres stringet adtunk-e be
[] mindig szóköz legyen benne pl if feltételnél

'It\'s my first scipt in here' --> a \ után írt karaktert stringnek veszi. Itt a 3db aposztrof miatt hiba lenne.
megoidható ""-al is mint pythonban'

#+1 trükk a sorok tördelése ellen (midnight commander)
F9->felső menű elérése, majd beállítások fül,majd általános
további opciók alatt--> ÚJ SOR AUTO BEHÚZÁS--> vegyük ki a jelölést

#----------------TOVÁBBI PARANCSOK-------------------------------------------------
echo                     kiirja a parancssorra a stringet
read valami              valamilyen változó bekérése és mentése a valami változóba (usertől pl)
true                     mindig 0 a kimenete
false                    mindig 1 a kimenete (hibát jelent)
logger                   napló bejegyzés készítése
`seq`                    igazából külön program a linuxban, elszámol x-től y-ig
DATUM=$(date +%F)        jelenlegi dátum év,hónap,nap formázással (lekérdezi az oprendszer)

#------------------------------PÉLDÁK-----------------------------------------------

#!/bin/bash
if [ $1 -lt 0 ]
then
    echo "a megadott paraméter negatív"
    exit 0
elif [ $1 -gt 0 ]; then
    echo "a megadott paraméter pozitív"
    exit 0
else 
    echo "a megadott paraméter nulla"
    exit 0
fi   #vizsgálat lezárása, kötelező
exit 0 #nem kötelező de célszerű


#!/bin/bash
echo -n "Gyümölcs: "
read valami

if [[ "$valami" = "alma" ]]; then
    echo "ez egy alma"
elif [[ "$valami" = "szilva" ]]; then
    echo "ez meg egy szilva"
else
    echo "se nem szilva, se nem alma"
fi


(ha beírok valamit kilép, ha csak enter akkor várja a végtelenségig hogy berijak valamit)
(készülhet egy napló bejegyzés is. Ellenőrzése: tail -f /var/log/messages)
#!/bin/bash
while true 
do
    read -p "Írj be egy sort:" line
    #ha nem üres a beolvasott sor kilépek a ciklusból
    if [ -n "$line" ]
    then
    logger "napló bejegyzés"
        break
    fi
done


(lehet olyat is hogy "seq 10 -1 1", így visszafele számol,"seq 10 -2 1" így pedig kettsével ugrál, lehetne 3asával stb sznitén visszafelé de kell a - előtag ilyenkor)
#!/bin/bash
for i in `seq 1 10`
    do
    echo $i
done


#!/bin/bash
for i in alma körte géza béla
    do
    echo $i
done

(ez egy régi módszer)
(a menupont valtozo lehet O,o,H,h,S,s)
(a ;; zárja a nagy betű és ;; részt, ide kerül hogy mit csináljon)
(a zárójelet nem kell kinyitni, ez a menupont és a ")" közti részt zárja ée )
#!/bin/bash
echo "[O]lvas"
echo "[H]ozzáfűz"
echo "[S]zerkeszt"

read menupont
case "$menupont" in
    "O" | "o")
        echo "olvasási műveletek"
        for i in alma körte géza béla
            do
            echo $i
        done
    ;;
    "H" | "h")
        echo "hozzáfűzési műveletek"
    ;;
    "S" | "s")
        echo "szerkesztési műveletek"
    ;;
esac

#!/bin/bash
DATUM=$(date +%F)
mkdir -p /tanf/${DATUM}webserver
ls -l /tanf













