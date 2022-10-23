### A script block

A script block egy olyan programozási elem, ami tetszőleges utasítások sorozatát foglalja magában. Létrehozni a kapcsos zárójelekkel lehet, benne az utasításokat sortöréssel vagy pontosvesszővel kell elválasztani.

```powershell
{
	$path = Get-Location
	Write-Host "Hello from $location"
}
```

Legegyszerűbben, például teszteléshez, az `Invoke-Command` paranccsal lehet végrehajtani a neki első argumentumként vagy a `-ScriptBlock` paraméternek átadott script blockot. Ugyanígy lehet átadni többek között a `ForEach-Object`, `Where-Object`, stb. parancsoknak.

```powershell
Invoke-Command {
	$location = Get-Location
	Write-Host "Hello from $location"
}
```
Kimenete:
```
Hello from /home/gmotko
```

### A script block egy objektum
Ezáltal el lehet tárolni egy változóban és bármikor lehet rá hivatkozni.

```powershell
$block = {
	Write-Host "Hello world!"
}

Invoke-Command $block

$block | Get-Member
```
Kimenete:
```
Hello world!

  TypeName: System.Management.Automation.ScriptBlock  
  
Name                    MemberType Definition  
----                    ---------- ----------
[...]
```

### A script blocknak lehetnek paraméterei
Ezeket a blokk elején a `param(...)` kulcsszóval lehet definiálni. Meghíváskor a parancsok `-ArgumentList` paraméternek átadott tömb (vesszővel elválasztott felsorolás) elemei kerülnek ide.

```powershell
$block = {
	param($A, $B)

	$sum = $A + $B
	Write-Host "A és B összege $sum"
}

Invoke-Command $block -ArgumentList 3, 5
$arguments = 10, 12
Invoke-Command -ScriptBlock $block -ArgumentList $arguments
```
Kimenete:
```

```

### A script block egy elkülönített hatókör (scope)

Script blockon belül csak az ott létrehozott helyi változókat, globális változókat és környezeti változókat lehet módosítani.

Ebben a példában a `$ScopeTest` változót ugyan a legkülső hatókörben, de egyébként helyi változóként hoztam létre. Ha ezt script blockon belül próbálom módosítani, akkor helyette egy új helyi változó jelenik meg.
```powershell
$ScopeTest = "Eredeti"
Write-Host "Blokk lefutása előtt: $ScopeTest"

Invoke-Command {
    $ScopeTest = "Blokkon belül módosított"
    Write-Host "Blokk lefutása közben: $ScopeTest"
}

Write-Host "Blokk lefutása után: $ScopeTest"

```
Kimenete:
```
Blokk lefutása előtt: Eredeti  
Blokk lefutása közben: Blokkon belül módosított  
Blokk lefutása után: Eredeti
```

Ezt kétféleképp lehet orvosolni.
Az első a referencia szerinti átadás vagy egy objektum vagy a `[ref]` kulcsszó használatával. Ez a téma mélyebb programozási ismereteket igényel, nem is működik jól a PowerShell-ben, most nem mennék bele.

A másik a globális változók használata a `$global:VáltozóNév` minta alapján. Ilyenkor a változót a script bármely pontján el lehet érni. **A tiszta kód érdekében ezt érdemes kerülni.**

```powershell
$global:ScopeTest = "Eredeti"
Write-Host "Blokk lefutása előtt: $($global:ScopeTest)"

Invoke-Command {
    $global:ScopeTest = "Blokkon belül módosított"
    Write-Host "Blokk lefutása közben: $($global:ScopeTest)"
}

Write-Host "Blokk lefutása után: $($global:ScopeTest)"

```
Kimenete:
```
Blokk lefutása előtt: Eredeti  
Blokk lefutása közben: Blokkon belül módosított  
Blokk lefutása után: Blokkon belül módosított
```