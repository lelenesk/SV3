<#
.SYNOPSIS
  Script for 1.Get computerinfo 2.Calculate with dates
.DESCRIPTION
  This script will 1.Gathering enviromental and hardware information,then post it to CLI. 2.Calculate the difference between 2 dates in days, 
    or add fix intervals (90 and 180 days) to the user input. Save the results in a text file.
.PARAMETER
  -
.INPUTS
  <CLI Input from user>
.OUTPUTS
  No log file but the results saved in a .txt file name "calculated_dates"
.NOTES
  Version:        5.1.22000.653
  Author:         Gerbovics Tamás
  Creation Date:  <2022.08.07.>
  Purpose/Change: Educational
.EXAMPLE
  .\2_heti_szintfelmero_feladat.ps1
  .\Copy_and_list_it.ps1
#>

#requires -version 5.1

<#**********************************************************ELSŐ FELADAT***********************************************************#>

#Készíts egy scriptet ami lekérdezi a számítógép néhány elemét és azt rendezett és olvasható formában kiírja a terminál ablakban.

#---------------------------------------------------------[Initialisations]--------------------------------------------------------
$user_pc = Get-ComputerInfo
$pc_date = Get-Date
$drives = (Get-PSDrive -PSProvider Filesystem)
#----------------------------------------------------------[Declarations]----------------------------------------------------------
$pc_ostype = $user_pc.OsName
$pc_brand = $user_pc.CsManufacturer
$pc_proc = $user_pc.CsProcessors.Name
$pc_arch = $user_pc.OsArchitecture
#-----------------------------------------------------------[Finish up]------------------------------------------------------------
Write-Host
Write-Host
Write-Host "Lekérdezés ideje: "$pc_date.DateTime                            -BackgroundColor Yellow -ForegroundColor Blue 
Write-Host
Write-Host
Write-Host "*************************************************************"  -BackgroundColor Black -ForegroundColor Red
Write-Host "Felhasználó neve: " $env:USERNAME                               -BackgroundColor Black -ForegroundColor Red
Write-Host "Windows verziója: " $pc_ostype                                  -BackgroundColor Black -ForegroundColor Red
Write-Host "A rendszer a(z) " $env:SystemDrive " meghajtón található"       -BackgroundColor Black -ForegroundColor Red
Write-Host                                                                  -BackgroundColor Black -ForegroundColor Red
Write-Host                                                                  -BackgroundColor Black -ForegroundColor Red
Write-Host "Gép márkája: " $pc_brand                                        -BackgroundColor Black -ForegroundColor Red
Write-Host "Architektúra: " $pc_arch                                        -BackgroundColor Black -ForegroundColor Red
Write-Host "Processzor: " $pc_proc                                          -BackgroundColor Black -ForegroundColor Red
Write-Host "*************************************************************"  -BackgroundColor Black -ForegroundColor Red
Write-Host
Write-Host   "Partíciók név szerint:"                                       
Write-Output $drives.Description                                           
Write-Host "-------------------------------------------------------------"


<#******************************************************MÁSODIK FELADAT***********************************************************#>

#Számold ki hány nap telt el 2 dátum között. 
#Írasd ki egy a konzolon bekért dátum 90, 180 nappal későbbi dátumát.
#Másold a kódod a megadott template fájlba és az eredményt ne a konzolon jelenítsd meg, hanem egy fájlba írasd ki.
#Bővítsd ki a lekérdezéseket a Get-Disk, Get-Partition néhány adatával

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

$current_date = Get-Date
$location = Get-Location
$disk = Get-disk
$diskformat= $disk[0].Size /1GB
$partition = Get-Partition
[int]$counter = Read-Host "Kérlek add meg hány db dátummal szeretnél dolgozni"

$choices = @('&0', '&1')
$decision = $Host.UI.PromptForChoice('Műveletek dátumokkal','Milyen müveletet szeretnél elvégezni? Hány nap telt el? = 0, Dátum összeadás = 1 ', $choices, 0)

#----------------------------------------------------------[Declarations]----------------------------------------------------------
If ($decision -eq 0) {
    forEach ($i in 1..$counter) {
        $input_date = Read-Host "Kérlek add meg a dátumot (yyyy.mm.dd.)"
        $the_days = New-TimeSpan -Start $input_date -End $current_date

        $row_counter = New-Object PSObject -Property @{
        Number = $the_days.Days
        Date = $input_date
        Diskname = $disk[0].FriendlyName
        Disksize = "{0:n2}" -f $diskformat
        Partitionletter = $partition.DriveLetter
        }
        $all_data ="$($row_counter.Number) nap telt el $($row_counter.Date) óta. A HDD/SSD típusa: $($row_counter.Diskname)`
         Mérete: $($row_counter.Disksize) GB Logikai particióinak jele: $($row_counter.Partitionletter)"
        
        $all_data | Out-File -FilePath .\calculated_dates.txt  -Encoding utf8  -Append
    }
}
elseif ($decision -eq 1) {
    forEach ($i in 1..$counter) {   
        $unformatted_date = Read-Host "Kérlek add meg a dátumot amihez hozzá szeretnél adni"
        $date_tobe_added = Get-Date $unformatted_date

        $row_adder = New-Object PSObject -Property @{
        New_date90 = $date_tobe_added.AddDays(90) 
        New_date180 = $date_tobe_added.AddDays(180)
        Origi_date = $date_tobe_added
        }

        $all_data2 ="$($row_adder.Origi_date)  +90 nap az  $($row_adder.New_date90). $($row_adder.Origi_date) + 180 nap pedig $($row_adder.New_date180) "
        $all_data2 | Out-File -FilePath .\calculated_dates.txt  -Encoding utf8  -Append
    }
}
else{
    Write-Host "További szép napot"
}

#-----------------------------------------------------------[Finish up]------------------------------------------------------------

Write-Host " Dátumok mentve a " $location "calculated_days nevű fájljába"