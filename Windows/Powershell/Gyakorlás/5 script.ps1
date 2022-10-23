Get-ChildItem -Path $path -Recurse | Where-Object {$_.Extension -eq '.txt'}  | `
 Select-Object FullName, Length | ConvertTo-Csv  | Out-File txtlista.csv

Get-ChildItem -Path $path -Recurse | Where-Object {$_.Extension -eq '.txt'}  | `
 Select-Object FullName, Length | Export-Csv txtlista2.csv

$txtlista = Import-Csv .\txtlista.csv
$txtlista[1].FullName


$txtfiles = Get-ChildItem -Path $path -Recurse | Where-Object {$_.Extension -eq '.txt'}
$txtfiles | ForEach-Object { Copy-Item -Path $_.Fullname -Destination $path\copyk } 