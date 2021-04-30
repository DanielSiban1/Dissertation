$ErrorActionPreference = "silentlycontinue"
$MalEvent = "ipconfig"
get-winevent -Path C:\Windows\System32\winevt\Logs\Microsoft-Windows-Sysmon%4Operational.evtx | format-list -property * | Out-File "C:\Users\test\Downloads\Sysmon\Output.txt"
$test = Get-Content "C:\Users\test\Downloads\Sysmon\Output.txt"
if ($test -match $MalEvent){
    &Sysmon64.exe -c C:\Users\test\Downloads\Sysmon\sysmonconfig.xml  
} else {}

Get-ScheduledTask -TaskName "TaskCheck" -ErrorAction SilentlyContinue -OutVariable task
& Set-ExecutionPolicy Bypass

if (!$task) {
    schtasks /create /tn TaskCheck /NP /tr "PowerShell.exe -windowstyle Hidden -File 'C:\Users\test\Downloads\Sysmon\SysmonChanger.ps1'" /sc minute
}
else {}
    
    
    
