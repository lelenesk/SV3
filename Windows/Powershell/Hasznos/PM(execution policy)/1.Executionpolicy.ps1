<#
Ez ami kimaradt mert elfelejtettem a bevezetőben:
A powershellnek is van verziója.
#>
$PSVersionTable

<#
script futtatás engedélyezés
#>
Get-ExecutionPolicy -List

<#
Scope ExecutionPolicy
----- ---------------
MachinePolicy       Undefined
UserPolicy       Undefined
Process    RemoteSigned
CurrentUser       Undefined
LocalMachine    RemoteSigned
#>

#Az összeset undefined-ra állítja
Set-ExecutionPolicy Undefined

# -Scope adat alapján 1-1 hozzáférés állítása
Set-ExecutionPolicy Undefined -Scope Process
Set-ExecutionPolicy Restricted -Scope LocalMachine
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

#Hiba mert nem rendszergazda jogokkal indítottam a powershellt
<#
Set-ExecutionPolicy Restricted -Scope LocalMachine
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Set-ExecutionPolicy : A következő beállításkulcshoz való hozzáférés megtagadva: „HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell”. 
To change the execution policy for the default (LocalMachine) scope, start Windows PowerShell with the "Run as administrator" option.
 To change the execution policy for the current user, run "Set-ExecutionPolicy -Scope CurrentUser".
#>

# Próbálkozás után állítsd vissza az eredeti állapotot.