$selectedNumbers=@(21,22,24,25,39,40)
$serverlista = 'demosrv2core'

#event lekérdezés
$Events = Get-WinEvent -logname "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -in $selectedNumbers)} 
$Events2 = Invoke-Command -Credential $credcore -ComputerName $serverlista -ScriptBlock {
    $selectedNumbers=@(21,22,24,25,39,40)
    Get-WinEvent -logname "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational" | where {($_.Id -in $selectedNumbers)}
}

$Results = Foreach ($Event in $Events) {
  $Result = "" | Select Message,User,TimeCreated, Id, PsComputerName
  $Result.TimeCreated = $Event.TimeCreated
  $Result.Id = $Event.Id
  $Result.PsComputerName = $env:COMPUTERNAME
  Foreach ($MsgElement in ($Event.Message -split "`n")) {
    $Element = $MsgElement -split ":"
    If ($Element[0] -like "user") {$Result.User = $Element[1].Trim(" ")}
    If ($Element[0] -like "Remote Desktop Services*") {$Result.Message = $Element[1].Trim(" ")}
  }
  $Result
} 
#$Results
#| Select Message,User,TimeCreated,Id |Out-GridView 
#$Results | Select Message,User,TimeCreated  | Export-Csv .\TerminalSessions.csv -NoType -Encoding UTF8

$Results += Foreach ($Event in $Events2) {
  #$Result = "" | Select Message,User,TimeCreated, Id,  PsComputerName
  $Result.TimeCreated = $Event.TimeCreated
  $Result.Id = $Event.Id
  $Result.PsComputerName = $Event.PsComputerName
  Foreach ($MsgElement in ($Event.Message -split "`n")) {
    $Element = $MsgElement -split ":"
    If ($Element[0] -like "user") {$Result.User = $Element[1].Trim(" ")}
    If ($Element[0] -like "Remote Desktop Services*") {$Result.Message = $Element[1].Trim(" ")}
  }
  $Result
} 
$Results | Select Message,User,TimeCreated,Id, PsComputerName |Out-GridView 
#$Results | Select Message,User,TimeCreated  | Export-Csv .\TerminalSessions.csv -NoType -Encoding UTF8