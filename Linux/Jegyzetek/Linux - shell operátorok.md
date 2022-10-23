# Átirányítás
## `>` Kimenet átirányítása fájlba
```bash
cat /etc/passwd > test.txt
```
Kiüríti a test.txt fájlt és beleírja a parancs kimenetét.

## `>>` Kimenet hozzáfűzése fájlhoz
```bash
cat /etc/shells >> test.txt
```
A test.txt tartalmát megtartja és a végéhez hozzáfűzi a parancs kimenetét.

## `<` Fájl beolvasása bemenetre
```bash
grep 'usr' < test.txt
```
A test.txt tartalmát soronként beolvassa a bal oldali parancs bemenetére.

## `|` Pipe - kimenet átirányítása másik bemenetre
```bash
cat /etc/shells | grep 'usr'
```
A bal oldali parancs kimenetét átirányítja a jobb oldali parancs bemenetére.

# Együttes végrehajtás
## `A; B`
Végrehajtja A-t. Ha az lefutott, végrehajtja B-t.

## `A && B`
Végrehajtja A-t. Ha végzett és nem futott hibára, végrehajtja B-t.

## `A || B`
Végrehajtja A-t. Ha végzett és hibára futott, végrehajtja B-t.

## `A &`
Elindítja A-t és a folyamatot egyből a háttérbe rakja.

## `A & B`
Elindítja A-t és egyből a háttérbe rakja, majd végrehajtja B-t.
Például:
```bash
mpv & disown
```
elindítja az MPV médialejátszót, háttérbe rakja, majd a `disown` parancs "leválaszja" a shellről. Így a terminált be lehet zárni anélkül, hogy az MPV is leállna.

# Parancs előzmények
## `!!` Utolsó parancs
Visszahívja a legutóbb kiadott parancsot.
```
[gmotko@Overlord ~]$ pacman -S youtube-dl
error: you cannot perform this operation unless you are root.
[gmotko@Overlord ~]$ sudo !!
sudo pacman -S youtube-dl
[sudo] password for gmotko: 
```

## `!1`, `!-1` Parancs előzmények
Visszahívja a megadott sorszámú parancsot az előzmény fájlból (pl. `.bash_history`). Ha a szám pozitív, akkor a fájl elejétől (legrégibb parancs) számol. Ha a szám negatív, a végétől (legújabb) számol.