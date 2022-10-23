Linux bash script
# Bash script

Segítségével "Forgatókönyvet" tudunk írni linux-os környezetben futtatandó feladatainknak.

Az első sornak mindig tartalmaznia kell a parancsértelmező bináris útvonalát. Esetünkben ez a /bin/bash.

bash
#!/bin/bash


## Futtatási jog

bash
chmod +x file.sh


## Comment

Lehetőségünk van komment sorokkal ellátni a script-et, ezek a sorok nem kerülnek kiértékelésre, csak az olvashatóságban segítenek. Ezek a sorok #-el kezdődnek

bash
# Ez a sor nem kerül kiértékelésre
## Az escape karakter

Vannak karakterek a bash-ben, amik parancs futtatására vonatkoznak. Amennyiben ilyen karaktert szeretnénk kiíratni a képernyőre a \ karakter után kell hivatkoznunk arra, hogy ki szeretnénk lépni a parancsértelmező módból, és a soron közvetkező karakter megjelenítésre kerüljön.

bash
echo 'Ez egy dollár jel: \$'


## Változók

Az alábbi módon definiálunk és adunk értéket a változóknak:  

változóneve=értéke

bash
num_a=5
string_a='szöveg'


Lehetőségünk van a futó script-tel beolvasni változó értéket

bash
read valtozo


A változókra $ előtaggal fogunk hivatkozni:

bash
echo $string_a


Léteznek beépített változók is, melyekkel a paraméterekre tudunk hivatkozni

bash
$0 # jelöli a script nevét
$1 # az első megadott paraméter értéke
${2..10} # értelem szerűen az x. paraméter értéke
$$ # a futó script PID (process ID) értéke
$# # megadja, hogy hány darab paraméterünk van
$* # szóközzel felsorolja az összes megadaott paramétert


## Feltételes vezérlés (Conditional Statements)

Egy ha akkor logikai vizsgálat után eldönthetjük a következő kódblokkunk lefusson-e  

Kötelező elemei: IF, THEN  

Nem kötelező elemei: ELSE, ELIF THEN  

Szintaktikája a következő:  

bash
if [[ feltétel ]]
then # lefut, ha igaz
else # lefut, ha hamis
 elif # másik feltétel
  then #lefut, ha ez a feltétel igaz
fi # lezárás
## Programkód kiértékelése változóba

Lehetőségünk van egy válozó értének használni egy program lefutott kimentét. Ezt kétféleképpen is elérhetjük:

bash
string_a=`date`
string_b=$(date)


### Logikai vizsgálatok

2 szám vagy string között az alábbi vizsgálatokat tudjuk tenni: egyenlő, nem egyenlő, kisebb vagy nagyobb.  

A jelölési forma így néz ki:



"less than"				-lt				<  

"greater than"			-gt				>  

"equal"					-eq				=  

"not equal"				-ne				!=  

"less or equal"			-le				N/A  

"greater or equal"		-ge				N/A



Példák:

bash
#!/bin/bash


if [ $1 -lt 0 ]
then
  echo "A megadott paraméter negatív"
  elif [ $1 -gt 0 ]
  then
    echo "A megadott paraméter pozitív"
  else
    echo "A megadott paraméter nulla"
fi
bash
num_a=4
num_b=6


if [[ $num_a -le $num_b ]]
 then
  echo "A feltétel igaz"
 else
  echo "A feltétel hamis"
fi


bash
if [ $# -eq 0 ]
  then
    echo "Nincs megadva paraméter"
    echo "igy használd: $0 paraméterek"
fi




if [ -z "$1" ]
  then
    echo "Nincs megadva paraméter"
    echo "igy használd: $0 paraméterek"
fi


Ha több feltételt szeretnénk vizsgálni, akkor arra is lehetőségünk van: && a logikai 'és', valamint a || logikai 'vagy'.

bash
num_a=5
num_b=6
string_a=szoveg2
string_b=szoveg23


## && ÉS - mindkét állításnak igaznak kell lennie
## || VAGY - elég, ha az egyik igaz


if [[ $num_a = $num_b || $string_a = $string_b ]]
 then
  echo "a feltétel igaz"
 else
  echo "hamis"
fi


## Ciklusok

### FOR

Ismétlődő (azonos vagy hasonló) tevékenységek megvalósítására szolgál.

bash
for i in 1 4 3
 do
  echo "$i"
 done


echo "---"


for j in `seq 1 10`
 do
  echo "$j"
 done


echo "---"


for k in {a..z}
 do
  echo "$k"
 done


echo "---"


for m in $(cat pelda.txt)
 do
  echo "$m"
 done
### WHILE

Addig fut le a kódblokk, amíg a feltétel igaz.

bash
counter=0
while [ $counter -lt 3 ]; do
    let counter+=1
    echo $counter
done
### UNTIL

Addig fut le a kódblokk, ha a feltétel nem igaz.

bash
counter=6
until [ $counter -lt 3 ]; do
 let counter-=1
 echo $counter
done


### CASE

Ha egy if-hez nagyon sok leágazást szeretnénk írni, jobb megfontolni a case használtatát

bash
echo -n "Adj meg egy országnevet: "
read STRING


echo -n "$STRING hivatalos nyelve: "


case $STRING in


  Magyarorszag)
    echo "Magyar"
    ;;


  Romania | Moldova)
    echo "Roman"
    ;;


  Spanyolorszag | Peru | Argentina)
    echo "Spanyol"
    ;;


  *)
    echo "nem tudom :)"
    ;;
esac




Feladatsor
Hozz létre egy mappát a HOME könyvtáradon belül: "linux-kedd" néven. Ezentúl csak ebben a linux-kedd mappában dolgozz.
# HOME könyvtárba lépés:
cd

# biztos ott vagyok-e?
pwd

# mappa létrehozása:
mkdir linux-kedd

cd linux-kedd
Hozz létre egy file-t, aminek a neve a userneved.
# Mi a user nevem?
whoami

# File létrehozás a parancs segítségével:
touch `whoami`
# vagy:
touch $(whoami)
Az előbb létrehozott file-ba irasd bele a /etc/ mappa tartalmát. Legyen minél beszédesebb a kiement.
# /etc/ mappa tartalmának listázása (minél beszédesebben):
ls -lah /etc/

# a parancs kimenetének file-ba írása:
ls -lah /etc/ > `whoami`
Hozz létre egy másik file-t, neve legyen az, hogy "konyvtaram.txt", tartalma pedig a könyvtár teljes elérhetőségi útvonala legyen (abszolút útvonal).
# file létrehozás:
touch konyvtaram.txt

# könyvtár elérhetőségi útvonala:
pwd

# pwd kimenet file-ba írása:
pwd > konyvtaram.txt
Hozd létre az alábbi könyvtár struktúrát:
- linux-kedd - Hofeherke - 7 mappát a 7 törpe nevével (ekezet nelkul)

# a mappastruktúra létrehozása:
mkdir Hofeherke

cd Hofeherke

mkdir Tudor
mkdir Vidor
mkdir Morgo
mkdir Szundi
mkdir Szende
mkdir Hapci
mkdir Kuka

# vagy amikor már nagyon jól megy:
mkdir -p Hofeherke/{Tudor,Vidor,Morgo,Szundi,Szende,Hapci,Kuka}
A 'tree' parancs kimenetét irasd ki a ~/struktura.txt nevű file-ba.
# tree parancs:
tree

# kimenet file-ba írása:
tree > ~/struktura.txt
Keresd meg azokat a sorokat a /etc/passwd-ból, amiben szerepel a "PM User" kifejezés. Ennek a kimenete kerüljön a pm.txt file-ba.
# keressünk a /etc/passwd -ban a "PM User"-re
grep "PM User" /etc/passwd
# vagy
cat /etc/passwd |grep "PM User"

# kimenet file-ba írása
cat /etc/passwd |grep "PM User" > pm.txt
Végül a /tmp/ mappába hozz létre egy file-t, amiben a 'history' command kimenete van. A file neve a usered neve legyen
# history command:
history

# kimenet fileba írása:
history > /tmp/`whoami`