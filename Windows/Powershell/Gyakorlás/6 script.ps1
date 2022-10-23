if (Test-Path -Path "C:\valami") {
     Write-Host "van"
     }
else {
    Write-Host "nincs"
}
$jpath1 = "C:\"
$jpath2 = "\Felhasználók"
$jpath3 = "\hidve"
$jpathsum = Join-Path -Path $jpath1 -ChildPath $jpath2 | Join-Path -ChildPath $jpath3