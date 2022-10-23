sudo apt install at #nem része a linuxnak 
yum install at.x86_64
kilépés: (ctrl+D)

at-f /home/valami/sajatscript1.sh now + 1 minutes                #időzített futtatás, lehet még years,weeks,days,hours, MINDIG abszolut elérési útat adjunk meg
at 4pm tomorrow
at 10am Jul 31
at 2:30 PM 10/21/2023
at 2:30 PM 21.10.14.

#---------------------------------------------------------------------------------------------------------

/var/spool/cron                                                  #itt találhatóak az időzített feladatok
/etc/crontab                                                     #globális fájl
crontab -e                                                       #saját időztitett feladatok beállítása
crontab -u tomifelhasznalo -e
crontab -r

@reboot                                                           #újrainditás után fusson le
@yearly                                                           #évente egyszer fusson le "0 0 1 1 *"
@annually                                                         #évente egyszer fusson le "0 0 1 1 *"
@monthly                                                          #havonta egyszer fusson le "0 0 1 * *"                
@weekly                                                           #hetente egyszer fusson le "0 0 * * 0"
@daily                                                            #naponta egyszer fusson le "0 0 * * *"
@hourly                                                           #óránként egyszer fusson le "0 * * * *"

#Linux időzítés
Cron, crontab, at parancs alapok

#Időzítés linuxban
At parancs
#Egy alapértelmezésben nem telepített időzítő program, ami egyszeri időzítést tesz lehetővé. Tehát megmondhatjuk vele, hogy mikor fusson le az adott program vagy script.

#szintaktika

at opciók programnév mikor

#példa:

at -f /../sajatscript.sh now +1 weeks Lefuttatja a saját scriptünket egy hét múlva

#A program használatakor érdemes a futtatandő parancs teljes elérési útját megadni. Az atq parancsal tudjuk megnézni a sorban álló feladatokat.

#cron

A cron már ciklikus időzítést is lehetővé tesz. Tehát megadhatjuk, hogy egy program mondjuk logelemzés minden héten éjfélkor fusson le. A cron lehetővé teszi a felhasználók számára is, hogy saját időzített feladatokat állítsanak be ezt a crontab parancsal tehetik meg és a beállított konfigurációt a /var/spool/cron mappában tárolja a felhasználó neve alatt.

A cron globális fájlja a /etc/crontab. Ha ezt használjuk, akkor meg kell adni, hogy kinek a nevében fusson le az adot feladat.

A cronnak vannak előre definiált idő könyvtárai (cron.daily, cron.hourly...), amikbe ha futtatható fájlt helyezünk, akkor a névnek megfelelő időszakonként lefut script a behelyezéstől számítva.

#ÓRA........................



sudo apt install at

at -f /home/linuxadmin/scriptek/lustasag.sh now +1 minutes

#milyen időzítések vannak
atq 

#hol tárolja
cd /var/spool/cron


#szerkesztője
crontab -e

#hogy jutottunk be video

#(/etc/)vannak fix mapapi pl cron.daily ahova ha bemasolom automatikusan fogj futtatni mappanévnek meglfelően







