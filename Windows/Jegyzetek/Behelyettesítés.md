Szöveges behelyettesítésre három módszer van. Az első kettő a PowerShell-re jellemző, a `$` jelzi, hogy az azt követő részt nem szövegként, hanem programként kell értelmezni. A harmadik a .NET szöveg típusára hivatkozik, elsősorban C#, F#, Visual Basic nyelvekben fordul elő, de PowerShell-ben is elérhető.

### Egyszerű változót a `$` jel után a változó nevével:

```powershell
# A legmagasabb folyamat azonosító, egész számként
$highest_pid = (get-process | Sort-Object -Property Id -Descending | Select-Object -First 1).Id
Write-Host "Legmagasabb Process ID: $highest_pid"
```
Kimenete:
```
Legmagasabb Process ID: 53202
```

Ez be fogja illeszteni a változó értékének a szöveges reprezentációját. Itt két szempontot kell figyelem előtt tartani:  
- A változó típusa legyen vagy egy primitív típus (i.e. egész szám, valós szám, szöveg, igaz/hamis, stb), vagy egy olyan típus, amiről tudni, hogy a `.ToString()` metódus szép kimenetet ad, különben egy használhatatlan szöveget kapunk:
```powershell
# Az összes folyamat, Process objektumok listája
$processes = get-process
Write-Host "Folyamatok: $processes"
```
Kimenete:
```
Folyamatok: System.Diagnostics.Process (kworker/9:0-mm_percpu_wq)
```
- Tudni érdemes, hogy a változó egy vagy több értéket tartalmaz. Több érték esetén azok szóközökkel elválasztva össze lesznek fűzve:
```powershell
# az összes "systemd"-vel kezdődő folyamat azonosítója, egész számok listája
$pids = (Get-Process | Where-Object ProcessName -like "systemd*").Id
Write-Host "Systemd folyamatok: $pids"
```
Kimenete:
```
Systemd folyamatok: 1 877 352 588 589 555 353
```

### Tetszőleges kifejezést a `$(...)` mintával

Ez a módszer kiértékeli a `$(...)` zárójelek közötti részét és az eredményt beilleszti a szövegbe.

```powershell
$highest_pid = get-process | Sort-Object -Property Id -Descending | Select-Object -First 1
Write-Host "Legmagasabb Process ID: $($highest_pid.Id)"
```
Itt a `$highest_pid` egy `Process` típusú objektum. Ezt önmagában behelyettesíteni nem érdemes, hanem lekérem az egyik property-jét.

```powershell
Write-Host "Legmagasabb Process ID: $((get-process | Sort-Object -Property Id -Descending | Select-Object -First 1).Id)"
```
Csak hogy teljesen olvashatatlan legyen, itt az egész parancs sorozatot a szövegen belül hajtom végre. Az eredmény ugyanaz lesz, mint az előző két példában.

### .NET-en keresztül, `[string]::Format(...)` metódussal

Aki használt már C#-ot, az biztos találkozott a `string.Format(...)` függvény egy változatával, leginkább a `Console.WriteLine(...)` formájában. Ezt a PowerShell-en keresztül a `[string]::Format(...)` formában tudjuk elérni. Ez a függvény a zárójelen belül egy kötelező és tetszőleges számú opcionális paramétert vár.

Az első paraméter a formátum string (minta string, format string, template string). Ez tartalmazhat egyrészt szöveget, másrészt kapcsos zárójelek között hivatkozásokat a behelyettesítendő értékekre (nullától számozva). Például: `"{0} és {1} összege {2}"`. 

A többi paraméter tartalmazza a behelyettesítendő tetszőleges kifejezéseket. Az elsőre a `{0}` hivatkozik, a másodikra a `{1}`, és így tovább.

Az itteni példa így nézne ki:

```powershell
$a = 3
$b = 5
$result = [string]::Format("{0} és {1} összege {2}", $a, $b, $a + $b)
Write-Host $result
```
Kimenete:
```
3 és 5 összege 8
```

Az előző példa pedig így:
```powershell
Write-Host [string]::Format("Legmagasabb Process ID: {0}", (get-process | Sort-Object -Property Id -Descending | Select-Object -First 1).Id)
```

Ezt azért lesz érdemes néha használni, mert a format string sokkal rugalmasabb, mint a PowerShell-féle behelyettesítés. Például itt a `{0:f5}` az első paramétert formázza tizedes törtként (`f` mint `float`) öt tizedes jegyig:

```PowerShell
$pi = 3.14159265358979
Write-Host [string]::Format("Pi értéke öt tizedes jegyig: {0:f5}", $pi)
```