<#
.SYNOPSIS
  Instaleaza pe serverul Firebird sarcina de backup nbackup la fiecare 15 minute.

.DESCRIPTION
  - cere parola utilizatorului Firebird si o scrie in nbackup-sw.pwd (langa
    scripturi), cu acces doar pentru SYSTEM si Administrators;
  - inregistreaza in Task Scheduler sarcina care ruleaza nbackup-sw.ps1 zilnic
    de la 00:00, repetat la 15 minute, ca SYSTEM (are acces la fisierul bazei);
  - o rulare noua nu porneste cat timp cea precedenta (ex. L0) inca merge.

  Rulati ca Administrator, din folderul in care stau scripturile pe server
  (ex. C:\Scripts\nbackup).

.EXAMPLE
  .\install-nbackup-task.ps1 -Database d:\data\sw5.fdb -BackupRoot E:\Backup\nbackup\SW
#>
[CmdletBinding()]
param(
    [string]$Database    = 'd:\data\sw5.fdb',
    [string]$BackupRoot  = 'E:\Backup\nbackup\SW',
    [string]$FirebirdDir = 'C:\Program Files\Firebird\Firebird_5_0',
    [string]$User        = 'SYSDBA',
    [string]$TaskName    = 'Firebird nbackup SW',
    # Parametri suplimentari pentru nbackup-sw.ps1, ex. '-KeepChains 3 -L0Hour 2'
    [string]$ExtraArgs   = '',
    # Nu cere parola din nou daca fisierul exista deja
    [switch]$KeepPassword
)

$ErrorActionPreference = 'Stop'

$principal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Rulati scriptul ca Administrator.'
}

$script  = Join-Path $PSScriptRoot 'nbackup-sw.ps1'
$pwdFile = Join-Path $PSScriptRoot 'nbackup-sw.pwd'
if (-not (Test-Path $script)) { throw "Nu gasesc $script" }
if (-not (Test-Path (Join-Path $FirebirdDir 'nbackup.exe'))) { throw "Nu gasesc nbackup.exe in $FirebirdDir" }
if (-not (Test-Path $Database)) { Write-Warning "Nu gasesc fisierul $Database pe acest calculator - nbackup trebuie rulat pe serverul bazei." }

# ---- parola
if (-not ($KeepPassword -and (Test-Path $pwdFile))) {
    $sec = Read-Host "Parola Firebird pentru $User" -AsSecureString
    $plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec))
    if (-not $plain) { throw 'Parola goala.' }
    [System.IO.File]::WriteAllText($pwdFile, $plain, (New-Object System.Text.ASCIIEncoding))
    $plain = $null

    # ACL: fara mostenire, doar SYSTEM si Administrators
    $acl = New-Object System.Security.AccessControl.FileSecurity
    $acl.SetAccessRuleProtection($true, $false)
    foreach ($sid in 'S-1-5-18', 'S-1-5-32-544') {
        $id = (New-Object System.Security.Principal.SecurityIdentifier($sid)).Translate([System.Security.Principal.NTAccount])
        $acl.AddAccessRule((New-Object System.Security.AccessControl.FileSystemAccessRule($id, 'FullControl', 'Allow')))
    }
    Set-Acl -Path $pwdFile -AclObject $acl
    Write-Host "Parola salvata in $pwdFile (acces: SYSTEM, Administrators)."
}

# ---- verificare: o rulare de proba (doar alege nivelul, fara backup)
$argLine = "-NoProfile -ExecutionPolicy Bypass -File `"$script`" -Database `"$Database`" -BackupRoot `"$BackupRoot`" -FirebirdDir `"$FirebirdDir`" -User `"$User`""
if ($ExtraArgs) { $argLine += " $ExtraArgs" }
Write-Host 'Rulare de proba (-DryRun)...'
$p = Start-Process -FilePath 'powershell.exe' -ArgumentList "$argLine -DryRun" -NoNewWindow -Wait -PassThru
if ($p.ExitCode -ne 0) { throw "Rularea de proba a esuat (cod $($p.ExitCode)) - vezi jurnalul din $BackupRoot\logs." }

# ---- sarcina: zilnic 00:00, repetare la 15 min timp de o zi
$action  = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $argLine -WorkingDirectory $PSScriptRoot
$trigger = New-ScheduledTaskTrigger -Daily -At '00:00'
$rep     = New-ScheduledTaskTrigger -Once -At '00:00' -RepetitionInterval (New-TimeSpan -Minutes 15) -RepetitionDuration (New-TimeSpan -Days 1)
$trigger.Repetition = $rep.Repetition
$settings = New-ScheduledTaskSettingsSet -MultipleInstances IgnoreNew -StartWhenAvailable `
              -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Hours 20)
$taskPrincipal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings `
    -Principal $taskPrincipal -Description 'Backup incremental Firebird cu nbackup: L0 saptaminal, L1 zilnic, L2 orar, L3 la 15 min.' -Force | Out-Null

Write-Host "Sarcina '$TaskName' e inregistrata (la fiecare 15 minute, ca SYSTEM)."
Write-Host "Prima rulare fara lant face L0 complet. Pornire imediata: Start-ScheduledTask -TaskName '$TaskName'"
Write-Host "Jurnal: $BackupRoot\logs"
