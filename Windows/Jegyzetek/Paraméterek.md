# Paraméterek

Program, parancs, vagy függvény hívásakor azoknak a paraméterekkel lehet adatokat átadni.

## Deklaráció
Paramétereket a script elején a `param(...)` kulcsszóval lehet deklarálni, vesszővel elválasztva, a változókhoz hasonlóan.

`parameters.ps1`
```powershell
param(
	$Title,
	$FirstName,
	$LastName
)

Write-Host "Behold, the mighty $Title $FirstName $LastName."
```

Az itt deklarált paraméterekre lehet hivatkozni név vagy sorrend alapján.

`Terminal`
```
PS /home/gmotko/PS> ./parameters.ps1 "Legatus" "Gaius" "Baelsar"
Behold, the mighty Legatus Gaius Baelsar.
PS /home/gmotko/PS> ./parameters.ps1  -LastName "Galvus" -FirstName "Varis" -Title "Emperor"
Behold, the mighty Emperor Varis Galvus.
```

## Alapértelmezett érték

Ha egy paraméternek nem adunk értéket híváskor, akkor a scripten belül `$null` (azaz semmi) értéket fog felvenni, de lehetőség van alapértelmezett érték megadására is.

`default_value.ps1`
```powershell
param(
    $TestArg = "Nem meghatározott"
)

Write-Host "TestArg: $TestArg"

```

`Terminal`
```
PS /home/gmotko/PS> ./default_value.ps1  
TestArg: Nem meghatározott  
PS /home/gmotko/PS> ./default_value.ps1 -TestArg "asdf"  
TestArg: asdf
```

## Típus
Ahogy a változóknak, úgy a paramétereknek is vannak típusaik. Ez egyrészt híváskor korlátozza, hogy milyen típusú adatot lehet átadni a paraméternek. Másrészt ez információt adhat a scriptnek, az `-is` és `-isnot` operátorokkal, hogy a paraméterként kapott adatot hogyan értelmezze.

Típusokra mindig szögletes zárójellel utalunk. Paraméter típussal együttes deklarációjakor a típus megelőzi a paraméter nevét.
```powershell
param(
	[string] $StringParameter,
	[int] $IntParameter
)
```

Ha a paraméternek nem adunk explicit típust, akkor az mindig `[object]` típust fog kapni, ami mindenféle adatot elfogad.

A PowerShell képes implicit típuskonverzióra. Ha észszerű átértelmezni egy adattípust, és az nem fog adatvesztést okozni (például `float` -> `int` konverziónál elvész a törtrész), akkor azt automatikusan végrehajtja.

## Switch típus
Deklaráció: `[switch] $SwitchParam`

A `switch` egy speciális igaz/hamis típus. Ezt parancs hívásakor érték nélkül, csak a neve alapján adjuk meg.

```powershell
param(
	[switch] $SwitchParam
)
Write-Host "SwitchParam értéke: $SwitchParam"
```
```
> .\switch.ps1
SwitchParam értéke: False
> .\switch.ps1 -SwitchParam
SwitchParam értéke: True
```

## Attribútumok
A .NET-ben (tehát többek között a PowerShell-ben is) az attribútumok egyes programozási elemekhez további meta-adatokat határozhatnak meg, amik reflexió által befolyásolják azok értelmezését.

Az attribútumokat a paraméter neve (vagy ha van, a típusa) elé, szögletes zárójelbe kell írni. Az attribútumnak lehetnek beállításai, ezeket kerek zárójelben, vesszővel elválasztott `Név = Érték` formában kell megadni.
```
param(
	[Attribútum(Beállítás = Érték, Beállítás = Érték...)]
	[típus] $Paraméter
)
```

### `Parameter` attribútum
Ez azt határozza meg, hogy milyen formában lehet parancs hívásánál hivatkozni a paraméterre.

Fontosabb beállítások:
#### `Mandatory`
Lehetséges értékek: `$true` vagy `$false`
Ha `$true`-ra van beállítva, akkor ennek a paraméternek kötelező értéket adni. Ha nem kap értéket a parancs hívásakor, akkor interaktívan kér a felhasználótól egy értéket.

#### `Position`
Várt érték: egész szám nullával kezdve
Ha ez meg van adva, felülírja, hogy sorrend alapján történő értékadáskor hanyadik helyen lévő értéket kapja ez a paraméter.