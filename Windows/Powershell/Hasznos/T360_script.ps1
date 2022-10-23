#************************************Alias*****************************************************

New-Alias mappalista Get-ChildItem #Új Alias felvétele

Get-Alias -Definition Get-ChildItem #Alias lekérdezése

#*********************Show command*************************************************************

#Paraméterek megadása windows ablakban, parancs kitöltés pl : Default fül>name>"w32time">alul run Csak ezt a propertyt kéri le


Show-Command Get-Service

#*************************************Get help*************************************************

Get-Help Get-Service #Get-service lekérdezése

#Get help paraméterezése

Get-Help Get-Service -Full #minden info
Get-Help Get-Service -Examples #példák
Get-help Get-Service -Online #Böngésző nézet
Get-help Get-Service -ShowWindow #Windows ablak nézet + KERESÉS
Get-help Get-Service -Parameter Name # Get-service Name paramétere

#Általános powershell technikák/kjépességek/koncepciok lekéárdezése (gépen megtalálható fájlok)

Get-Help about*
Get-help about about_Aliases
Get-help about about_Aliases -ShowWindow

#*************************************Get-Command*********************************************

Get-Command # minden
Get-Command -Verb Get #előtag lekérdezés
Get-Command -Noun *net* #utótag lekérdezés
Get-Command -Verb Get -Noun *net* #konkrétabban


#*********************************Modul és PSSnapin*******************************************

#"külső" "parancsfájlok" használata

# Powershell 3 felett ez felesleges, mert az AUTOLOAD behuzza pl, PowerShellGet->Find-Command modulja


Get-Module #sessionben lévő betöltött modulok lekérdezése
Get-Module -ListAvailable #gépen elérhető modulok listája

Import-Module PowerShellGet #a listáról egy modul beimportálása

Get-Module #(Opcionális, csekkolom hogy ottvane már)
Get-Command -Module PowerShellGet  # az új modul parancsainak listázása

#Find-Command 

Remove-Module PowerShellGet #modul eltávolítása

$env:PSModulePath  #modulok helye a gépen, innen automatikusan tudja autoloadolni

#**************************************Pipeline********************************************

<# 

Parancsok összefüzésére, jele     | 
az egyik kimenete a következő bemenete
a kimenetek objektumok

Tipikus használat:

Get | Set
Get | Where
Select | Set

#>

# Pipeline kimenetének formázása

Get-Service | Format-Table  Get-Service |  #default
Get-Service | ft

Get-Service | Format-List  #tételes felsorolás
Get-Service | fl

Get-Service | Format-Wide  # két oszlop--> kisebb hely
Get-Service | fw

Get-Service | Format-Table -Property Name,Status,StartType #más tartalmu táblázáat lesz a property nevek alapján


#***********************************Get-Member*******************************************

#pipelinennal használni, megtudni az objektum tulajdonságait (mit lehet vele kezdeni) 
#Property,Method,Event (vissz ad valamit, csinál valamit, pl megváltozik valamelyik service státusza vmi esemény miatt
#legfelül látszik hogy milyen tipusu objektum
# .Net tipusuak ezek az objektumok (neten rá lehet keresni)


Get-Service | Get-Member
Get-Process | Get-Member
Get-Process | Get-Member

#***********************************Sort Object (RENDEZÉS)*****************************************

Get-Process | Sort-Object -Property ID  #csoportokba/sorrendbe rendezés ID alapján (numerikus soorrend)
Get-Service | Sort-Object -Property Status #csoportokba/sorrendbe rendezés Status alapján (stopped,running, stb)
Get-EventLog -LogName Security -Newest 30 #legutolsó 30 sec. log bejegyzés lekérdezése

Get-EventLog -LogName Security -Newest 30 | Get-Member #mindegyik propertijeinek kilistázása

#bejegyzések rendezése időpont alapján és a legrégebbi legelől

Get-EventLog -LogName Security -Newest 30 | Sort-Object -Property TimeWritten -Descending 


#***********************************Measure Object (SZÁMOLÁS)**************************************

#Objektumgyüjteményt fogad, Megadott property alapján számol ez mindenképp NUMERIKUS KEL LLEGYEN!! Kimenet->más obejktum tipus lesz mint ami bemenet (pl nem servicecontroller)

Get-Service | Measure-Object #megszámolja hány db
Get-Service | Measure-Object | Get-Member # kimeneti objektum tipusa (Genericmeausreinfo)

Get-Process | Measure-Object -Property VM -Sum -Average # vm alapján sztámol szummát és averaget (a count az összes process)

#*********************************Select Object (kiválasztás) - részhalmaz************************

#csak ezek az értékek mennek tovább a pipeon (a default helyett)-->optimalázás szempont is

Get-Process | Sort-Object -Property VM -Descending | Select-Object -First 10 #vm alapján csökkenő listázás, első 10 eleme kiválasztva
Get-EventLog -LogName Security -Newest 30 | Select-Object -Property EventID,Timewritten #eventidvel és timewritten lehet tovább dolgozni, tovább pipeolni

#*********************************Kalkulált propertyk***********************************************

<# 

A $PSItem és a $_ ugyanugy használható (ugyanaz) ezzel tudunk hivatkozni a pipelineon érkező objektumra

Szintaktika:

Label-Property neve
Expression - Property értéke

    @ {
    n = ezittnév ;
    e = { ezzel dolgozunk itt } (psitem.valami)
    }

#>

# Lekéri a Size-t és a Fresspace-t, megfromázza Gb formátumban, és új propertyt hoz létre neki ( Size(gb), Freespace(GB) ) 

Get-Volume | Select-Object -Property Driveletter, @{ n = 'Size(GB)'; e = {'{0:N2}' -f ($PSItem.Size / 1GB)}}, @{ n = 'FreeSpace(GB)'; e = {'{0:N2}' -f ($_.SizeRemaining / 1GB)}}


#******************************************* PSProvider*********************************************

Get-PSProvider #(ezen belül van registry)
Get-Help Registry #irja a legalján  hogy van about fájlja)
Get-Help about_Providers

#******************************************* PSDrive************************************************

# mikkel tudunk navigálni benne (listák)

Get-Command -Noun Item
Get-Command -Noun ChildItem
Get-Command -Noun ItemProperty
Get-Command -Noun Location


New-PSDrive -Name Próbamappa -Root C:\próbaútvonal -PSProvider FileSystem # Új PSdrive (partició) létrehozása
New-Item c:\próbaútvonal\próbamappa -ItemType Directory # új mappa élterhozása ( uccsó \ után a mappanév)

#Registry elérése, szerkesztése

Get-PSDrive #lekérdezés,van neki HKLM-je

Set-Location HKLM:\SOFTWARE | New-Item -name demoreg #bejegyzés létrehozása
Set-Location HKLM:\SOFTWARE | New-ItemProperty -Path HKLM:\SOFTWARE\demoreg -name demokulcs -Value 'ertek' -Type String  #kulcs léterhozása

Get-ItemProperty -Path HKLM:\SOFTWARE\demoreg #lekérdezés
 
#******************************************** Változok ************************************************
#automatikus tipuskonvezió van ( ha helyes formátumban adod meg, felismeri az adott tipust)
# típusok 

$filePath = "C:\Temp\"                         #utvonal /string
$szam = 42                                     #szam
$service = Get-Service "w32time"               #objektum jelenleg servicecontroller
$today = Get-Date                              #dátum típus

#tipusellenőrzés

$szam | Get-Member # legelején kiírja
$szam.GetType() #metódusk tehát kell a zárójel (paraméterlista)
$today.GetType()


#Propertyk elérése változón keresztül (példa)

$service.Status

# milyen változói vannak (lekérdezése)

        # 1 lehetőség
Get-Variable 

        # 2 lehetőség
Get-PSDrive   #van variable-je
Set-Location Variable:  #bemegyünk oda
Get-ChildItem  #kilistázzuk

#adott típus kikényszerítése

[int]$szam2 = "42"


#**************************************  manipuláció ****************************************

$logFilePath = "c:\Logs"

$logFilePath.Contains("c:") # Tartalmazza-e? True vagy False ad vissza
$logFilePath.Insert(7,"\logfile.log")  #Beszúrja a 7-edik helyre
$logFilePath.Remove(0,2) # 0-dik karaktertől 2 karkaternyit vágjon

$logFilePath













