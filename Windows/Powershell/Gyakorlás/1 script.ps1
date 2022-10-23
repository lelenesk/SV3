# Comment
<#
Hosszabb komment
asdasdasd
#>
$path = 'C:\Users\hidve\OneDrive\Progmasters\SV3\Powershell' # Ez egy változó 
$nevem = 'András'
$gepem = Get-ComputerInfo
$aa = $gepem.CsProcessors
Write-Host '---------------------------------'
Write-Host "Az én nevem: $nevem"
Write-Host ""
Write-Host "Dátum:" (Get-Date) (Get-Date).Dayofweek
Write-Host ""
# Write-Host ($aa).name
Write-Output "Gépem:" ($gepem).CsProcessors.Name
Write-Host '---------------------------------'