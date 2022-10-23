[CmdletBinding()]
Param (
   #[Parameter(ValueFromPipelineByPropertyName)]
   [Parameter(Mandatory)]
   [string] $csvpath, 

   [Parameter()]
   [string] $startdir
)

$stringem = $null
$stringem = "nem üres"
$stringem = ""
If ($stringem) {
    Write-Host "Igen"
}
Else {
    Write-Host "Nem"
}