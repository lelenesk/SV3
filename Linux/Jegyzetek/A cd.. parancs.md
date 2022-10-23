Miért fontos a POSIX?

```bash
[gmotko@Overlord ~]$ cd..
bash: cd..: command not found
```

Ezért fontos a POSIX.

A `cd..` parancsot a Microsoft adta hozzá a PowerShell és CMD shellekhez a szülőmappa eléréséhez rövidítésként. Én ezt hibának tartom, **rossz szokások rögzüléséhez vezet**, hiszen ez a parancs a Microsoft rendszereken kívül nem mindenhol létezik. A Unix-szerű rendszerek legnépszerűbb shelljei (`sh`, `bash`, `zsh`, `fish`) közül egyik sem tartalmazza.

### Mi a megoldás?
**A `cd..`-ot el kell felejteni**, helyette rászokni a szabályos formára:
```bash
[gmotko@Overlord ~]$ cd ..
```
A `cd` és a `..` között szükség van egy szóközre. A `..` egy speciális mappabejegyzés minden mappában, ami a szülőmappára mutat, tehát a `cd ..` hatására a `cd` program visszalép a szülő könyvtárba.

### De mégis...
A Linuxban mindenre ezer és egyféle megoldás van. Aki ragaszkodik a `cd..`-hoz, az létrehozhat magának egy aliast:
```bash
alias cd..="cd .."
```
...vagy többet is:
```bash
alias cd.2="cd ../.."
alias cd.3="cd ../../.."
```

Ez az alias addig él amíg a shell folyamat ki nem lép. Maradandóvá tenni a shell konfigurációs fájljában lehet: bash-nál ez a `.bashrc`, zsh-nál a `.zshrc`. Ezek tulajdonképpen script fájlok, amik a shell indulásakor futnak le - az alias parancsot elég a végére beilleszteni.