2019 nyarán a GitHub megszűntette a jelszavas azonosítást parancssoros felületen. Ettől fogva a `git` program kizárólag SSH kulcsos azonosítással tud hozzáférni a GitHubon tárolt repókhoz.

Ez az útmutató feltételezi a következőket:
- Fel van telepítve egy SSH kliens és a hozzá tartozó kulcsgeneráló program; ezek egyike:
	- OpenSSH-val az `ssh`, `ssh-keygen` és `ssh-agent` programok, vagy
	- PuTTY és PuTTYgen
- A `git` csomag fel van telepítve (`git -v` valós kimenetet ad),
- A GitHub-on regisztrálva van egy felhasználó és létezik a kívánt on-line repó,
- A helyi gépen létezik a kívánt repó és van rajta legalább egy commit.

## Az SSH-ról
Az SSH (Secure Shell) egy biztonságos távoli elérést biztosító hálózati protokoll, illetve az ezt megvalósító programok összessége. Legegyszerűbb formájában egy SSH kliens csatlakozik az SSH szervert futtató távoli géphez, azonosítja magát a távoli gép egy felhasználójaként, és egy titkosított csatornán keresztül indít egy terminál shell-t. Azonosításra használhat név-jelszó párost, vagy a biztonságosabb nyílt kulcsos (public key) eljárást.

Az SSH bármilyen biztonságos kommunikációra használható.

### Public Key Authentication
> "Meg tudja mondani az olvasó, hogy melyik két szám szorzata lesz 8616460799? Kétlem, hogy rajtam kívül bárki tudná."
> - William Stanley Jevons, *The Principles of Science*, 1874

A nyílt kulcsos titkosítás két kulcsra fog épülni - ez **nem összekeverendő** a kétkulcsos azonosítással (two factor authentication, 2FA).

Ez az eljárás két kriptográfiai kulcsra fog épülni.
- Az egyik a nyílt kulcs. Ez nem titkos, bárkivel meg lehet osztani, ami szükséges is lesz.
- A másik a privát vagy titkos kulcs. **Ez szigorúan titkos adat! Megosztani tilos, még saját eszközök között is.**

Ez a két kulcs egymással valamilyen matematikai kapcsolatban van. A megfelelő algoritmusok használatával a titkosítatlan adatot (cleartext, tiszta szöveg) az egyik kulccsal titkosítani lehet, ennek az eredményét (ciphertext, titkos szöveg) pedig kizárólag a hozzá tartozó másik kulccsal lehet feloldani. Ez két alapvető alkalmazást tesz lehetővé: **titkosított kommunikációt** és **azonosítást**.

#### Algoritmusok
A nyílt kulcsos kriptográfia legfontosabb eleme a titkosító algoritmus. Ez egy olyan matematikai függvény, aminek az értékét (`f(x)`) triviális idő alatt ki lehet számítani, az inverz számítása (`f'(x)`) viszont praktikusságot kizáróan lassú jelenkori számítógépekkel. Két prímszámot összeszorozni triviális, bármilyen nagyok legyenek, de az eredményt prímtényezőkre bontani egy hosszadalmas eljárás - erre épül a mai napig legelterjedtebb RSA (Rivest-Shamir-Aldeman) algoritmus. Ezen kívül népszerűek még az elliptikus görbékre épülő ECDSA (Elliptic Curve Digital Signature Algorithm) és EdDSA (Edwards-curve Digital Signature Algorithm).

### Azonosítás
- Alice (itt a GitHub felhasználó) idő előtt megosztja a nyílt kulcsát.
- Alice ír egy üzenetet. Ennek egy másolatát titkosítja a privát kulcsával. Az üzenetet és a titkosított másolatot együtt elküldi Bob-nak.
- Bob a titkosított üzenetet megpróbálja feloldani Alice nyílt kulcsával, majd összeveti az eredményt az eredeti üzenettel.
	- Ha Alice a megfelelő privát kulcsot használta, akkor a feloldott szöveg azonos lesz az eredetivel és az azonosítás sikeres.
	- Ha valaki egy másik privát kulcsot használt, vagy az üzenet út közben megsérült, akkor a feloldott szöveg nem is fog hasonlítani az eredetire.

### Titkosított kommunikáció
- Alice biztonságos üzenetet akar küldeni Bob-nak.
- Bob megosztja a nyílt kulcsát.
- Alice ezt a nyílt kulcsot használva titkosítja az üzenetet.
- Alice a titkosított üzenetet nyílt csatornán elküldi Bob-nak.
- Bob a megérkezett titkos szöveget feloldja a saját privát kulcsával.
	- Bárki más megkaphatja a titkos szöveget, de a megfelelő privát kulcs hiányában nem tudja feloldani.

## Kulcsgenerálás
### ssh-keygen
Az `ssh-keygen` az OpenSSH programcsomag kulcsgeneráló eszköze. Ezzel biztonságos kulcspárokat lehet a parancssoron létrehozni.

A program önmagában való futtatásakor generál egy alapértelmezett 2048 bites RSA kulcspárt. Ezután rákérdez, hogy hova mentse, és kér egy opcionális (erősen ajánlott) jelszót a privát kulcs további titkosításához.

A leggyakoribb beállítások:
- `-t <algoritmus>`: meghatározza a használandó kriptográfiai algoritmust. Lehetséges értékek: `dsa`, `rsa`, `ecdsa`, `ed25519`. Itt az RSA algoritmus az ajánlott - a DSA és ECDSA elméletileg sebezhetőek és az Ed25519, ugyan biztonságos, de kevésbé támogatott. https://security.stackexchange.com/a/46781
- `-b <hossz>`: az RSA kulcs alapjául szolgáló számok hossza bitekben kifejezve. Minimum 1024, alapértelmezetten 2048, de legalább 3072 ajánlott.
- `-N <jelszó>`: a privát kulcs titkosításához használt jelszó.
- `-f <fájl>`: a kimeneti fájl.

A program két fájlt fog létrehozni. A kiterjesztés nélküli fájl (pl. `id_rsa`) lesz a privát kulcs. A nyílt kulcsnak ugyanaz lesz a neve, de kapni fog egy `.pub` kiterjesztést (pl. `id_rsa.pub`). **A privát kulcs legyen egy biztonságos helyen tárolva** (mint a felhasználó home mappája), és érdemes mindenki mástól megtagadni az olvasási jogot.

### PuTTYgen
A PuTTY egy többcélú terminál emulátor Windowsra. A PuTTYgen ennek egy komponense, ami kulcsgenerálást és konverziót tesz lehetővé.

Kulcsgenerálás előtt meg lehet adni a kulcs típusát és hosszát. Itt van egy SSH-1 opció, amivel nagyon gyorsan ki tudod rúgatni magad - az SSH-1 nem biztonságos és nem érdemes használni.

Generálás közben a program kéri, hogy az egeret mozgasd az ablakon - ez növeli az entrópiát és a kulcs által nyújtott biztonságot.

Ha kész a generálás, több új mező fog megjelenni. **Az első és leghosszabb lesz a publikus kulcs.** Ezt érdemes egy szöveges fájlban elmenteni. A második egy SHA-256 kivonat, ezzel lehet a kulcsot validálni. A "Key passphrase" és "Confirm passphrase" mezőkben meg lehet adni egy jelszót a privát kulcs titkosításához.

A "Save public key" és "Save private key" gombok elmentik a kulcspárt **a PuTTY saját formátumában.** A git által használt OpenSSH privát kulcs mentésére a Conversions menüben lesz lehetőség.

## Git Remote
A GitHub szolgáltatás egy úgynevezett remote (távoli) repó. Ez lehetővé teszi ugyanannak a repónak a szinkronizálását több gépen a `fetch`, `pull`, `push` parancsokkal.

A remote-ok kezelése a `git remote` paranccsal történik.

### Hozzáadás: `git remote add`
Formája: `git remote add <név> <elérés>`

Ha a repónak csak egy remote-ja van, az szokás szerint az `origin` nevet kapja, de igazából lehet bármi.

Az elérés a GitHub által meghatározott URL lesz, a következő formában:
`git@github.com:<felhasználó>/<repó>.git`
Ez egy SSH elérés, amibe be kell helyettesíteni a megfelelő adatokat. Ennek a repónak az elérése így néz ki:
`git@github.com:gabor-motko/Ujratervezes.git`

Ezek alapján a teljes parancs:
`git remote add origin git@github.com:gabor-motko/Ujratervezes.git`

### Listázás: `git remote -v show`

### Szinkronizálás

Minden repónak (és azon belül minden ágnak) lehet egy alapértelmezett upstream repója. Ha ez be van állítva, a `git fetch`, `git push`, `git pull` parancsok automatikusan ide fognak kapcsolódni.

`git push`: feltölti a változtatásokat a legutóbb beállított upstream repóba.
`git push origin`: feltölti a változtatásokat az `origin` remote repóba.
`git push -u origin`: feltölti a változtatásokat az `origin` repóba és beállítja az `origin`-t mint alapértelmezett upstream repót.

`git fetch`: letölti az upstream repóból a változtatásokat.
`git fetch origin`: letölti az `origin` remote repóból a változtatásokat.

`git pull`, `git pull origin`: letölti és alkalmazza a változtatásokat.

## Csatlakozás GitHub-hoz
### Publikus kulcs hozzáadása GitHub fiókhoz
SSH és GPG kulcsok kezelése: https://github.com/settings/keys

Új SSH kulcs hozzáadása: https://github.com/settings/ssh/new

Ez a felület az OpenSSH **nyílt** kulcsot kéri:
- `ssh-keygen` esetén a `.pub` kiterjesztésű fájl szöveges tartalmát,
- PuTTYgen esetén a korábban említett hosszú szöveget.

### GitHub kapcsolat ellenőrzése
#### Terminálon (Linux, Windows git bash)
Futtasd a következő parancsot:
```bash
ssh -T git@github.com
```
Ez a következő hibaüzenetet fogja visszaadni:
`git@github.com: Permission denied (publickey).`
Ez azt jelenti, hogy a GitHub SSH szervere elérhető, csak nyílt kulcsos azonosítást fogad el, és elutasította a kapcsolatot, mert nem adtunk neki kulcsot.

A kulcs átadásához a következő parancs szükséges:
```bash
ssh -i <kulcsfájl> -T git@github.com
```
...ahol a `<kulcsfájl>` behelyettesítendő a privát kulcs elérésével. Fontos, hogy ha git bash parancssorban vagyunk, akkor `\` helyett `/` karaktert kell használni.
Az én gépemen például ezek lesznek a parancsok:
- Linux:
```bash
ssh -i ~/.ssh/id_rsa_github -T git@github.com
```
- Windows git bash:
```bash
ssh -i C:/Users/chump/github_openssh_private -T git@github.com
```

Ha minden rendben van, a következő üzenet jelenik meg:
`Hi gabor-motko! You've successfully authenticated, but GitHub does not provide shell access.`

#### PuTTY
PuTTY indítása után állítsd be a következőket:
- Session
	- Host Name (or IP address): github.com
	- Close window on exit: Never
- Connection > SSH > Auth
	- Private key file for authentication: az előzőleg generált PuTTY privát kulcs (.ppk kiterjesztés, nem az OpenSSH kulcs)

"Open" gomb megnyitja a terminált és kér egy felhasználónevet, ami mindig `git` lesz.
Enter után a szerver azonnal le is zárja a munkamenetet, a terminál kimenete ez lesz:
```
login as: git
Authenticating with public key "rsa-key-20220724"
Server refused to allocate pty
Hi gabor-motko! You've successfully authenticated, but GitHub does not provide shell access.
```

### SSH kulcs átadása gitnek
Az `ssh` program indításakor a kulcsot közvetlenül az `ssh`-nak adtuk át. Erre a git nem ad lehetőséget, az alábbi lehetőségek egyikét lehet használni.

#### 1. Identitás hozzáadása az SSH konfigurációhoz
Az SSH kliens konfigurációs fájlja azonos Linux és Windows git bash környezetben. Itt találhatóak (ha mégsem, ezeket hozd létre):
- Windows: `%userprofile%\.ssh\config`
- Linux: `~/.ssh/config`

A fájl végéhez add hozzá a következőt:

```config
Host github.com
	IdentityFile <kulcs>
```

...ahol a `<kulcs>` helyére a kulcsfájl elérési útja kerüljön. Fontos, hogy itt Windowson is Linux-stílusú útvonalat kér, tehát `\` helyett `/`, illetve a `~` karakter jelenti a felhasználó home mappáját. Nekem így fog kinézni:
- Windows:
```config
Host github.com
	IdentityFile ~/github_openssh_private
```
- Linux:
```config
Host github.com
	IdentityFile ~/.ssh/id_rsa_github
```

Mentés után az SSH, és ezáltal a git is, a github.com hoszthoz való csatlakozáskor egyből az itt megjelölt fájlt fogja használni kulcsként. Ha a kulcs jelszavazva van, akkor minden fetch/pull/push parancs kiadásánál kérni fogja a jelszót.

#### 2. SSH-Agent (Linux, Windows git bash)
Az `ssh-agent` program feladata, hogy a titkosított privát kulcsot egy védett memóriaterületen titkosítatlan formában tárolja, ezáltal nem kell minden műveletkor beírni a jelszót.

Az `ssh-agent` parancs két dolgot csinál: elindítja az `ssh-agent` háttérfolyamatot, és kiír egy szöveget a terminálra. Ez egy bash script, ami beállít két környezeti változót, ami által az `ssh` program el tudja érni az `ssh-agent` szolgáltatást.
Az `ssh-agent`-et a következő paranccsal lehet szabályosan elindítani:
```bash
eval $(ssh-agent -s)
```
Ez egyszerre elindítja a folyamatot és lefuttatja a kiírt scriptet. Ezután ebben a munkamenetben elérhető lesz a szolgáltatás.

Ha az `ssh-agent` fut, utána az `ssh-add` paranccsal lehet a kulcsokat memóriába tölteni:
```bash
ssh-add ~/.ssh/id_rsa_github
```

A betöltött kulcsfájlokat pedig így lehet listázni:
```bash
ssh-add -l
```
Ez kiírja a kulcs hosszát, egy SHA-256 kivonatot azonosításhoz, a kulcshoz tartozó hosztot, és a kulcs típusát.
## Kész
Ha minden rendben volt, fel lehet tölteni a repó tartalmát.
```bash
git push -u origin
```

## Szoftverek
### Windows
- Git for Windows: https://gitforwindows.org/
	- OpenSSH
	- Git Bash
- PuTTY: https://putty.org/
	- PuTTYgen

### Linux csomagok
- `git`
- `openssh` (`ssh`, `ssh-keygen`, `ssh-agent`)