$valasz = @('&Yes', '&No')
$dontes = $Host.UI.PromptForChoice('Konyvtarak letrehozasa','Biztos benne?', $valasz, 1)
If ($dontes -eq 0) {
    Write-Host "Igent nyomtál"
}
Else {
    Write-Host "Fityiszt"
}