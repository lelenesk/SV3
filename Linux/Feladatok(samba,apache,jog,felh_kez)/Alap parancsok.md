#mappakezelés

rm                                                                  törlés de rá fog kérdezni hogy biztos-biztos?
rm -rf                                                              ÓVATOSAN HASZMÁLNI! LÁSD LEJEBB...törlés rekurzívan (alatta lévő fájlokat is), és kérdés nélkül
rm -rf /                                                            (ha a per jel után SZÓKÖZ van) egész rendszert letörölheti!!!!

cd -a                                                               másolás (rekurzívan)
CD -av                                                              másolás beszédesen
                                                                    másolás közben átnevezéssel

mv /home/masolandofajl.txt /temp/idemasold                          áthelyezés

mv eredeti.txt ujnev.txt                                            átnevezés

stat valami.txt                                                     részletes infók (pl létrehozás dátuma, módostás dátuma stb)

cut                                                                 bemenet leszűrése
cut -f                                                              melyik fieldre (oszlopra) szűrjön
cut -d                                                              elválasztó karakter megadása (delimeter)
echo ab cd ef | cut f2 -d " "                                       PÉLDA, EREDMÉNYE "cd" lesz



echo                                                                kiírás a STANDARD kimenetre

echo -n                                                             nem ír új sor karaktert
echo -e                                                             engedélyezi az alábbi spec karakterek használatát:
                                                                    \a riadó(csengő-beep)
                                                                    \b 1 karakter törlése visszafele
                                                                    \c nem ír ki új sorokat a karkaterek után
                                                                    \f lapdobás
                                                                    \n új sor
                                                                    \r kocsi vissza
                                                                    \t vízszintes tabulátor
                                                                    \v függőleges tabulátor
                                                                    \\ backslash
                                                                    \nnn a karakter ASCII kódja nnn (oktálisan)
                                                                    \xnn a karakterkód megadása hexadecimálisan pl \x32
echo -e "üzenet a világnak \ntőlem"                                 PÉLDA( n miatt a tőlem már új sor )
echo -e "üzenet a \v\tvilágnak \v\ttőlem"                           próbáld ki :-)                                     

cd                                                                  jelenlegi felhasználó home könyvtárába ugrik
cd egymapppa/kétmappa/fájl                                          útvonal váltás, mappa léptetés
cd /usr/share/doc                                                   ABSZOLÚT elérési útvonal (mindig /-el kezdődik,root-tól indul)
pwd                                                                 melyik mappában vagyok jelenleg?
cd ../                                                              1 könyvtár szerkezetnyit felfele ugrik(per után mehet az elérési út)
cd -                                                                utolsó két könyvtár között ugrálunk (kényelmesebb munka)

tree                                                                mappaszerkezet vizuálisan
tree -pug                                                           mappaszerkezet csoportokkal,jogokkal,stb (ROOT KELL HOZZÁ: sudo -i)

ls                                                                  adott könyvtár tartalmának megjelenitése
ls -a                                                               rejtettek is
la -r                                                               fordított sorrendben írja ki
ls -lah                                                             lista formátum,human readable,rejtett is,formázott méret EZT HASZNÁLD
ls -lt                                                              méret szerint sorrendben
ls -ls                                                              utolsó módositás szerint sorrendben
ls ?????????                                                        minden x karkateres állományt jelenít csak meg (x=kérdőjelek száma)

file /dev/null                                                      megvizsgálja a fájl típusát(kiolvassa a fejlécéből)
file --mime /home/valami.txt                                        a fájl karakterkódolását mutatja meg
file -f /home/listafajl.txt                                         egy létező fájl lista állományban FELSOROLT fielokat mutatja meg

mkdir 
rmdir
touch
du
sort
wc
uniq
lspci
lsusb
lshw
tail
grep,egrep

regex
find

su,sudo











