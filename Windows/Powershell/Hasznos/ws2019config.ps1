

<#

*******************************beállítások*******************

-----core gép------:

sconfig-ból:

configure remote management- enable 
configure server response to ping- allow (alapból tiltva van)
remote destkop -enable -less secure (távoli asztal elérés, tüzfal így biztos nem fog meg)) #>



#***** core beállítások powershellböl********:

#lekérdezni:
Get-WmiObject -Class win32_service | Where-Object {$_.name -like "WinRM"} 
#engedélyezni:
Set-Service WinRM -StartMode Automatic
Enable-PSRemoting -Force 
Enable-PSRemoting -Force -SkipNetworkProfileCheck  #( a skiprofilcheck csak akkor kell ha nincsen egy domainen pl AD-vel)



#------gui-s gép-----------: (amiről kezelni akarok mindent)
#PS REMOTE:
#lekérdezni:
get-Item WSMan:\localhost\Client\TrustedHosts 
#engedélyezni:
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "10.0.0.4" -Force (ip címet megadni)
#vagy mindenkire:
Set-Item WSMan:localhost\client\trustedhosts -value *  


<#-----SERVER MANAGERBEN--------: 

all servers- add ( DNS fülön, privát IP címet megadni)

jobb klikk rá- manage as ( gépnév/felhasználónév, jelszót megadni)

!!!!!!!!!!!!!!!!! DNS-t beállítani azurben az RDP fájlhoz!!!!!!!!!!!!!!!!!!!!!!!! (IP cím változik ha pl kikapcsolom,ennek áthidalására)

#>



#********PS Session létrehozása (csatlakozás)******
$ujkapcsolat = New-PSSession –ComputerName "ip cím" –Credential "gépnév/felhasználónév" #(idézőjel nem kell)
#vagy
New-PSSession –ComputerName "ip cím" –Credentials "gépnév/felhasználónév" #(idézőjel nem kell)


#-------belépés PS Sessionbe------
Enter-PSSession $ujkapcsolat
#vagy:
Enter-PSSession –ComputerName "ip cím" –Credential "gépnév/felhasználónév" #(idézőjel nem kell)
#exit-el kilépés


Invoke-Command -Session $londonSession -ScriptBlock {Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools}



#*********Scriptblock futtatása távoli gépen***********
Invoke-Command -Session $ujkapcsolat -ScriptBlock {Get-WindowsFeature}

#!!!!!!!!előre létrehozott ps session nélkül is müködik így, de bejelentkeztetni fog:
Invoke-Command -ComputerName "szervernév" -Credential "gépnév/felhasználónév" -ScriptBlock {Get-WindowsFeature} #(idézőjel nem kell)







#************Featureok telepitése (webserver)*****************
Invoke-Command -Session $ujkapcsolat -ScriptBlock {Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools}

#*************scriptek futtatása saját gépről*****************
Invoke-Command -Session $ujkapcsolat -FilePath "C:\valami\valami.ps1"  #(idézőjel nem kell)







#**********másik gépbe lépés session Helyett CREDENTIAL-el**********

$cred = Get-Credential
Invoke-Command -Credential $cred -ScriptBlock {$env:COMPUTERNAME} -ComputerName "ip cím vagy szervernév" #(idézőjel nem kell)

#ugyanez csak előtte "létrehozzuk" a felhasználót, illetve fájba mentése és olvasása

$username = "gépnév/felhasználónév"
$password = ConvertTo-SecureString "jelszó" -AsPlainText -Force
$tesztcredential = New-Object System.Management.Automation.PSCredential ($username,$password)


$tesztcredential | Export-Clixml -Path .\credcore.xml
$kiolvasottcred = Import-Clixml -Path .\credcore.xml
Invoke-Command -Credential $kiolvasottcred -ScriptBlock {$env:COMPUTERNAME} -ComputerName "ip cím vagy szervernév" #(idézőjel nem kell)







#*****************   Mappamegosztás   ********************************

New-SmbShare -Name "Peldashare" -Path "C:\Peldashare"
# ezt követően  fájlekzelőben: \\10.0.0.4 
# majd bejelentkezés (ezután név szerint is müködik)

#jogosultságok lekérdezése
Invoke-Command -Credential $cred -ComputerName "szervenév" -ScriptBlock {
Get-SmbShare -Name "PeldaShare"
Get-SmbShareAccess -Name "PeldaShare"}

#JOGOSULTSÁG HOZZÁRENDELÉSE
Invoke-Command -Credential $cred -ComputerName "szervenév" -ScriptBlock {
Grant-SmbShareAccess -Name Peldashare -AccountName Everyone -AccessRight Full}

#uj mappa létrehozása
Invoke-Command -Credential $cred -ComputerName "szervenév" -ScriptBlock {
New-Item -ItemType Directory -Path C:\Peldashare -Name FACTORY}



#cmdből is lehet https://www.howtogeek.com/118452/how-to-map-network-drives-from-the-command-prompt-in-windows/



#**************IIS default page lecserélése*****************

#csináljunk egy index.html fájlt tetszőleges tartalommal

Copy .\index.html '\\10.0.0.4\c$\inetpub\wwwroot' 






#***********************Quota kezelés***********************

#ezeket telepiteni kell hozzá (lehet server managerből is)
Get-WindowsFeature -Name FS-Resource-Manager, RSAT-FSRM-Mgmt
Install-WindowsFeature -Name FS-Resource-Manager, RSAT-FSRM-Mgmt

$quotacred= Import-Clixml -Path .\credcore.xml

Invoke-Command -Credential $quotacred -ComputerName "szervenév" -ScriptBlock {
Get-FsrmQuotaTemplate
Get-FSRMQuota}

#beállítása
New-FsrmQuota -Path "C:\Peldashare" -Description "limit usage to 1 GB." -Size 1GB

#saját létrehozáésa és beáálítása
New-FsrmQuotaTemplate -Name Sajatquota -Size 10485760 -SoftLimit
New-FsrmQuota -Path "C:\Peldashare" -Template 'Sajatquota'

#ha másik gépen csinálom elöször remove-qouta aztán New-qouta két külön invoke-command scriptblockban






#**************futtasd a core szerveren hogy AZ IIS-ben lásd őt WMSC*************************

#ez mehet cmd-be

Reg Add HKLM\Software\Microsoft\WebManagement\Server /V EnableRemoteManagement /T REG_DWORD /D 1

netsh advfirewall firewall add rule name=”Allow IIS Web Management” dir=in action=allow service=”WMSVC”

net start wmsvc

#8172-es port nyitása (Azureon belül) elvileg kell gyakorlaitlag nem








#***************** PSProvider és PSdrive **************************************************

#fájlrendszer felcsatolás betűjel vagy név alapján

New-PSDrive -Name "S" -PSProvider FileSystem -Root \\Gépnév\felhasználónév -Persist #(-Persist - file rendszerben is látszik)
New-PSDrive -Name "SShare" -PSProvider FileSystem -Root \\Gépnév\felhasználónév

Remove-PSDrive  -Name "SShare" -Force

#registryt is lehet pl csatolni:
New-PSDrive -Name "Sreg" -PSProvider Registry -Root HKLM:\SOFTWARE\Microsoft\ServerManager







#****** BPA  *********************************************************

#lekérdezés
Get-BpaModel | select ID, Name, lastscantime
Invoke-BPAModel “Microsoft/Windows/WebServer”
Invoke-BPAModel “Microsoft/Windows/FileServices”
Get-BpaResult “Microsoft/Windows/FileServices” | format-table Severity,Category,Problem

#lekérdezés távoli gépen
$credcore = Import-CliXml -Path '.\credcore.xml'
$pssession = New-PSSession -ComputerName demosrv2core -Credential $credcore
Enter-PSSession $pssession


Invoke-Command -Credential $credcore -ComputerName demosrv2core -ScriptBlock {
  # Get-BpaModel | select ID, Name, lastscantime  (nem kell,.teszt hogy vane telepitve)
  # Invoke-BPAModel “Microsoft/Windows/WebServer” (nem kell,.teszt hogy vane telepitve)
  # Invoke-BPAModel “Microsoft/Windows/FileServices” (nem kell,.teszt hogy vane telepitve)
  Get-BpaResult “Microsoft/Windows/WebServer” | Where-Object {$_.Severity -eq 'Information'}
  Get-BpaResult “Microsoft/Windows/FileServices” | Where-Object {$_.Severity -eq 'Information'}
} | Out-GridView
# vagy pl.: 
# | Out-GridView  helyett  | ConvertTo-Json | Out-File $env:USERPROFILE\eredmeny.json








#******************* event logok kezelése*************************************

Get-EventLog System -Source Microsoft-Windows-Winlogon
Get-EventLog -LogName Application | Where-Object Source -Match defrag
eventvwr
C:\Windows\System32\winevt\Logs


#lekérdezések
Get-Service event* #minden log

Get-WinEvent -LogName Application | Where-Object { $_.ProviderName -Match 'defrag' }
Get-WinEvent -ListProvider *
Get-WinEvent -ListLog * |Out-GridView

Get-WinEvent -ListLog *Hyper-v* 
Get-WinEvent -ListLog Microsoft-Windows-Hyper-V-Guest-Drivers/Admin |select *

Get-WinEvent -ListLog System | Format-List -Property *

Get-WinEvent -ListLog * | Where-Object {$_.Islogfull}
Get-WinEvent -ListLog * -ComputerName localhost | Where-Object { $_.RecordCount } #csak ahol van érték

Get-EventLog -LogName *


#hány darab és milyen log van beenne, illetve adja vissza amit kérek
$Event = Get-WinEvent -LogName 'Windows PowerShell'
$Event.Count
$Event | Group-Object -Property Id -NoElement | Sort-Object -Property Count -Descending
$Event | Group-Object -Property LevelDisplayName -NoElement


#30 napra visszameőleg
$StartTime = (Get-Date).AddDays(-30)


#szűrés filterhastable-el
$events = Get-WinEvent -FilterHashtable @{logname="System"; Level=1} -ErrorAction SilentlyContinue
Get-WinEvent -FilterHashtable @{logname="System"; Level=1; starttime =$StartTime}

#1 -critical
#2 -error
#3 -warining
#4 -information


#házi feladat lekérdezés:
$lognumbers =@(21,22,24,25,39,40)
Foreach ($lognumber in $lognumbers)
    {
    (Get-WinEvent -ListProvider Microsoft-Windows-TerminalServices-LocalSessionMananger).Events |where id -eq $lognumber
    }


#profi házi feladat lekérdezés:
$selectedNumbers =@(21,22,24,25,39,40)
$serverlista = 'gepnev'

$Events = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -in $selectedNumbers)}
$Results = Foreach ($Event in $Events) {
    $Result = "" | Select Message,User,TimeCreated, LevelDisplayName
    $Result.TimeCreated = $Event.TimeCreated
    $Result.LevelDisplayName = $Event.LevelDisplayName
    Foreach ($MsgElement in ($Event.Message -split "`n")) {
        $Element = $MsgElement -split ":"
        If ($Element[0] -like "User") {$Result.User = $Element[1].Trim(" ")}
        If ($Element[0] -like "Remote Desktop Services") {$Result.Message = $Element[1].Trim(" ")}
    }
    $Result
}
$Results | Select Message, User,TimeCreated,LevelDisplayName | Out-GridView
#$Results | Select Message, User,TimeCreated | Export-Clixml C:\windows



#nemtudom mik:
Get-WinEvent -FilterHashtable @{
  Logname='Application'
  ProviderName='Application Error'
  Data='iexplore.exe'
  StartTime=$StartTime
}



Get-WinEvent -ListProvider *
(Get-WinEvent -ListLog Application).ProviderNames
(Get-WinEvent -ListLog system).ProviderNames
(Get-WinEvent -ListLog security).ProviderNames

$events = (Get-WinEvent -ListProvider Microsoft-Windows-Eventlog).Events 
$events | Where-Object {$_.id -eq 1103}

(Get-WinEvent -ListProvider Microsoft-Windows-GroupPolicy).Events | Format-Table Id, Description




Get-WinEvent -LogName *PowerShell*, Microsoft-Windows-Kernel-WHEA* |
   Group-Object -Property LevelDisplayName, LogName -NoElement |
     Format-Table -AutoSize

Get-WinEvent -LogName "Microsoft-Windows-PowerShell/Operational" | Where-Object {$_.LevelDisplayName -eq "Hiba"}


#******************** Monitoring *********************

Get-Counter -ListSet * #milyen coutnerek vannak
Get-Counter -ListSet * | Select-Object -ExpandProperty CounterSetName 

Get-Counter -ListSet *disk* | Select-Object CounterSetName, CounterSetType, Description, Paths | Out-GridView -Title "Disk counters" #felugro ablakban vannak a csoportok,lehet hivtakozni aZ utvonalra
$c1 = Get-Counter -ListSet *disk* | Select-Object CounterSetName, CounterSetType, Description, Paths | Out-GridView -Title "Disk counters" -OutputMode Multiple #igy már több kiválasztható + ok gomb = belerakja a c1 változoba


$c2 = Get-Counter -ListSet LogicalDisk
$c2.Counter # vissza adja hogy mire tudok hivtakozni

$c3 = Get-Counter -ListSet process
$c3.Counter

# c3.counter-re vissza adott cuccok közül pakoljuk be ide
$Counters = @(
    '\processor(_total)\% processor time',
    '\memory\% committed bytes in use',
    '\memory\cache faults/sec',
    '\physicaldisk(_total)\% disk time',
    '\physicaldisk(_total)\current disk queue length'
    '\Network Adapter(*)\Bytes Total/sec'
)

# listázzuk ki őket
Get-Counter -Counter $Counters -MaxSamples 5 | ForEach {
    $_.CounterSamples | ForEach {
        [pscustomobject]@{
            TimeStamp = $_.TimeStamp
            Path = $_.Path
            Value = $_.CookedValue
        }
    }
} 

#valami
Get-Counter -ListSet * | Where-Object -FilterScript { $PSItem.countersetname -match ‘network’}
Get-Counter -ListSet * | Where-Object -FilterScript { $PSItem.countersetname -match 'network'} | Select-Object -Property CounterSetName
Get-Counter ‘\Network Adapter(*)\Bytes Total/sec’ 
Get-Counter -ListSet * | where{$_.CounterSetName -like "*Processor*"} | Select CounterSetName, Counter
Get-Counter -ListSet * | where{$_.CounterSetName -like "*disk*"} | Select CounterSetName, Counter


#****** win32 cimisntance ekérdezések (linuxon is müködhet)***************

Get-WmiObject win32_logicaldisk -ComputerName gepnev

Get-CimInstance -ClassName win32_logicaldisk -ComputerName gepnev, gepnev2

Get-CimInstance -Query "SELECT * from win32_Process WHERE name LIKE 'S%'" -ComputerName gepnev, gepnev2 # S-el kezdőődek kilistázása

Get-Counter -ListSet LogicalDisk -ComputerName gepnev

#példák
Get-Command -name "*wmi*"
Get-Command -name "*cim*"
Get-CimClass -ClassName "*Network*"

$osztaly = Get-CimClass win32_process
$osztaly.CimClassMethods
$osztaly.CimClassMethods["Create"].Parameters
$osztaly | Invoke-CimMethod -MethodName Create -Arguments @{commandline='notepad.exe'}


Get-CimInstance -ClassName "CIM_NetworkAdapter" | Get-Member

Get-WmiObject -List

Get-WmiObject -class Win32_NetworkAdapter| Get-Member

Get-WmiObject -Class Win32_Bios | Get-Member

Get-WmiObject -Class "win32_computersystem" | Select-Object model
Get-WmiObject -Class "win32_computersystem" | Get-Member

Get-WmiObject -Class "win32_operatingsystem" | Get-Member

Get-WmiObject win32_operatingsystem -Property lastbootuptime

$datumotcserelek = Get-WmiObject win32_operatingsystem 
$most = (Get-Date).AddDays(-1)

$datumotcserelek.SetDateTime( $most )



$computer = "LocalHost" 
$namespace = "root\WMI" 
Get-WmiObject -class BatteryStatus -computername $computer -namespace $namespace


$computer = "LocalHost" 
$namespace = "root\CIMV2" 
Get-WmiObject -class Win32_Processor -computername $computer -namespace $namespace

$property = “systemname”,”maxclockspeed”,”addressWidth”,“numberOfCores”, “NumberOfLogicalProcessors”
Get-WmiObject -class win32_processor -Property  $property | Select-Object -Property $property

Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select Average

Get-WmiObject Win32_Processor | Select LoadPercentage | Format-List


$computer = "LocalHost" 
$namespace = "root\CIMV2" 
Get-WmiObject -class Win32_Process | get-member 


$Disk = Get-WmiObject -Class Win32_logicaldisk | select *
Get-WmiObject -Class Win32_DiskPartition
Get-WmiObject -Class Win32_Fan

Get-WmiObject -Class Win32_PhysicalMemory


$Disk.GetRelationships() | Select-Object -Property __RELPATH

Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType 


$aa = Get-CimInstance -ClassName Win32_Process

Invoke-CimMethod -ClassName Win32_Process -MethodName "Create" -Arguments @{
  CommandLine = 'notepad.exe'; CurrentDirectory = "C:\windows\system32"}

$aa | Get-Member

Get-CimInstance -Namespace root/wmi -ClassName MsAcpi_ThermalZoneTemperature -Filter "Active='True' and CurrentTemperature<>2732" -Property InstanceName, CurrentTemperature |
    Select-Object InstanceName, @{n='CurrentTemperatureC';e={'{0:n0} C' -f (($_.CurrentTemperature - 2732) / 10.0)}}


$wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$wmi.SetDNSServerSearchOrder("8.8.8.8")

$wmi.DNSServerSearchOrder


Get-Counter -ListSet * | Select-Object -ExpandProperty CounterSetName 
Get-Counter -ListSet *Hyper-V* | Select-Object CounterSetName, CounterSetType, Description, Paths | Out-GridView -Title "Hyper-V counters" 

$TotalCounter = Get-Counter -ListSet *
$TotalCounter | Measure-Object | select Count

(Get-Counter '\Hyper-V Dynamic Memory VM(*)\Average Pressure').CounterSamples[0].CookedValue 

$HyperVInformations = (get-counter -ListSet "Hyper-V hipervizor").paths
Get-Counter -Counter $HyperVInformations

Get-counter -ListSet *memória*

Get-counter -ListSet "Memória"



































