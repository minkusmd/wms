<#
.SYNOPSIS
  Inregistreaza in Task Scheduler importul automat al pricelisturilor prin API, de 2 ori pe zi.

.DESCRIPTION
  Sarcina ruleaza zilnic la 09:00 si la 14:00:
      WMSParsers.exe /auto /parser:pricelists [ExtraArgs]
  adica, in paralel (fiecare furnizor in firul lui):
      Accent 198, DMLink 229466, Olis Grup 251465, NexDistribution 275640, Triomac 209280
      -> pricelist nou + cele 4 reevaluari (produse noi, vechi, preturi marite, scazute),
         inchise ca in WMS (CLOSE_REEVALUARE) + imaginile nedescarcate (DMLink, Nex).

  - ruleaza ca SYSTEM (nu cere utilizator logat); calculatorul are nevoie de acces la serverul
    Firebird si la internet, iar fbclient.dll trebuie sa fie linga WMSParsers.exe sau in PATH;
  - o rulare noua nu porneste cit timp cea precedenta inca merge; limita: 3 ore;
  - jurnalele: <dosarul exe>\logs\<job>_YYYYMMDD.log si wmsparsers_YYYYMMDD.log;
  - cu -TestRun face intii o rulare de proba cu /reevaluare:test (pricelisturile se creeaza,
    reevaluarile se fac si se anuleaza) si se opreste daca ea esueaza.

  Rulati ca Administrator.

.EXAMPLE
  .\install-pricelist-task.ps1 -Exe 'C:\WMS\WMSParsers.exe'
  .\install-pricelist-task.ps1 -Exe 'C:\WMS\WMSParsers.exe' -ExtraArgs '/firma:307225 /user:204' -TestRun
#>
[CmdletBinding()]
param(
    [string]$Exe       = (Join-Path $PSScriptRoot '..\exe\WMSParsers.exe'),
    [string]$TaskName  = 'WMSParsers - pricelisturi API',
    [string[]]$Times   = @('09:00', '14:00'),
    # parametri suplimentari pentru WMSParsers.exe, ex. '/firma:307225 /user:204 /server:192.168.106.254'
    [string]$ExtraArgs = '',
    [switch]$TestRun
)

$ErrorActionPreference = 'Stop'

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Rulati scriptul ca Administrator.'
}

$Exe = (Resolve-Path $Exe).Path
$exeDir = Split-Path $Exe -Parent
$argLine = '/auto /parser:pricelists'
if ($ExtraArgs) { $argLine += " $ExtraArgs" }

if ($TestRun) {
    Write-Host "Rulare de proba: $Exe $argLine /reevaluare:test ..."
    $p = Start-Process -FilePath $Exe -ArgumentList "$argLine /reevaluare:test" -WorkingDirectory $exeDir -Wait -PassThru
    # 0 = ok, 2 = un site a raspuns suspect (doar parserele de pret de pe site-uri)
    if (($p.ExitCode -ne 0) -and ($p.ExitCode -ne 2)) {
        throw "Rularea de proba a esuat (cod $($p.ExitCode)) - vezi jurnalele din $exeDir\logs."
    }
    Write-Host 'Rularea de proba a mers.'
}

$action   = New-ScheduledTaskAction -Execute $Exe -Argument $argLine -WorkingDirectory $exeDir
$triggers = foreach ($t in $Times) { New-ScheduledTaskTrigger -Daily -At $t }
$settings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -StartWhenAvailable `
              -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Hours 3)
$taskPrincipal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $triggers -Settings $settings `
    -Principal $taskPrincipal `
    -Description ('Pricelisturi API (Accent, DMLink, Olis Grup, NexDistribution, Triomac) + cele 4 reevaluari, ' +
                  'la ' + ($Times -join ' si ') + '. WMSParsers.exe ' + $argLine) -Force | Out-Null

Write-Host "Sarcina '$TaskName' inregistrata: zilnic la $($Times -join ', '), $Exe $argLine"
Write-Host "Jurnalele: $exeDir\logs"
