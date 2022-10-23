<# 

**************************************ELMÉLET*************************************************

Azure felület beállításai:


resource group --- Virtuális gépek ----- Új

Előfizető: Progmasters U
Resource group: a sajátod
Nincs szükség redundanciára

Image - MS datacenter - gen2
SPOT INSTANCE - IGEN
VM méret
usernév / jelszó - írd fel, jegyezd meg!
port : default 3389 nyitva

DISK:
Standard SSD
nincs szükség plusz lemezre

Network:
minden default
törölje ha a vm is törlődik
tagekkel egyedi keresési lehetőséget adhatunk kulcs/érték (key/value pair) formájában
többi FÜL default értékek.






***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***VMINTA***MINTA***MINTA***MINTA***
***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***MINTA***VMINTA***MINTA***MINTA***MINTA***


Basics:
Subscription Progmasters U   
Resource group RG-SV3 (saját)  
Virtual machine name demosrv1 (saját)  
Region West Europe   
Availability options No infrastructure redundancy required  
Security type: Standard  
Image: Windows Server 2019 Datacenter - Gen2  
Size: Standard D2as v4 (2 vcpus, 8 GiB memory) (saját)
Username handras
Public inbound ports: RDP (legyen nyitva)
Already have a Windows license? No
Azure Spot Yes (Stop / Deallocate) - ! FONTOS!
Azure Spot max price

Disk
OS disk type Standard SSD LRS
Use managed disks Yes
Delete OS disk with VM Enabled
Ephemeral OS disk No

Networking
Virtual network (new) RG-SV3-vnet (saját)
Subnet (new) default (10.1.0.0/24) (saját)
Public IP (new) demosrv1-ip
Accelerated networking On
Place this virtual machine behind an existing load balancing solution? No
Delete public IP and NIC when VM is deleted Enabled

Management
Microsoft Defender for Cloud
Basic (free) 
Boot diagnostics On
Enable OS guest diagnostics Off
System assigned managed identity Off
Login with Azure AD Off
Auto-shutdown Off
Backup Disabled
Site Recovery Disabled
Enable hotpatch Off
Patch orchestration options OS-orchestrated patching: patches will be installed by OS

Advanced
Extensions None
VM applications None
Cloud init No
User data No
Proximity placement group None
Capacity reservation group None

Tags (saját)
letrehozo handras (Auto-shutdown schedule)
letrehozo handras (Availability set)
letrehozo handras (Disk)
letrehozo handras (Network interface)
letrehozo handras (Network security group)
letrehozo handras (Public IP address)
letrehozo handras (Recovery Services vault)
letrehozo handras (SSH key)
letrehozo handras (Storage account)
letrehozo handras (Virtual machine)
letrehozo handras (Virtual machine extension)
letrehozo handras (Virtual network)


Telepités után:

Rámenni a virtuális gépre (Overview):
Connect---RDP---fájl letöltése---indítsa---belépés login/password 

Server manager-----local server:

IE Enchanched Security Configuraiton:
Mindkettő off: (neteléréshez)

*ipconfig
*ping valami.hu
*get-computerinfo


átlépés "all serverbe"
kiválasztani a létrehozott szervert-----jobb klikk----- start performance counters

****Port nyitás Opcionális****************************************






*********************************Távoli kapcsolódás RDP-n**************************************

felhasználó: számítógépnév\usernév példa: demosrv1\handras jelszó: 'amit adtál'




********************************Távoli kapcsolat - PSSession************************************

Invoke-Command -Session $valtozo -ScriptBlock {Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools}









*****************************************CORE GÉP KONFIGURÁLÁSA:***************************************


*HA BEZÁRTAD AZ ABALKOT: CTRL+ALT-END----task manager---runtask-----cmd
átmenni powershellbe "powershell"
get valami info majd "exit"


***************************Beállitásokhoz: "sconfig"****************************************************

network settings(8)---
-----index alapján(1) itt fix ip cím beállítása


configure remote managemant(4)---
----------enable remote mamagemant(1)(távoli hozzáéférés engedéylezése)
-----------configure server reesponse to Ping(3)--engedélyezni kell hogy másik géppel tudjam pingelni


remote desktop(7)-----
---------e (enabled)-------(2)less secure(tüzval beállitását kihagyjuk ne ezen akdjunk fent)



******************************** 2 szerver összekapcsolása*********************************************

server manageren belül: all servers---jobb klikk----add server-----DNS fül----ipc cím alapján keresés (10.0.0.5) majd hozzáadás

ezután winrm Negotiation autchenticaiton error lesz (mert nem tudja a géphez tartozo flehsz/jelszot)
jobb klikk rá---manage as---itt megadni a logint

eztuán:
Set-Item WSMan:localhost\client\trustedhosts -value *  majd Y(Yes)  (gui-s gépen)
refresh a server managerbe

ezután:
$valtozo = New-PSSession –ComputerName 10.0.0.4 –Credential Caldera\Ghost
jelszó megadása 


euztán:
Enter-PSSession –ComputerName  10.0.0.4 –Credential Caldera\Ghost
jelszó megadása

ellenörzés: $env:COMPUTERNAME
kilépés(a sessionből): exit



ezután:
Invoke-Command -Session $valtozo -ScriptBlock {Get-WindowsFeature}
telepitett cuccok lekérdezése

Invoke-Command -Session $valtozo -ScriptBlock {Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools}
uj cuccok telepitése

a valtozo itt: = Get-PSSession Id 2 ( a kettő a kiválaszatni kivánt pss session sorszáma)

ezután: defender firewall---advancedsettings-inbonud rules----"Windows managemant http in"



---------------------Azon a gépen amelyiket kezelni akarod:-----------------------------------------




********************Ellenőrizni, hogy a WinRM szolgáltatás fut:************************  

Get-Service WinRM

(vagy részletesebben)
Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"} 

*******************HA NEM: ********

akkor el kell indítani: Set-Service WinRM -StartMode Automatic

**************Engedélyezni a PSRemote-ot:*********

Enable-PSRemoting -Force 

(vagy)
Enable-PSRemoting -Force ‑SkipNetworkProfileCheck 

(If the computer's current connection type is set to public, the above command will produce an error message
because by default PowerShell remoting is only enabled for private and domain connection types. To avoid the error message and enable PowerShell 
remoting on a public network, you can use the ‑SkipNetworkProfileCheck parameter.)




-----------------------------------------Azon a gépen amelyikről kezeled:----------------------------------------------

*************Felvenni a hostot a megbízható hostok közé**********

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.0.2.33" -Force  
 
(vagy engedélyezni mindent) 
Set-Item WSMan:localhost\client\trustedhosts -value *
 
Trusted hostok ellenőrzése: 
Get-Item WSMan:\localhost\Client\TrustedHosts


*****************PSSession létrehozása*******************

$valtozo = New-PSSession –ComputerName xxxx –Credentials domain\serveradmin 

(vagy csak simán) 
New-PSSession –ComputerName xxxx –Credentials domain\serveradmin

******************Belépés 1 PSSessionbe*********************
Enter-PSSession –ComputerName xxxx –Credentials domain\serveradmin vagy ha van háttérkapcsolat akkor Enter-PSSession $valtozo

############################################## 2 ora ###############################################################
 

Invoke-Command -Credential $cred -ScriptBlock {$env:COMPUTERNAME} -ComputerName demosrv2core

$username = "szamitogepnev\felhasznalo"
$password = ConvertTo-SecureString "jelszo" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $password)

$cred2 | Export-CliXml -Path '.\credcore.xml'
$credentialuj = Import-CliXml -Path '.\credcore.xml'

$pssession = New-PSSession -ComputerName PMSRV1 -Credential $PMSRV1Credential
Enter-PSSession $pssession

New-SmbShare -Name "Peldashare" -Path "C:\Peldashare"

Invoke-Command -Credential $credentialuj -ComputerName demosrv2core -ScriptBlock {
Get-SmbShare -Name "Peldashare"
Get-SmbShareAccess -Name "Peldashare"}

Invoke-Command -Credential $credentialuj -ComputerName demosrv2core -ScriptBlock {
New-Item -ItemType Directory -Path c:\Peldashare\ -Name FACTORY
}

Invoke-Command -Credential $credentialuj -ComputerName demosrv2core -ScriptBlock {
Grant-SmbShareAccess -Name PeldaShare -AccountName Everyone -AccessRight Full
}

Copy .\index.html '\\10.1.0.5\c$\inetpub\wwwroot'
#>