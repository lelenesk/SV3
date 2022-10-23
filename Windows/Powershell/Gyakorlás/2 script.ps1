Get-command -Noun *ChildItem*
Get-command -Noun *location*
$path = 'C:\Users\hidve\OneDrive\Progmasters\SV3\Powershell'

$path2 = "$env:Userprofile\Desktop"
$holvagyok = Get-Location
$holvagyok | Get-Member
Get-Location | Get-Member
Set-Location 

Get-ChildItem | Get-Member
$tartalom = Get-ChildItem

New-Item -ItemType Directory -Name Probadir
New-Item -ItemType Directory -Name Probadir\Probadir2\Probadir3

New-Item -ItemType File -Name ures.txt

New-Item -ItemType File -Name ures2.txt -Path $path\probadir
New-Item -ItemType File -Name ures2.txt -Path "C:\install"
New-Item -ItemType File -Name ures3.txt -Path .\Probadir2 # Nem mert file


Get-Content .\datum.html