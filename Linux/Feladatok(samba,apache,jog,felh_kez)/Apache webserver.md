#Apache (apache http server)
#Nyílt forráskódú webkiszolgáló alkalmazás népszerűségét jellemzi, hogy 2022-ben a a weboldalak 31,2 százaléka használta. Támogatja a http, https és ftp protokolt is. Gyakran mysql adatbázismotorral használják. A népszerű parancsnyelvek PHP, Python Perl stb szintén használhatóak vele. Az apache moduláris felépítésű és igény szerint bővíthető.

#Telepítés
sudo apt install apache2

#verzió ellenőrzése:
apache2 -version

#tűzfal beállítása:
#A tűzfalon beállítható szoftverek listája:

sudo ufw app list
#A listában a következő Apache profilokat fogjuk találni: Apache: Ez a profil csak a 80-as porton enged kommunikálni titkosítatlanul Apache Full: Ez a verzió támogatja mind a titkosított (443-as port) mind a tikosítatlan (80-as port) kommunikációt. Apache Secure: Ez a profil csak a titkosított forgalmat engedélyezi.

#Apache engedélyezése a tűzfalon:

sudo ufw allow 'Apache'
#Az apache szolgátatást a következő parancsal tudjuk ellenőrizni:
# - secureall is lehet, akkor a 80ast nem nyitja meg
sudo systemctl status apache2
#Az ellenőrzésre egy másik lehetőség, hogy egy böngészőből megnyitnyjuk az apache üdvözlő képernyőjét A böngészőbe a következőt kell írni http://szerver ip címe

#Ezzel az alap telepítés kész is van.

#Apache szerver menedzselése
#indítás:
sudo systemctl start apache2

#leállítás
sudo systemctl stop apache2

#konfiguráció frissítése: Ha a szerverünk konfigurációján módosítunk akkor ahhoz le kell állítanunk és újraindítani
sudo systemctl stop apache2
sudo systemctl reload apache2

#bootoláskori apache szerver indítás engedélyezése
sudo systemctl enable apache2

#bootoláskori apache szerver indítás tiltása
sudo systemctl disable apache2

#Konfigurációs fájlok
Az apache szerverünk konfigurációját a /etc/apache2 könyvtárban a apache2.conf fájl tartalmazza. Itt az egész szervert érintő beállításokat tudunk csinálni. Ugyanakkor mivel egy webszerveren jellemzően nem csak egy weboldalt szolgálunk ki hanem többet is ezért létre lehet hozni minden egyes weboldalnak saját konfigurációs fájlt. Ezeket a konfig fájlokat alapértelmezésben a /etc/apache2/sites-available találjuk.

#hasznos link: https://www.youtube.com/watch?v=x5fWSWdM4F8