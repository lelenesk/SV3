<#
Napi Powershell
Get-Command

Get-Command a úgy lett kialakítva, hogy segítsen megkeresni a parancsokat.
A Get-Command a rendszeren lévő összes parancs listáját adja vissza.

# Néhány formátum ahogy a hivatalos segítség elérhető:
Get-Help -Name Get-Command -Full
Get-Help -Name Get-Command -Online
Get-Help -Name Get-Command -Detailed
Get-Help -Name Get-Command -ShowWindow

https://docs.microsoft.com/hu-hu/powershell/scripting/learn/ps101/02-help-system?view=powershell-7
#>

#1. 
Get-Command 
Get-Command -Name *LocalU*
Get-Command -Name Get-Local*

Get-Command -Name Get-ExecutionPolicy | select *
$parancs = Get-Command Set-ExecutionPolicy

$parancs.Module
$parancs.DLL
$parancs.Version

<# 
2. Biztos észrevettétek, hogy a powershell parancsok egy IGE-FŐNÉV (Verb-Noun) kombinációból állnak. 
Vegyük az ismert példákat:
Get-LocalUser:          Get - Ige(verb)    LocalUser - Főnév(noun)
Add-LoclaGroupMember:   Add - Ige          LocalGroupMember - Főnév 
Set-ExecutionPolicy:    Set - Ige          ExecutionPolicy - Főnév

Kérdezzük le a Localuser főnévhez tartozó összes igét(verb) hogy milyen parancsok léteznek (mit tudunk csináni a helyi felhasználó fiókokkal):
#>
Get-Command -noun LocalUser

#3. Nézzük milyen Főnevek léteznek pl az "Add" -hoz: (jó hosszú lista)
Get-Command -verb Add

#4. Lekérdezhetjük csak az igéket (verb). Illetve egy egyszerűen meg is számolom őket, de ez 1 másik napi powershell óra része lesz...
Get-Verb
(Get-Verb).length

#5. Nézzük a gyakorlati hasznát, Néhány példával:
Get-Command -Noun Command       #Get: ige, Command: főnév
Get-Command -Noun Process       #Mit csinálhatunk a futó folyamatokkal (Get-Process)
Get-Command -Noun Service       #Mit csinálhatunk a szolgáltatásokkal (Get-Services)

Get-Command -Verb Find          #Mely parancsokanak létezik Find- előtagja
Get-Command -Verb New

#Próbáljátok ki az általatok ismert parancsokkal.

