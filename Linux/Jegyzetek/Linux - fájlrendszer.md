# Linux - fájlrendszer
## Alapvető könyvtárszerkezet

| Útvonal    | Szerep    | Windows ekvivalens    |
|------------|-----------|-----------------------|
| `/` | A fájlrendszer abszolút és egyetlen gyökere, tartalmazza az összes mappát, fájlt, eszközt. | `C:\` |
| `/bin` | A rendszer működéséhez szükséges futtatható állományok. | `C:\Windows\System32` |
| `/boot` | A bootloader és boot manager fájljait tartalmazza. Itt található a Linux kernel (`vmlinuz`) és az `initramfs`. | |
| `/dev` | Az eszközökre hivatkozó fájlok, mint a háttértárak (pl. `/dev/sda`), partíciók (pl. `/dev/sda1`), terminálok, véletlenszám-generátorok, stb. | |
| `/etc` | Rendszerszintű konfigurációs fájlok, amik az összes felhasználót érintik. | `C:\ProgramData` |
| `/home` | Felhasználók saját mappái. | `C:\Users` |
| `/mnt` | Ideiglenesen felcsatolt fájlrendszerek csatolási pontjait (mount point) tartalmazza. | |
| `/opt` | Egyes felhasználói szoftverek ide települnek. | `C:\Program Files` |
| `/proc` | Virtuális fájlrendszer, a futó folyamatok adatait tartalmazza. | |
| `/root` | A `root` felhasználó saját home mappája. | |
| `/run` | A rendszer működéséhez szükséges ideiglenes fájlok, eszközök. | `%TEMP%` |
| `/sbin` | "System binaries", rendszerszintű futtatható állományok kifejezetten a superuser számára. | `C:\Windows\System32` |
| `/srv` | Szerver szerepkörök nyilvánosan elérhető tartalma (pl. weboldalak). | |
| `/sys` | Virtuális fájlrendszer a hardver- és rendszerinformációk elérésére. | |
| `/tmp` | Ideiglenes fájlrendszer. Disztribúciótól függően vagy egyenértékű a `/run` könyvtárral, vagy a RAM tartalmát teszi elérhetővé `tmpfs` virtuális fájlrendszerként. Reboot esetén törlődik. | |
| `/usr` | Rendszerszintű, de a rendszer működéséhez nem szükséges felhasználói programok és fájlok. | |
| `/usr/bin` | Felhasználói programok futtatható állományai. | `C:\Program Files` EXE fájljai |
| `/usr/include` | C nyelvű header állományok. | |
| `/usr/lib`  `/usr/lib32` | Programok számára megosztott, önmagukban nem használható könyvtárállományok. | DLL fájlok |
| `/usr/share` | Programok nem futtatható erőforrás fájljai, dokumentumai. | `C:\Program Files` egyéb fájljai |
| `/usr/src` | Programok forráskódjai. | |
| `/var` | Folyamatosan váltzó fájlok. | |
| `/var/cache` | Rendszerszintű gyorsítótárazott fájlok. | |
| `/var/log` | Naplófájlok. | Event Viewer |
| `/var/mail` | Beérkező levelek (mail kliens számára). | |
| `/var/spool` | Sorban várakozó vagy ütemezett feladatok, nyomtatandó dokumentumok, kimenő levelek. | |
| `/var/tmp` | Ideiglenes fájlok. A `/tmp` mappával ellentétben nem törlődnek rendszerindításkor. | |

### Kapcsolódó fogalmak
#### Blokk eszköz (block device)
Olyan eszköz, ami az adatokat bináris blokkokként kezeli. Ilyenek például a háttértárak.

#### Karakter eszköz (character device)
Olyan eszköz, ami a ki- és bemeneti adatokat karakterekként vagy szövegként kezeli, például a TTY-k (terminálok).

#### Virtuális fájlrendszer
Olyan fájlrendszer, ami nem fájlrendszerként tárolt adatokat fájlrendszeri formában teszi elérhetővé. Ilyenek:
- `/tmp` könyvtár a `tmpfs` (Temporary Filesystem) driveren
- `/proc` könyvtár a `procfs` (Proc Filesystem) driveren

## Meghajtók felcsatolása
Linuxon nincsenek betűjeles meghajtók és nincs "Sajátgép". Minden egyetlen gyökérkönyvtárban létezik, más meghajtók elérését ezen belül kell megoldani blokkeszköz-fájlok és csatolási pontok segítségével.

A csatolási pont (mount point) mindig egy üres mappa. Nem üres mappára nem lehet fájlrendszert csatolni.
A blokkeszközök a `/dev` mappában vannak, listázni őket az `lsblk` parancs segítségével lehet:
```
[gmotko@Overlord ~]$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0 223,6G  0 disk 
├─sda1   8:1    0   511M  0 part /boot/efi
├─sda2   8:2    0    16G  0 part [SWAP]
└─sda3   8:3    0   180G  0 part /
sdb      8:16   0   2,7T  0 disk 
└─sdb1   8:17   0     1T  0 part /home
sdc      8:32   0 931,5G  0 disk 
├─sdc1   8:33   0   200G  0 part /run/media/gmotko/Windows partition
└─sdc2   8:34   0 731,5G  0 part /mnt/games
sdd      8:48   0 465,8G  0 disk 
└─sdd1   8:49   0 465,8G  0 part /run/media/gmotko/External HDD
```
Itt az `sda`, `sdb`... eszközök a teljes fizikai eszközökre mutatnak, azokon belül a partíciók számozva vannak.

Fájlrendszerek felcsatolására három módszer van:

#### Manuálisan a `mount` paranccsal
*Bővebben: `man mount`, `man umount`*
```bash
mount [-t típus] /dev/<eszköz> <csatolási pont>
umount [-t típus] <eszköz|csatolási pont>
```

A `mount` parancs ideiglenesen felcsatol egy eszközt a megadott pontra. A fájlrendszer típusát (ntfs, ext4, fat, stb.) lehet, de nem kötelező megadni. Csatoláskor először meg kell adni a blokkeszközre mutató fájlt, majd a csatolási pontot.
Ez addig lesz elérhető, amíg a rendszer újra nem indul, vagy a felhasználó le nem választja az `umount` paranccsal. Leválasztani vagy az eszköz vagy a csatolási pont útvonalával lehet.

A `/mnt` mappába felcsatolni csak root jogokkal lehet.

#### Indításkor statikusan az `fstab` fájllal
*Root jogok szükségesek!*
*Bővebben: `man fstab`, https://en.wikipedia.org/wiki/Fstab

Helye: `/etc/fstab`

```
[gmotko@Overlord ~]$ cat /etc/fstab
# /etc/fstab: static file system information.
# <file system>             <mount point>  <type>  <options>  <dump>  <pass>

# System partitions
UUID=3578-D01B                                     /boot/efi      vfat    umask=0077 0 2
UUID=245bc7c3-9239-4b06-b8da-2b5d8ba8ca2f          /              ext4    defaults,noatime 0 1
tmpfs                                              /tmp           tmpfs   defaults,noatime,mode=1777 0 0

# Swap partition
PARTUUID=f6feb77d-34bd-4367-823c-0946396993da      none           swap    defaults 0 0

# /home
PARTUUID=e402a6d8-989e-4849-8e04-f28621f4682c      /home          ext4    defaults 1 2

# Linux Games - SSD second volume - ext4
PARTUUID=3b9053c2-aae5-4a7a-999d-cd949f262111      /mnt/games     ext4    defaults 0 0
```

Az `fstab` (file system table) egy szöveges fájl, egy táblázat, ami leírja, hogy a rendszer indításakor milyen eszközöket, hova, hogyan kell felcsatolni. Minden sora egy, szóközökkel tagolt bejegyzés (kivéve az üres és `#`-tel kezdődő sorok). Minden bejegyzésnek hat mezője van.
- Az első mező azonosítja az eszközt. Erről bővebben később.
- A második mező meghatározza a csatolási pontot.
- A harmadik mező a felcsatolni kívánt fájlrendszer típusa.
- A negyedik mező a beállításokat listázza, vesszővel elválasztva, *szóközök nélkül*. A `defaults` érték a legtöbb esetben elég; bővebben: `man fstab`.
- Az ötödik mező a `dump` biztonsági mentéshez szükséges: 1 bekapcsolja, 0 kikapcsolja.
- A hatodik mező meghatározza az `fsck` (file system check) sorrendjét: 1 először, 2 utána, 0 kikapcsolja az `fsck`-t.

##### Eszköz azonosítása
- Eszközfájl szerint, pl. `/dev/sda1`. Ez nem megbízható, az összerendelések változhatnak például SATA kábelek átrendezésével.
- UUID szerint. Ez egyedileg azonosítja a *fájlrendszert*. A `blkid /dev/<eszköz>` paranccsal lehet kiíratni.
- PARTUUID szerint. Ez egy GPT lemezen egyedileg azonosítja a *partíciót*.
- LABEL szerint. Csak akkor ajánlott, ha az eszköz neve egyedi és sosem változik.

A UUID és a PARTUUID között az a különbség, hogy ha egy fájlrendszert bitről bitre klónozok, a UUID-k egyezni fognak, a PARTUUID-k nem; ha pedig formázok egy partíciót, akkor a UUID új lesz, a PARTUUID pedig változatlan.

#### Dinamikusan fájlkezelő alkalmazásban
GNOME, KDE Plasma, és sok más környezet biztosít háttérfolyamatokat, amik a fájlkezelőkben elérhetővé teszik a felcsatolható fájlrendszereket és dinamikusan, az első elérés pillanatában csatolják fel őket.

A felcsatolt fájlrendszert ezután transzparensen, a csatolási pont tartalmaként lehet elérni.

#### Tipikusan más partícióként felcsatolt mappák
**/boot**  
GPT rendszereken az *EFI System Partition* fájlrendszernek egy UEFI által olvasható, FAT32 vagy VFAT típusú partíción kell lennie. Ezt a fájlrendszert indítás után vagy a `/boot` vagy a `/boot/efi` mappába szokás felcsatolni.

**/home**  
A felhasználói mappákat mindenképp érdemes más partíción, vagy akár más lemezen tárolni.
- Takarékos hogyha a root partíción korlátozott a hely.
- Felhasználói mappáknak általában elég a lassabb elérésű, de nagyobb háttértár (pl. M.2 helyett SATA, SSD helyett HDD).
- Ha a root partíció tönkremegy, nem viszi magával a `/home` partíciót.
- Újratelepítéskor nem kell külön kimásolni a `/home` tartalmát másik lemezre, elég leválasztani a fájlrendszert.

**/srv**  
Ha egy szerver szerepkör innen szolgáltat nagy mennyiségű tartalmat, értelemszerűen érdemes más fájlrendszerre mozgatni azt.
