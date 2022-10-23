$file = Get-Item .\ures2.txt
$file | Get-Member
$systemdir = "C:\windows\system32"

Get-ChildItem -Path $systemdir
(Get-ChildItem -Path $systemdir).Length

Get-ChildItem -Path $systemdir -Recurse | Select-Object FullName, Length

$dirs = Get-ChildItem -Path $path -Recurse
$dirs | Select-Object FullName, Length | Format-List

Get-ChildItem -Path $path -Recurse | Where-Object {$_.Length -eq 0} | Select-Object FullName, Length
Get-ChildItem -Path $systemdir | Where-Object {$_.Name -like '*win*'} | Select-Object FullName, Length
Get-ChildItem -Path $path -Recurse | Where-Object {$_.Extension -eq '.txt'}  | Select-Object FullName, Length
Get-ChildItem -Path $path -Recurse | Select-Object FullName, Length | Sort-Object Length -Descending -Unique

# Számoljuk meg hány .txt fájl van a c:\windows\system32 könvtárban és alkönyvtáraiban