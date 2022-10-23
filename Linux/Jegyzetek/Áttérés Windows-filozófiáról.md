## Lassíts!
Linuxra átállni olyan lesz, mint először kézi váltós autót vezetni sokéves automatás gyakorlattal. A berögzült szokások, reflexek, elvárások itt sok esetben gátolni fognak a haladásban. Lassíts le, gondolkozz azon, hogy éppen mit akarsz elérni - tedd fel a kérdést, hogy biztos tudod-e, hogy mit csinálsz, vagy csak a Windowsos rutin hajt.

## Terminál minden felett
A Linux és a Unix más filozófiával jött létre mint a Windows. Itt a parancssor az első és legfontosabb kezelőfelület, minden más arra épít. Fontos tehát, hogy a felhasználó ne csak értse a terminált, hanem legyen vele kényelmes.
Egy ideális rendszerben egy feladatot ugyanolyan jól meg lehetne oldani grafikus és terminál felületen. Ez néha megvalósul, de gyakrabban nem. Van, hogy valami egyáltalán nem is lehetséges grafikus felületen. Van, hogy grafikus felületet túl macerás használni. Csomagkezelőknek lehetnek például grafikus front-end segédszoftvereik, de ha bármi többet akarunk csinálni mint egyszerű telepítés és törlés, csak a parancssor fog erre lehetőséget adni.

## Más biztonsági modell
A Linux egy erős biztonsági modellt alkalmaz. Még a helyi rendszergazdai fiókoknak is meg van tiltva a rendszer módosítása. Ilyet kizárólag a **root** szuperfelhasználó tehet, a műveletek elvégzését felé kell delegálni terminálon a `sudo`, `su`, vagy `doas` parancsok által, grafikus felületen pedig a PolicyKit felugró ablakán. Ilyenkor a felhasználónak azonosítania kell magát, bizonyítva, hogy neki igenis van engedélye a root jogokhoz.
Nem tudok róla, hogy ezt ki lehetne kapcsolni, de ez egy olyan masszív sebezhetőséghez vezetne, hogy nem is akarok.

## Fájltípusok vannak - kiterjesztések nincsenek.
A Windowsban mai napig használt kiterjesztések a korai DOS-ban a 6.3 nevezési sémával jöttek létre - hat karakteres fájlnév, plusz három karakteres fájltípus azonosító. Linuxon ez háttérbe szorul - a fájltípusokat elsősorban az attribútumok (metaadatok) és a fájl tartalma alapján állapítja meg a rendszer. Ami JPEG kép `.jpg` kiterjesztéssel, az JPEG kép lesz kiterjesztés nélkül is.
Ez különösen fontos amikor futtatható vagy konfigurációs fájlokról beszélünk. Futtatható bináris fájloknak (EXE ekvivalens) nem szoktunk kiterjesztést adni. Bash/sh/zsh scripteknek jelzés értékkel `.sh` kiterjesztést szoktunk adni, de a végrehajtásról az első, `#!` párossal kezdődő sor dönt.
Sok konfigurációs fájlnak (pl. `fstab`, `authorized_keys`, `sudoers`) nincs kiterjesztése, pedig ugyanolyan szövegek mint a `.conf` kiterjesztésű fájlok.

## RTFM - a dokumentáció
Read The ~~Fucking~~ Fine Manual
https://wiki.archlinux.org/title/Man_page

Szinte minden csomag mellé feltelepül a hozzá tartozó dokumentáció. Ezt a `man` programmal lehet elérni. Itt megtalálható a program leírása, a hozzá tartozó összes beállítás, konfigurációs fájlok, és hivatkozások más dokumentumokra. Ha valamit nem tudsz egy paranccsal kapcsolatban, ez legyen az első célpontod.
Létezik egy hasonló program, a `tldr` (telepítsd APT-vel, utána `tldr -u` letölti az adatbázisát). Ez egyetlen oldalon összefoglalja a programot és néhány példát is ad.
A másik hasznos forrás természetesen az internet. Minden nagyobb disztribúciónak van valamilyen tudásbázisa - az Arch Linuxnak kiemelkedő méretű és részletességű wikije van: https://wiki.archlinux.org/ Bár az Ubuntu Debian alapú, az itt leírtak jó része ugyanúgy alkalmazható (POSIX-nak hála).

## Open-Source - a közösség
A Linux, a GNU, és az azokból eredő projektek a kölcsönös segítség miatt lettek ennyire bevált és szeretett rendszerek. Kérdezz másoktól Redditen, Stackoverflow-n, fórumokon - ha nem is a megoldást, de nyomravezető információt biztos tudnak adni.
Mindenki figyelmébe ajánlom ezeket a Youtube csatornákat:
#### [DistroTube](https://www.youtube.com/c/DistroTube)
- Linux kezdő és haladó témák, útmutatók
- Libre/FOSS témák
#### [The Linux Experiment](https://www.youtube.com/c/TheLinuxExperiment)
- Linux és open-source hírek, vélemények
#### [Mental Outlaw (Kenny)](https://www.youtube.com/c/MentalOutlaw)
- Technológiai és IT biztonság hírek, vélemények, útmutatók
- Régebbi videók között Linux útmutatók
- \#based AF
#### [Network Chuck](https://www.youtube.com/c/NetworkChuck)
- Hálózatismeretek mellett Linux alapok