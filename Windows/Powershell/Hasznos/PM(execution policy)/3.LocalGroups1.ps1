<#
Lokális csoportok és csoporttagok
A sorokat egyenként próbáljátok ki.
Azokat a sorokat amik értéket adnak 1 változónak mindig hamarabb le kell futtatni mint a sort ami utána a változóra mutat.
Hogy 1 változó éppen milyen értéket tartalmaz azt a nevével ki tudjátok iratni.
#>

$csoport = 'Rendszergazdák'
$csoportok = 'Rendszergazdák', 'Felhasználók', 'Asztal távoli felhasználói'

Get-LocalGroup
Get-LocalGroup | select *
Get-LocalGroup | select Name, PrincipalSource
Get-LocalGroup $csoport 
Get-LocalGroup $csoport | select *
Get-LocalGroup $csoportok
Get-LocalGroup $csoportok | select *

$osszescsoport = Get-LocalGroup | select *
$osszescsoport.Name
$osszescsoport.Description

#Új felhasználói csoport:
New-LocalGroup -Name "Ujcsoport1" -Description "Ujcsopi1 az új felhasználóknak"

#Lokális csoportok tagjai
Get-LocalGroupMember $csoport
Get-LocalGroupMember $csoport | select *

#Hozzáadom a csoporthoz az új felhasználóimat amit a 2.LocalUser1.ps1 fájlban csináltam
Add-LocalGroupMember -Group Ujcsoport1 -Member Mentor3
Add-LocalGroupMember -Group Ujcsoport1 -Member Mentor4, Mentor5

#Vagy kiveszem a csoportból, jelen esetben mentor5-öt
Remove-LocalGroupMember -Group Ujcsoport1 -Member Mentor5