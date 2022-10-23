
# a C meghajtó hibaüzeneteinek (is) ignorlása
$ErrorActionPreference= 'silentlycontinue'

#fix dolgok
$current_partitions =(Get-PSDrive -PSProvider FileSystem)
$save_path_end = 'Copy_and_list_it_Script\Átmásolt_fájlok\'
$choices = @('&0', '&1','&2')
$decision = $Host.UI.PromptForChoice('Fájlok keresése és másolása','Mire szeretnél keresni? Kiterjesztés = 0, Név = 1, Mindkettőre = 2  ', $choices, 1)


    #felhasználó választ
If ($decision -eq 0) {
    
    #felhasználó megadja az inputot
    [String]$ext = Read-Host "Kérlek add meg milyen kiterjesztést keressek (ponttal kezdve)"
    
    #belépés sorban az összes particóra
    Foreach ($i in $current_partitions) { 
    Set-Location -PassThru $i.Root #kiprinteli a meghajtó betüjelét
    if(!(Test-Path -Path $save_path_end ))
    #kimeneti mappa létrehozása
        {New-Item -ItemType Directory -Path $save_path_end | Out-Null}
 
    #.csv mentési helyének beállítása
    $save_path = Join-Path -Path $i.Root -ChildPath $save_path_end
    
    #keresés az adott particón
    Write-Host  "........................Keresés folyamatban...................."
    Write-Host  ''
    Write-Host  ''
    Write-Host  ''
    Get-ChildItem -Path $i.Root -Recurse | Where-Object {$_.Extension -eq "$ext"}  | `
    
    #találatok listázása .csv fájlba
    Select-Object FullName, Name | ConvertTo-Csv | Out-File -FilePath .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    
    #másolás az elkészült lista alapján
    $copied_files_list = Import-Csv .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    $copied_files_list | ForEach-Object { Copy-Item -Path $_.Fullname -Destination $save_path_end }

    #eredmény kiírása
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host '---------------------------------------------------'
    Write-Host 'Az alábbi fájlok kerültek átmásolásra'
    Write-Host '---------------------------------------------------'
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Output $copied_files_list.Name
        }
    }
elseif ($decision -eq 1) {
    #felhasználó megadja az inputot
    [String]$name = Read-Host "Kérlek add meg milyen fájlnévre keressek"
    
    #belépés sorban az összes particóra
    Foreach ($i in $current_partitions) { 
    Set-Location -PassThru $i.Root #kiprinteli a meghajtó betüjelét
    if(!(Test-Path -Path $save_path_end ))
    #kimeneti mappa létrehozása
        {New-Item -ItemType Directory -Path $save_path_end | Out-Null}
 
    #.csv mentési helyének beállítása
    $save_path = Join-Path -Path $i.Root -ChildPath $save_path_end
    
    #keresés az adott particón
    Write-Host  "........................Keresés folyamatban...................."
    Write-Host  ''
    Write-Host  ''
    Write-Host  ''
    Get-ChildItem -Path $i.Root -Recurse | Where-Object {$_.Name -like "*$name*"}  | `
    
    #találatok listázása .csv fájlba
    Select-Object FullName | ConvertTo-Csv | Out-File -FilePath .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    
    #másolás az elkészült lista alapján
    $copied_files_list = Import-Csv .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    $copied_files_list | ForEach-Object { Copy-Item -Path $_.Fullname -Destination $save_path_end }

    #eredmény kiírása
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host '---------------------------------------------------'
    Write-Host 'Az alábbi fájlok kerültek átmásolásra'
    Write-Host '---------------------------------------------------'
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Output $copied_files_list.FullName
        }
    }
elseif ($decision -eq 2) {
    #felhasználó megadja az inputot
    [String]$ext = Read-Host "Kérlek add meg milyen kiterjesztést keressek (ponttal kezdve)"
    Write-Host  ''
    Write-Host  ''
    [String]$name = Read-Host "Kérlek add meg milyen fájlnévre keressek)"
    
    #belépés sorban az összes particóra
    Foreach ($i in $current_partitions) { 
    Set-Location -PassThru $i.Root #kiprinteli a meghajtó betüjelét
    if(!(Test-Path -Path $save_path_end ))
    #kimeneti mappa létrehozása
        {New-Item -ItemType Directory -Path $save_path_end | Out-Null}
 
    #.csv mentési helyének beállítása
    $save_path = Join-Path -Path $i.Root -ChildPath $save_path_end
    
    #keresés az adott particón
    Write-Host  "........................Keresés folyamatban...................."
    Write-Host  ''
    Write-Host  ''
    Write-Host  ''
    Get-ChildItem -Path $i.Root -Recurse | Where-Object {($_.Extension -eq "$ext") -and ($_.Name -like "*$name*")}  | `
    
    #találatok listázása .csv fájlba
    Select-Object FullName, Name | ConvertTo-Csv | Out-File -FilePath .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    
    #másolás az elkészült lista alapján
    $copied_files_list = Import-Csv .\Copy_and_list_it_Script\Átmasolt_fájlok_listája.csv
    $copied_files_list | ForEach-Object { Copy-Item -Path $_.Fullname -Destination $save_path_end }

    #eredmény kiírása
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host '---------------------------------------------------'
    Write-Host 'Az alábbi fájlok kerültek átmásolásra'
    Write-Host '---------------------------------------------------'
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Host ''
    Write-Output $copied_files_list
    }
}
else {
    Write-Host 'További szép napot'
}

#visszaállás az alapértelmezett partícióra
Write-Host 'Visszatérés az alapértelmezett meghajtóra'
Set-Location -PassThru $current_partitions[0].Root



 