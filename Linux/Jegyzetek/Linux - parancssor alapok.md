## Útvonalak
### Gyökérkönyvtár
A Windowstól eltérően a Linux fájlrendszernek egyetlen gyökere van, ami nagyjából megfelel a `C:\` útvonalnak. Minden ezen belül van, még a felcsatolt meghajtók (`D:\`, `E:\`, stb.) is. A gyökér útvonala egyetlen `/` karakter.

### Útvonalak összefűzése
Útvonalak mappáit összefűzni a `/` karakterrel lehet. Például az `/etc/ssh/sshd_config` az `etc` mappában, azon belül az `ssh` mappában, azon belül az `sshd_config` fájlra fog mutatni. A `\` (backslash) karaktert itt nem lehet használni, annak más szerepe lesz.

### Abszolút és relatív útvonalak
Az abszolút útvonal mindig `/` karakterrel kezdődik, a gyökértől kezdve kell megadni.

A relatív útvonal bármi mással kezdődhet, a jelen mappához relatívan értelmezzük jellemzően `.` (ez a mappa), `..` (szülő mappa), vagy egy mappa/fájl nevével kezdődik.

### Speciális mappák
Ezek olyan szimbólumok, amik más mappákra fognak mutatni.
|szimbólum|jelentés|
|---|---|
|`~`|Tilde, a bejelentkezett felhasználó home mappája. Ha én `chump` néven jelentkezek be, akkor a `~` a `/home/chump` mappára fog mutatni.
|`.`|Egy darab pont, ezt minden mappa tartalmazza, és önmagára mutat. Tehát: `/etc/.` = `/etc/././.` = `/etc`. Ezt jellemzően akkor szokták használni, ha egy relatív útvonalat explicit meg kell jelölni (pl. `./Documents`), vagy ha egy útvonalnak a jelen mappát kell megadni.
|`..`|Két darab pont, ez mindig a szülőmappára mutat, pl. `/home/chump/..` = `/home`, `/home/chump/../..` = `/`.

Ezeket a shell a parancsok futtatásakor be fogja helyettesíteni a megfelelő értékekkel. Ez alapján a `~`-vel kezdődő útvonalak abszolút útvonalakká terjednek ki (`~/.ssh` -> `/home/chump/.ssh`).

### Szóközök
A szóközök alapesetben az argumentumokat választják el egymástól. Ha egy útvonalban szóköz van és az nincs helyesen lekezelve, akkor az útvonal ott "kettészakad," két külön argumentumként lesz értelmezve.

Ezt elkerülendő vagy minden egyes szóköz elé `\` backslash-t, ún. escape karaktert kell írni:
`/run/media/gmotko/External\ HDD/Downloads/Lord\ of\ the\ Rings\ Trilogy\ BluRay\ Extended\ 1080p\ QEBS5\ AAC51\ PS3\ MP4-FASM/`

...vagy az egészet idézőjelekkel kell körbevenni:
`"/run/media/gmotko/External HDD/Downloads/Lord of the Rings Trilogy BluRay Extended 1080p QEBS5 AAC51 PS3 MP4-FASM/"`

## Billentyűparancsok
https://www.youtube.com/watch?v=XY5qCQcrHns
A bash alapértelmezés szerint Emacs-szerű billentyűparancsokat használ. Aki Vim mesternek vallja magát, a `set -o vi` paranccsal válthat át.
|parancs|hatás|
|---|---|
|Ctrl + C|Megszakítja (interrupt) és lezárja az aktív folyamatot.
|Ctrl + Z|Felfüggeszti (suspend) az aktív folyamatot úgy, hogy folytatni lehessen.
|Ctrl + D|"Fájl vége" jelet küld a standard bemenetre. Ez általában lezárja az interaktív shell-t (kilép) és bemeneteket.
|Ctrl + L|Kiüríti a terminál kimenetét.
|Ctrl + B|Egy karakterrel balra lép.
|Ctrl + F|Egy karakterrel jobbra lép.
|Alt + B|Az előző szó elejére ugrik.
|Alt + F|A következő szó elejére ugrik.
|Ctrl + A|A begépelt szöveg elejére ugrik.
|Ctrl + E|A begépelt szöveg végére ugrik.
|Ctrl + K|Törli a begépelt szöveget a kurzortól a sor végéig.

## Alapvető utasítások
| parancs | leírás | CMD ekvivalens | Powershell ekvivalens |
|---------|--------|----------------|-----------------------|
|`man <parancs>`|Megnyitja a `<parancs>`-hoz tartozó útmutató dokumentumot.||
|`sudo <parancs>`|A `<parancs>`-ot root/superuser/rendszergazdai jogokkal hajtja végre. CSAK ÓVATOSAN!
|`pwd`|Kiírja a jelen mappa (working directory) abszolút útvonalát.
|`ls`|Listázza a jelen mappa tartalmát.|`dir`|`Get-ChildItem`|
|`ls <path>`|Listázza a `<path>` mappa tartalmát.|`dir <path>`|`Get-ChildItem -Path <path>`|
|`cd <path>`|Belép a `<path>` mappába.|`cd <path>`|`Set-Location <path>`|
|`cd ..`|Visszalép a szülő mappába.|`cd..`, `cd ..`|
|`cp <from> <to>`|A `<from>` fájlt átmásolja `<to>` helyre.|`copy`, `xcopy`|`Copy-Item`
|`mv <from> <to>`|Áthelyezés *és átnevezés*.|`move`, `rename`|`Move-Item`, `Rename-Item`
|`rm <file>`|Törli a megjelölt fájlokat.|
|`rm -r <dir>`|Törli a megjelölt mappát és a tartalmát.|
|`touch <file>`|Létrehoz egy teljesen üres fájlt.||`New-Item -Type File -Path <file>`
|`mkdir [-p] <dir>`|Létrehoz egy új mappát. Ha `-p` be van állítva, rekurzívan hoz létre egy mappaszerkezetet.|`md <dir>`|`New-Item -Type Directory [-Force] -Path <dir>`

Folyamatkezelés:
| parancs | leírás |
|---------|--------|
|`ps`|Listázza a folyamatokat.
|`pgrep <minta>`|Listázza a folyamatokat és megszűri a `<minta>` alapján.
|`kill <PID>`|Befejezi a `<PID>` azonosítójú folyamatot (SIGTERM).
|`kill -<SIGNAL> <PID>`|A megjelölt folyamatnak a `<SIGNAL>` szerint megadott jelet küld.
|`kill -L`|Listázza a `kill` lehetséges jeleit.
|`kill -9 <PID>`|Azonnal megöli a megjelölt folyamatot (9 = SIGKILL).
|`pkill [-9] <minta>`|Befejezi (-9 megöli) a megnevezett folyamatot.
|`jobs`|Listázza a felfüggesztett és háttérben futó folyamatokat.
|`bg [%N]`|Az `N` számú, vagy anélkül a legutóbb felfüggesztett folyamatot a háttérben folytatja.
|`fg [%N]`|A legutóbb felfüggesztett, vagy `N` számú folyamatot az előtérben folytatja.

Szövegkezelés:
| parancs | leírás | CMD ekvivalens | Powershell ekvivalens |
|---------|--------|----------------|-----------------------|
|`echo`|Kiírás standard kimenetre.|`echo`|`Write-Host`, `Write-Output`
|`cat <file>`|`<file>` kiírása kimenetre soronként.
|`less <file>`|`<file>` megnyitása olvasásra a Less programmal.
|`nano <file>`|`<file>` szerkesztése Nano szövegszerkesztővel.

Jogosultságkezelés:
| parancs | leírás | CMD ekvivalens | Powershell ekvivalens |
|---------|--------|----------------|-----------------------|
|`chmod [-R] [jogosultságok] <fájl>`|Beállítja a fájlra vonatkozó Unix jogosultságokat. Bővebben: `man chmod`.||
|`chown [-R] [user][:[group]] <file>`|Módosítja a fájl tulajdonos felhasználóját és/vagy csoportját. Bővebben: `man chown`||

## Pipe-ot használó utasítások
Ezek a parancsok tipikusan a pipe-ról érkező bemeneteket dolgozzák fel. Például a `cat /etc/fstab | grep PARTUUID` esetében a `grep` a `cat` kimenetét dolgozza fel.
|parancs|leírás|Powershell ekvivalens|
|---|---|---|
|`grep <minta>`|A bemenet soraiból kiszűri azokat, amik a `<mintá>`t tartalmazzák. A minta lehet szöveg vagy Regex kifejezés.|`Select-String`
|`less`|A bemenetre érkező teljes szöveget olvasható, görgethető formában jeleníti meg.
|`cut -d, -f1,2`|A bemenet sorait felvágja a `-d`-nek megadott karaktereknél, és az így létrejött mezőkből az `-f` által megadott számúakat írja a kimenetre.
|`sed`|A bemenetre érkező sorokat szerkeszti, bővebben: `man sed`.
|`count`|Megszámolja a bemenetre érkező sorokat.|`Measure-Object -Count`

## Környezeti változók, helyi változók
A Windowshoz hasonlóan itt is jelen lesznek a környezeti változók. Az `env` parancs listázza őket. Változóra hivatkozni a `$` jellel lehet (pl. `$TERM`).

Kiírni az `echo` paranccsal lehet:
```
[gmotko@Overlord ~]$ echo $SHELL
/bin/zsh
[gmotko@Overlord ~]$ echo $TERM
xterm-kitty
[gmotko@Overlord ~]$ echo $DESKTOP_SESSION
plasma
[gmotko@Overlord ~]$ echo $USER
gmotko
```

`echo` parancs nélkül a shell megpróbálná parancsként futtatni a változó értékét:
```
[gmotko@Overlord ~]$ $TERM
bash: xterm-kitty: command not found
[gmotko@Overlord ~]$ echo $TERM
xterm-kitty
```