# Történelem
## Unix, Unix-like, \*nix
A Unix egy eredetileg az AT&T és Bell Labs feljesztette operációs rendszer. 
A Unix-hoz hasonló (Unix-like, \*nix) operációs rendszerek a Unix felépítését és filozófiáját használják, de nem feltétlenül a Unix-ra épülnek.

## GNU
A GNU (jelentése: ***G**NU is **N**ot **U**nix*) egy Richard Stallman által indított, közösségileg fenntartott szoftvercsoport, a szabad szoftver mozgalom kiindulópontja. A GNU egy Unix-like szoftveregyüttest valósít meg teljesen eredeti kóddal, amit részben vagy egészben rengeteg szabad szoftver használ.

Ilyen komponensek például:
- **GCC** (GNU Compiler Collection)
- **glibc** a GNU C-nyelvű programkönyvtára
- **Coreutils** a klasszikus Unix parancsok (`ls`, `cp`, `mv`, stb.) megvalósítása
- A GNU **bash** shell
- A GNU **Emacs** szövegszerkesztő

## POSIX (Portable Operating Systems Interface)
Az IEEE 1003 szabvány, ami meghatároz egy egységes, gyártófüggetlen interfészt, kezelési paradigmát. Ez megvalósítható operációs rendszer szinten (pl. macOS 10.5 és későbbi, UnixWare, OpenServer) vagy szoftver által (pl. Windows számára a Cygwin, MinGW, WSL).

## FOSS  
#### Free Software, Open-Source, Libre, és Richard Stallman különös szókincse
> Free Speech, not Free Beer.

A FOSS jelentése *Free and Open-Source Software*. 

**Free Software:**
Ennek a jelentése **szabad szoftver**, NEM ingyen szoftver. Ezt Richard Stallman definiálta az 1986-os *Free Software Definition* publikációjában. A szabad szoftver négy alapvető szabadságot biztosít a felhasználó számára:

0. A program szabad használatát akármilyen célra;
1. A program szabad tanulmányozását, módosítását;
2. A program szabad továbbadását másoknak;
3. A program módosításainak továbbadását másoknak.

**Open-Source Software:**
A **nyílt forrású** szoftver biztosítja (jogilag és technikailag) a szoftver forráskódjához való szabad és teljes mértékű hozzáférést.

A nyílt forrású szoftver és a szabad szoftver között nagy az átfedés, de filozófiailag és jogilag elkülönülő fogalmak. FOSS az, ami a két csoport metszetébe tartozik.

**Libre:**
Francia és spanyol eredetű szó, az Európai Bizottság 2000-ben vette használatba. A libre elkerüli az angol "free" szó félrevezető értelmezését.

##### GNU/Linux, GNU+Linux
Richard Stallman ragaszkodik (jogosan) a GNU projekt egyenlő reprezentációjához, ezért bevezette a GNU/Linux (máshogy GNU+Linux) fogalmat a Linux rendszermagra és GNU szoftverkészletre alapuló operációs rendszerek leírására. Ez manapság félrevezető lehet, ugyanis szinte minden disztribúció használ a GNU-tól független, de ugyanolyan fontos szoftverkészleteket, mint például az X11, a Wayland, vagy a PulseAudio.

# Linux
A Linux önmagában nem egy operációs rendszer, csak a rendszermag, amit többek között a GNU projekt használ.

## Disztribúció (disztró)
Egy operációs rendszert alkotó szoftverek és erőforrások összessége.
Egy tipikus minimális Linux disztribúció tartalmazza a Linux rendszermagot, felhasználói eszközöket (pl. a GNU coreutils-t) és valamilyen csomagkezelő programot. Ezt a fenntartó szervezet általában lemezképfájlként, ritkább esetben forráskódként adja ki (pl. Gentoo).

## Asztali környezet, ablakozó, kompozitor, megjelenítő szerver
A Linux egyik jellemző tulajdonsága a modularitás. Minden feladatra ezer és egyféle megoldás létezik, beleértve a grafikus megjelenítést.

A grafika alapja a **megjelenítő szerver** (**display server**). Ez egy alacsonyszintű háttérfolyamat, ami a grafikus programokkal, programkönyvtárakkal kliens-szerver hierarchiában dolgozik együtt. Jelenleg két ilyen rendszer van:
- **X11** (teljes nevén X Window System), ami egy kommunikációs protokoll. Ezt az X.Org Server valósítja meg.
- **Wayland**, egy modern, szinte még kísérleti rendszer. Ez szintén egy kommunikációs protokoll, amit több független szoftver (ún. Wayland Compositorok) is megvalósít.

A megjelenítő szerver önmagában nem biztosít felhasználói felületet, ez az **ablakkezelő (ablakozó, window manager, WM)** feladata. Ez lehet:
- **Lebegő ablakkezelő** (floating vagy stacking window manager), ami a Windowshoz hasonló, szabadon mozgatható ablakokat jelenít meg. TODO: példák
- **Csempéző ablakkezelő** (tiling window manager), ami az ablakokat dinamikusan, előre meghatározott módon helyezi el. Ilyenek az Xmonad, i3, dwm, openbox, és amit én használok, az AwesomeWM.

Az **asztali környezet (desktop environment, DE)** egy szoftvercsomag, ami az ablakkezelő szerepén túl rengeteg feladatot ellát. Ilyen például a GNOME, a KDE Plasma, az XFCE, az LXDE és az LXQt, illetve a Windows grafikus környezete.

A **kompozitor (compositor)** egy grafikus eszköz, ami kezeli az egyes ablakok megjelenítését és az ablakok közötti interakciót, mint az áttetszőséget, lekerekített sarkokat, árnyék effektusokat, vagy lefedett felületek elmosását.
X11 környezetben ilyen program a picom, a compton, vagy KDE Plasma környezetben a KWin (ami egyben ablakozó is).
Wayland környezetben nincs különálló kompozitor, ezt a szerepet az ablakkezelő tölti be.

A legtöbb Linux disztribúció tartalmaz legalább egy teljesen felkonfigurált, használatra kész megjelenítő csomagot. Sok esetben ugyanaz a disztribúció több "ízesítéssel" is elérhető.

## Stable release
Magyarul pont-kiadás.

Hosszú kiadási ciklussal jelennek meg új verziók, a frissítések a teljes rendszerre hatással vannak. Az ilyen kiadásokat nagyon alaposan tesztelik, hiszen jelentős hibák utólagos kijavítására kevés lehetőség van, viszont ezzel együtt jár az, hogy az egyes szoftverek legfrissebb verziója nem mindig elérhető.

Ilyen az Ubuntu féléves normál és kétéves LTS kiadása, ahol a verzió száma a kiadás dátumát jelzi (pl. 22.04 megjelent 2022 áprilisában).

## Rolling release
Magyarul gördülő kiadás.

A frissítések folyamatosan, ütemezés nélkül jelennek meg. Egyetlen verzió létezik, ami mindig a legfrissebb kiadás. A frissítések általában csak az egyes csomagokat érintik. Magasabb a szoftverhibák esélye, viszont a kijavítás is gyorsabban történik.

Ilyen az Arch Linux és a legtöbb azon alapuló disztribúció.

## Programok, csomagkezelés
### Csomag
A csomag (package) a tartalom és a csomagleíró fájl összessége. A tartalom lehet akármi (gyakran szoftver fájlok, de akár háttérképek is). A csomagleíró fájl tartalmazza a csomag nevét, leírását, jogi információkat, és a függőségek listáját.

### Függőség, függőségi fa
Egy csomag hivatkozhat bármilyen másik csomagra függőségként. A csomag megfelelő működéséhez szükséges feltelepíteni az összes függőséget. Függőségként megjelölt csomagnak lehetnek saját függőségei, amiket rekurzívan mind fel kell telepíteni. Ezt a függőségi fát (dependency tree) a csomagkezelő szoftver (pl. pacman, apt) állapítja meg és telepíti fel minimális beavatkozással.

### Repository
Minden disztribúcióhoz tartozik egy megbízható repository, egy "tárház," ahonnan a csomagokat biztonságosan le lehet tölteni. Ehhez a csomagkezelő szolgáltat felhasználói felületet. Az üzemeltető általában a disztribúció fenntartója, de saját repository-kat is lehet használni. Arch-alapú disztribúciók számára elérhető az Arch User Repository (AUR), ahol független felhasználók oszthatnak meg csomagokat a fenntartó engedélye nélkül.

### Csomagkezelő
Feladata a csomagok lekérdezése, a függőségi fa felépítése, az egyes csomagok letöltése, feltelepítése, eltávolítása. Tipikusan parancssoros felületet biztosítanak. Grafikus felület általában külön segédszoftverként elérhető.

| Disztribúció | Csomagkezelő |
|--------------|--------------|
| Arch Linux | `pacman` (hivatalos), `yay` (AUR-hoz) |
| Debian, Ubuntu| `apt`, `dpkg` |
| Red Hat, Fedora | `rpm`, `yum`, `dnf` |

Egy rendszerre több csomagkezelőt is fel lehet telepíteni, de ilyenkor fennáll a veszélye, hogy azok összeakadnak és tönkreteszik a rendszert.

### Disztribúció-agnosztikus csomagok: AppImage, Flatpak, Snap
A klasszikus csomag alapú szoftverkiadások egy hatalmas hátránya, hogy külön kell megépíteni a csomagot minden disztribúcióhoz, minden architektúrához, néha minden rendszermaghoz. Ezt és más dolgokat orvoslandó, létrejöttek az univerzális csomagformátumok.

Ezek nagyban hasonlítanak az Android és iOS alkalmazásaira. Részben vagy teljesen monolitikusak (a függőségek a csomag részét képezik), sandboxing és alkalmazásonkénti engedélykezelés útján növelik a biztonságot, és a felhasználó számára egyszerűsített parancssoros vagy grafikus felületet biztosítanak.

#### Snap
A Snap csomagkezelő és a Snap Store a Canonical vállalat által, kifejezetten a saját Ubuntu disztribúciójukhoz lett kifejlesztve. Kizárólag `systemd`-t használó rendszereken működik. Ez és a zárt forrású webáruház backend heves kriticizmust vonzott.

#### Flatpak
Bármilyen Linux rendszeren (beleértve a WSL-t) elérhető, a Flatpak-csomagok legnépszerűbb forrása a flathub.org.

#### AppImage
Az alkalmazásokat egyetlen, teljesen monolitikus, tömörített AppImage fájlként kezeli, amiket futtatáskor ideiglenes fájlrendszerként csatol fel. **Nem biztosít sandboxot.**

## Folyamatok
### Folyamat
Valami, amit a gép csinál, gépi utasítások sorozata egy azonosító alatt.

#### Hierarchia: szülő, gyerek, árva, zombi
Egy folyamat indíthat különálló folyamatokat. Az új folyamatok lesznek a **gyerekek**, az azokat indító folyamat pedig a **szülő**.
Ha egy folyamat befejeződik amíg a gyerek még fut, az **árván** fog maradni. Az árva folyamatokat az `init` fogja örökbe fogadni.
A **zombi** egy olyan folyamat, ami már befejeződött, de még memóriában van. Erre szükség lehet például a kilépési kód kiolvasásához.

#### Gyökérfolyamatok
A folyamatoknak klasszikusan egy gyökere van: az **init**. A kernel ezt a folyamatot indítja el legelőször 1-es azonosítóval, ez minden más folyamat őse, neki nincs szülője.

Újabb rendszereken lehet egy második gyökérfolyamat, a **kthreadd** (kernel thread daemon), a rendszermag használja... valamire.

#### Folyamat azonosító (PID, process ID)
Egy szám, ami a folyamatot egyedileg azonosítja. Minden folyamatnak pontosan egy PID-je van, amit a rendszer a folyamat indulásakor dinamikusan rendel hozzá. Az 1-es PID mindig az `init` folyamatot jelöli.

#### Szülőazonosító (PPID, parent PID)
Egy folyamat szülőfolyamatának PID-je. Az `init` és a `kthreadd` kivételével minden folyamatnak pontosan egy szülője van.

#### Daemon, agent
A daemon egy háttérfolyamat, ami más folyamatoknak nyújt szolgáltatásokat. Ezeknek a neve általában `d`-re végződik. Ilyen például a `httpd` (HTTP daemon, webszerver), `polkitd` (Policy Kit daemon, jogosultságkezelő), vagy a `systemd-journald` (a `systemd` naplózó folyamata).

Az agent egy daemonhoz hasonló háttérfolyamat, de a felhasználói programok számára nyújt szolgáltatásokat. Ilyen például az `ssh-agent` (privát kulcsokat biztonságos memóriában tartja) vagy a `polkit-kde-authentication-agent-1` (figyeli, hogy milyen folyamatoknak kell a `polkitd`-től jogosultságokat igényelni).

# Parancssoros felületek
A Unix-like rendszerek elsődleges felülete a parancssor.

## Terminál
A terminál egy szöveges bemenet és egy szöveges kimenet. TTY-nak is hívják (**T**ele**ty**pe). Terminálhoz hasonló felületeket általában \*TY formában neveznek el, mint PTY (pszeudoterminál két folyamat között) vagy VTY (virtuális terminál).

A legtöbb Linux-alapú rendszer egy vagy több (gyakran nyolc) TTY munkamenetet biztosít. Ezek között a Ctrl+Shift+(F1-F8) gombokkal lehet váltani. Ha van grafikus felület, az az egyik TTY-t le fogja váltani.

## Terminál emulátor
Olyan felhasználói szoftver, ami terminálszerű interakciót tesz lehetővé TTY eszköz használata nélkül. Ilyen:
- Windows: a parancssor, ami cmd.exe vagy PowerShell.exe hatására nyílik meg, PowerShell ISE, Windows Terminal.
- Linux: `xterm`, `konsole` (KDE default), `gnome-terminal` (GNOME default), `kitty`, `alacritty`, `st`

Szokás alapján a terminál emulátort is egyszerűen terminálnak hívják.

## Shell
Parancssoros kontextusban a shell egy parancsértelmező program, ami a terminálban fut, értelmezi a bemenetre érkező szöveget, elvégzi a megfelelő műveleteket, és az eredményt kiírja a kimenetre.

A shell általában három felületen kommunikál a terminállal:
- Standard bemenet (`stdin`): bemenet a felhasználótól, pipe-ról (`|`), vagy a beolvasás (`<`) operátortól.
- Standard kimenet (`stdout`): kiírás a terminálra, átadás a pipe-nak, vagy fájlba írás (`>` újraírja, `>>` hozzáfűzi).
- Standard hibakimenet (`stderr`): kiírás a terminálra, függetlenül a standard kimenet átirányításától.

Népszerű shell-ek:
| név | parancs |
|---|---|
| Bourne Shell | `sh` |
| Bourne Again Shell, Bash | `bash` |
| Z-shell | `zsh` |
|PowerShell 7|`pwsh`|
|Friendly Interactive Shell, Fish|`fish`|

A shell lehet **interaktív**, mint amikor terminálon futva a felhasználótól vár bemenetet, vagy **neminteraktív**, amikor egy programot, scriptet, vagy utasítást futtat.
