$array = @("ertek1", "ertek2")
$array2 = "ertek1", "ertek2", "ertek3", "ertek4", "ertek5"

$array2.Length

0..$array2.Length | Foreach-Object { Write-Host $array2[$_] }
Foreach-Object { Write-Host $array2[$_] } 