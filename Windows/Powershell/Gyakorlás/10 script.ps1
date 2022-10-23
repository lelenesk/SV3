Get-command -noun Localuser
Get-command -noun Localgroup
Get-command -noun LocalGroupMember
Show-Command New-LocalUser

New-Localuser -Name DemoUser3 -Description 'demouservalami' -NoPassword
Remove-LocalUser -Name Demouser3

New-LocalGroup -Name Ujcsoport1

Get-LocalGroup Ujcsoport1 | Get-Member
Get-LocalGroupMember Ujcsoport1

Add-LocalGroupMember -Group Ujcsoport1 -Member DemoUser3

$jelszo = ConvertTo-SecureString 'Welcome01' -AsPlainText -Force

New-LocalUser -Name 'magdolna.kiss' -FullName 'Kiss Magdolna' `
    -Description 'Pénzügyi vezető' -Password $jelszo

$userlist = Import-Csv .\users.csv
$userlist | Format-Table

Foreach ($user in $userlist) {
    $jelszo = ConvertTo-SecureString $user.password -AsPlainText -Force
    
    $ujuser = New-LocalUser -Name $user.name -FullName $user.Fullname `
        -Description $user.Description -Password $jelszo
    
    Add-LocalGroupMember -Group $user.group -Member $ujuser
}