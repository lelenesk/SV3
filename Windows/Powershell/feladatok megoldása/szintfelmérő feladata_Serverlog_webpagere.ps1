

#************************* első feladat **************************************

$londonUsername = "London\RichAdmin"
$londonPassword = ConvertTo-SecureString "Thisis46352413!" -AsPlainText -Force
$credLondon = New-Object System.Management.Automation.PSCredential ($londonUsername,$londonPassword)

#PS session a core géphez
$londonSession = New-PSSession –ComputerName 10.0.0.7 -Credential $credLondon


# "budapesti (GUI) szerver:
$bpheader = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }

        #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }
    



</style>
"@

$bpComputerName = "<h1>Szerver neve: $env:computername</h1>"
$bpdate = "<h2>Lekérdezés dátuma: $(Get-Date)</h2>"
$bpOSinfo = Get-CimInstance -Class Win32_OperatingSystem | ConvertTo-Html -As List -Property Version,Caption,BuildNumber,Manufacturer -Fragment -PreContent "<h2>Rendszer információk:</h2>"
$bpProcessInfo = Get-CimInstance -ClassName Win32_Processor | ConvertTo-Html -As List -Property Name,Caption,MaxClockSpeed,Manufacturer -Fragment -PreContent "<h2>Processzor Típusa:</h2>"
$bpDiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -As List -Property DeviceID,VolumeName,Size,FreeSpace -Fragment -PreContent "<h2>Meghajtók:</h2>"
$bpServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10  |ConvertTo-Html -Property Name,DisplayName,State -Fragment -PreContent "<h2>Futó szolgáltatások:</h2>"

$bpselectedNumbers =@(21,22,24,25,39,40)  
$bpEvents = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -in $bpselectedNumbers)}
$bpResults = Foreach ($bpEvent in $bpEvents) {
    $bpResult = "" | Select Message,User,TimeCreated, LevelDisplayName
    $bpResult.TimeCreated = $bpEvent.TimeCreated
    $bpResult.LevelDisplayName = $bpEvent.LevelDisplayName
    Foreach ($bpMsgElement in ($bpEvent.Message -split "`n")) {
        $bpElement = $bpMsgElement -split ":"
        If ($bpElement[0] -like "User") {$bpResult.User = $bpElement[1].Trim(" ")}
        If ($bpElement[0] -like "Remote Desktop Services*") {$bpResult.Message = $bpElement[1].Trim(" ")}
    }
    $bpResult
}
$bplogs = $bpResults | ConvertTo-Html -Fragment -PreContent "<h2>Log bejegyzések:</h2>"
$bpReport = ConvertTo-HTML -Body "$bpdate $bpComputerName $bpOSinfo $bpProcessInfo $bpBiosInfo $bpDiscInfo $bpServicesInfo $bplogs" -Title "Házi feladat GUi szerver" -Head $bpheader -PostContent "<h2>Készítette: Gerbovics Tamás<h2>"

$bpReport | Out-File -FilePath 'C:\inetpub\wwwroot\index.html' 


# "londoni (core) szerver:
Invoke-Command -Session $londonSession -ScriptBlock {
$loheader = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    }

    
    h2 {

        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;

    }

    
    
   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }

        #CreationDate {

        font-family: Arial, Helvetica, sans-serif;
        color: #ff3300;
        font-size: 12px;

    }
    



</style>
"@

$loComputerName = "<h1>Szerver neve: $env:computername</h1>"
$lodate = "<h2>Lekérdezés dátuma: $(Get-Date)</h2>"
$loOSinfo = Get-CimInstance -Class Win32_OperatingSystem | ConvertTo-Html -As List -Property Version,Caption,BuildNumber,Manufacturer -Fragment -PreContent "<h2>Rendszer információk:</h2>"
$loProcessInfo = Get-CimInstance -ClassName Win32_Processor | ConvertTo-Html -As List -Property Name,Caption,MaxClockSpeed,Manufacturer -Fragment -PreContent "<h2>Processzor Típusa:</h2>"
$loDiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -As List -Property DeviceID,VolumeName,Size,FreeSpace -Fragment -PreContent "<h2>Meghajtók:</h2>"
$loServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10  |ConvertTo-Html -Property Name,DisplayName,State -Fragment -PreContent "<h2>Futó szolgáltatások:</h2>"

$loselectedNumbers =@(21,22,24,25,39,40)
$loEvents = Get-WinEvent -LogName "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -in $loselectedNumbers)}
$loResults = Foreach ($loEvent in $loEvents) {
    $loResult = "" | Select Message,User,TimeCreated, LevelDisplayName
    $loResult.TimeCreated = $loEvent.TimeCreated
    $loResult.LevelDisplayName = $loEvent.LevelDisplayName
    Foreach ($loMsgElement in ($loEvent.Message -split "`n")) {
        $loElement = $loMsgElement -split ":"
        If ($loElement[0] -like "User") {$loResult.User = $loElement[1].Trim(" ")}
        If ($loElement[0] -like "Remote Desktop Services*") {$loResult.Message = $loElement[1].Trim(" ")}
    }
    $loResult
}
$lologs = $loResults | ConvertTo-Html -Fragment -PreContent "<h2>Log bejegyzések:</h2>"
$loReport = ConvertTo-HTML -Body "$lodate $loComputerName $loOSinfo $loProcessInfo $loBiosInfo $loDiscInfo $loServicesInfo $lologs" -Title "Házi feladat core szerver" -Head $loheader -PostContent "<h2>Készítette: Gerbovics Tamás<h2>"

$loReport | Out-File -FilePath 'C:\inetpub\wwwroot\index.html' 
}

#*********************** második feladat ***************************

#kiinduló fájl másolása
Copy C:\Share2\mappak.csv '\\10.0.0.7\c$\Peldashare\'

#budpaesti szerver
$officefoldersbp = Import-Csv C:\Share2\mappak.csv
$officefoldersbp | ForEach-Object { New-Item -ItemType Directory -path $_.name}

#londoni szerver
Invoke-Command -Session $londonSession -ScriptBlock {
$officefolderslo = Import-Csv C:\Peldashare\mappak.csv
$officefolderslo | ForEach-Object { New-Item -ItemType Directory -path $_.name}
}
