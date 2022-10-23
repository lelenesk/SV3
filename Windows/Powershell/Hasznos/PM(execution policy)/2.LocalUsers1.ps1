
<#
Lokális felhasználók
A sorokat egyenként próbáljátok ki.
Azokat a sorokat amik értéket adnak 1 változónak mindig hamarabb le kell futtatni mint a sort ami utána a változóra mutat.
Hogy 1 változó éppen milyen értéket tartalmaz azt a nevével ki tudjátok iratni.
#>

#Változó értékadás
$felhasznalo='**********'  #ide a saját felhasználotok nevét irjátok

#Változó lekérdezése egyszerűen a nevével
$felhasznalo

#Lokális felhasználók
Get-LocalUser
Get-LocalUser $felhasznalo
Get-LocalUser $felhasznalo | select *

#Új felhasználó powershell scripttel - a konzultáción nem beszéltünk róla de próbáljátok ki.
#1.
$ujnev = "Mentor3" #bármi lehet
$ujleiras = "Mentor3 teszt felhasználó"
New-LocalUser -Name $ujnev -Description $ujleiras -NoPassword

#2.
$ujnev2 = "Mentor4"
$ujleiras2 = "Mentor4 teszt felhasználó jelszóval"
$jelszo2 = ConvertTo-SecureString "teszt" -AsPlainText -Force  #Próbáljátok ki, hogy a $jelszo változó milyen értéket ad vissza.
New-LocalUser -Name $ujnev2 -Description $ujleiras2 -Password $jelszo2 

#3
$ujnev3 = "Mentor5"
$ujleiras3 = "Mentor5 teszt felhasználó jelszóval amit bekérünk."
$jelszo3 = Read-Host -AsSecureString  #Próbáljátok ki, hogy a $jelszo változó milyen értéket ad vissza.
New-LocalUser -Name $ujnev3 -Description $ujleiras3 -Password $jelszo3

#És most változtatok rajta
Set-LocalUser $ujnev3 -FullName "Teljes Neve a felhasználónak"

#Ellenörzöm
Get-LocalUser $ujnev3 | Select Name, Fullname
$mostcsinaltam = Get-LocalUser $ujnev3
$mostcsinaltam.Fullname
$mostcsinaltam.Name
$mostcsinaltam | select *

# Ha kész van lépjetek ki az aktális felhasználóval és lépjetek be legalább 1 új most létrehozott felhasználóval.

#Felhasználót törölni sem nehéz
#Néhány felhasználóra szükség lesz a lokális csoportoknál a teszteléshez, ha kitörlöd, utána csinálj újra párat

# VIGYÁZZ!!! mit törölsz :)
Remove-LocalUser $ujnev 
Remove-LocalUser Mentor5 

