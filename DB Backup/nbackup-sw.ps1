<#
.SYNOPSIS
  Backup incremental Firebird cu nbackup, fara a bloca baza (ramane online).

.DESCRIPTION
  Se ruleaza PE SERVERUL Firebird (nbackup citeste direct fisierul bazei),
  din Task Scheduler, la fiecare 15 minute (vezi install-nbackup-task.ps1).
  La fiecare rulare scriptul alege singur nivelul:

    L0 - o data pe saptamina (L0Weekday, ora L0Hour) sau daca lipseste lantul
    L1 - o data pe zi (ora L1Hour)
    L2 - o data pe ora
    L3 - in rest (la 15 minute)

  Nivelul efectiv nu depaseste niciodata "ultimul nivel + 1": dupa L0 urmeaza
  L1, dupa L1 urmeaza L2 etc. Astfel fiecare fisier Ln se bazeaza pe cel mai
  recent fisier L(n-1) din acelasi lant (asa cum face nbackup din istoric),
  iar lantul de pe disc corespunde exact cu RDB$BACKUP_HISTORY.

  nbackup -B pune baza in modul "backup" (ALTER DATABASE BEGIN BACKUP):
  scrierile utilizatorilor merg in fisierul .delta, fisierul principal e
  citit fara blocare, iar la final delta se imbina online. Nimeni nu este
  deconectat si nimic nu asteapta.

  Structura pe disc:
    <BackupRoot>\<yyyyMMdd_HHmm>\<db>_L0_<yyyyMMdd_HHmmss>.nbk   (un folder = un lant saptaminal)
    <BackupRoot>\<yyyyMMdd_HHmm>\<db>_L1_...nbk, _L2_..., _L3_...
    <BackupRoot>\logs\nbackup_<yyyy-MM>.log

  Restaurarea: nbackup-sw-restore.ps1 (alege singur fisierele pentru un moment dat).

  NU rulati alte nbackup -B pe aceeasi baza (manual sau din alt instrument):
  nbackup isi alege baza incrementului din istoricul din baza si lantul
  acestui script s-ar rupe.

.EXAMPLE
  powershell -NoProfile -ExecutionPolicy Bypass -File nbackup-sw.ps1
  powershell -NoProfile -ExecutionPolicy Bypass -File nbackup-sw.ps1 -DryRun
  powershell -NoProfile -ExecutionPolicy Bypass -File nbackup-sw.ps1 -Level 0
#>
[CmdletBinding()]
param(
    # Calea locala a bazei pe server (sau alias din databases.conf)
    [string]$Database    = 'd:\data\sw5.fdb',
    # Folderul backup-urilor - de preferat pe alt disc fizic decat baza
    [string]$BackupRoot  = 'E:\Backup\nbackup\SW',
    [string]$FirebirdDir = 'C:\Program Files\Firebird\Firebird_5_0',
    [string]$User        = 'SYSDBA',
    # Fisier cu parola (creat de install-nbackup-task.ps1); daca lipseste - $env:ISC_PASSWORD
    [string]$PasswordFile = (Join-Path $PSScriptRoot 'nbackup-sw.pwd'),

    [ValidateSet('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday')]
    [string]$L0Weekday   = 'Sunday',
    [ValidateRange(0,23)][int]$L0Hour = 1,
    [ValidateRange(0,23)][int]$L1Hour = 1,

    # Retentie: cate lanturi saptaminale (L0 + incrementele lui) se pastreaza
    [ValidateRange(1,100)][int]$KeepChains  = 2,
    # L2 mai vechi de atatea zile si L3 mai vechi de atatea ore se sterg
    # (doar daca nu sunt baza unui fisier pastrat)
    [ValidateRange(1,1000)][int]$KeepL2Days  = 7,
    [ValidateRange(1,10000)][int]$KeepL3Hours = 48,
    [ValidateRange(1,3650)][int]$LogKeepDays = 90,

    # Daca baza sta in modul backup (stalled) fara ca nbackup sa ruleze mai mult
    # de atatea minute, se face nbackup -N (END BACKUP, imbina delta online).
    # 0 = doar se raporteaza, nu se atinge.
    [ValidateRange(0,100000)][int]$StalledMinutes = 60,

    # L0 porneste doar daca pe discul tinta e liber >= marimea bazei * factor
    [double]$L0SpaceFactor = 1.1,
    # Direct I/O: citirea bazei nu mai umple cache-ul de fisiere al Windows
    [ValidateSet('ON','OFF')][string]$DirectIO = 'ON',

    # -1 = automat; 0..3 = forteaza nivelul (se respecta totusi "ultimul nivel + 1")
    [ValidateRange(-1,3)][int]$Level = -1,
    # Doar afiseaza ce nivel ar face, fara backup
    [switch]$DryRun,
    # Pentru teste: ora "curenta" simulata
    [datetime]$Now = (Get-Date)
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2

$NBackupExe = Join-Path $FirebirdDir 'nbackup.exe'
$IsqlExe    = Join-Path $FirebirdDir 'isql.exe'
$DbTag      = [System.IO.Path]::GetFileNameWithoutExtension($Database) -replace '[^A-Za-z0-9_-]', '_'
$LogDir     = Join-Path $BackupRoot 'logs'
$StalledFile = Join-Path $BackupRoot 'stalled.since'
$FileRegex  = '_L(?<lvl>[0-3])_(?<ts>\d{8}_\d{6})\.nbk$'
# Conectare explicita prin serverul local (TCP loopback): fara prefix, clientul
# poate cadea pe providerul embedded. nbackup citeste oricum fisierul direct.
$DbConn = if ($Database -match '^[A-Za-z]:\\' -or $Database -notmatch ':') { "localhost:$Database" } else { $Database }

# ---------------------------------------------------------------- log

function Write-Log([string]$Msg, [string]$Kind = 'INFO') {
    $line = '{0:yyyy-MM-dd HH:mm:ss} [{1}] {2}' -f (Get-Date), $Kind, $Msg
    Write-Host $line
    try {
        if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
        Add-Content -Path (Join-Path $LogDir ('nbackup_{0:yyyy-MM}.log' -f (Get-Date))) -Value $line -Encoding UTF8
    } catch { }
}

# ---------------------------------------------------------------- lanturi

function Get-Chains {
    # Lanturile valide (au L0 terminat), de la cel mai vechi la cel mai nou
    if (-not (Test-Path $BackupRoot)) { return @() }
    $res = @()
    foreach ($dir in (Get-ChildItem -Path $BackupRoot -Directory | Where-Object { $_.Name -match '^\d{8}_\d{4}$' } | Sort-Object Name)) {
        $files = @(Get-ChainFiles $dir.FullName)
        if (@($files | Where-Object { $_.Level -eq 0 }).Count -gt 0) {
            $res += [pscustomobject]@{ Name = $dir.Name; Path = $dir.FullName; Files = $files }
        }
    }
    return $res
}

function Get-ChainFiles([string]$ChainPath) {
    $res = @()
    foreach ($f in (Get-ChildItem -Path $ChainPath -File -Filter '*.nbk')) {
        if ($f.Name -match $FileRegex) {
            $res += [pscustomobject]@{
                Level = [int]$Matches['lvl']
                Time  = [datetime]::ParseExact($Matches['ts'], 'yyyyMMdd_HHmmss', $null)
                Path  = $f.FullName
                Size  = $f.Length
            }
        }
    }
    return @($res | Sort-Object Time)
}

function Get-Ancestors($Files, $File) {
    # Baza unui Ln = cel mai recent L(n-1) anterior lui, recursiv pana la L0
    $res = @()
    $cur = $File
    while ($cur.Level -gt 0) {
        $prev = $Files | Where-Object { $_.Level -eq ($cur.Level - 1) -and $_.Time -lt $cur.Time } |
                Sort-Object Time | Select-Object -Last 1
        if (-not $prev) { break }
        $res += $prev
        $cur = $prev
    }
    return $res
}

# ---------------------------------------------------------------- alegerea nivelului

function Get-LastTime($Files, [int]$MaxLevel) {
    $f = $Files | Where-Object { $_.Level -le $MaxLevel } | Sort-Object Time | Select-Object -Last 1
    if ($f) { return $f.Time } else { return [datetime]::MinValue }
}

function Get-DesiredLevel($Files, [bool]$SkipL0) {
    $wd = [int][System.DayOfWeek]$L0Weekday
    $l0Boundary = $Now.Date.AddDays(-((([int]$Now.DayOfWeek) - $wd + 7) % 7)).AddHours($L0Hour)
    if ($l0Boundary -gt $Now) { $l0Boundary = $l0Boundary.AddDays(-7) }
    $dayBoundary = $Now.Date.AddHours($L1Hour)
    if ($dayBoundary -gt $Now) { $dayBoundary = $dayBoundary.AddDays(-1) }
    $hourBoundary = $Now.Date.AddHours($Now.Hour)

    if (-not $SkipL0 -and (Get-LastTime $Files 0) -lt $l0Boundary) { return 0 }
    if ((Get-LastTime $Files 1) -lt $dayBoundary)  { return 1 }
    if ((Get-LastTime $Files 2) -lt $hourBoundary) { return 2 }
    return 3
}

# ---------------------------------------------------------------- procese externe

function Format-Arg([string]$a) {
    if ($a -match '[\s"]') { return '"' + ($a -replace '"', '\"') + '"' }
    return $a
}

function Invoke-Tool([string]$Exe, [string[]]$Arguments, [switch]$LowPriority) {
    $out = [System.IO.Path]::GetTempFileName()
    $err = [System.IO.Path]::GetTempFileName()
    try {
        $p = Start-Process -FilePath $Exe -ArgumentList (($Arguments | ForEach-Object { Format-Arg $_ }) -join ' ') `
                -NoNewWindow -PassThru -RedirectStandardOutput $out -RedirectStandardError $err
        $null = $p.Handle   # altfel ExitCode ramane $null in PowerShell 5.1
        if ($LowPriority) { try { $p.PriorityClass = 'BelowNormal' } catch { } }
        $p.WaitForExit()
        $text = ((Get-Content $out -Raw) + (Get-Content $err -Raw))
        if ($null -eq $text) { $text = '' }
        return [pscustomobject]@{ ExitCode = $p.ExitCode; Output = $text.Trim() }
    } finally {
        Remove-Item $out, $err -Force -ErrorAction SilentlyContinue
    }
}

function Get-BackupState {
    # MON$BACKUP_STATE: 0 normal, 1 stalled (in backup, delta creste), 2 merge
    $q = [System.IO.Path]::GetTempFileName()
    try {
        Set-Content -Path $q -Value 'set list on; select mon$backup_state as BS from mon$database;' -Encoding ASCII
        $r = Invoke-Tool $IsqlExe @('-q', '-nod', '-i', $q, $DbConn)
        if ($r.Output -match 'BS\s+(\d)') { return [int]$Matches[1] }
        throw "Nu pot citi MON`$BACKUP_STATE: $($r.Output)"
    } finally {
        Remove-Item $q -Force -ErrorAction SilentlyContinue
    }
}

function Get-FreeBytes([string]$Path) {
    try {
        $root = [System.IO.Path]::GetPathRoot((Resolve-Path $Path).ProviderPath)
        if ($root -like '\\*') { return -1 }   # UNC - nu se verifica
        return (New-Object System.IO.DriveInfo($root)).AvailableFreeSpace
    } catch { return -1 }
}

# ---------------------------------------------------------------- retentie

function Invoke-Retention {
    $chains = @(Get-Chains)

    # 1) lanturile vechi - doar cand exista mai multe decat KeepChains
    if ($chains.Count -gt $KeepChains) {
        foreach ($c in $chains[0..($chains.Count - $KeepChains - 1)]) {
            Write-Log "Retentie: sterg lantul vechi $($c.Name)"
            Remove-Item -Path $c.Path -Recurse -Force
        }
        $chains = @(Get-Chains)
    }

    # 2) in lanturile ramase: L3/L2 vechi, dar niciodata baza unui fisier pastrat
    for ($i = 0; $i -lt $chains.Count; $i++) {
        $files = $chains[$i].Files
        if ($files.Count -eq 0) { continue }
        $keep = @{}
        foreach ($f in $files) {
            $ageH = ($Now - $f.Time).TotalHours
            $k = ($f.Level -le 1) -or
                 ($f.Level -eq 2 -and $ageH -lt $KeepL2Days * 24) -or
                 ($f.Level -eq 3 -and $ageH -lt $KeepL3Hours)
            if ($k) { $keep[$f.Path] = $true }
        }
        if ($i -eq $chains.Count - 1) { $keep[$files[-1].Path] = $true }   # ultimul fisier al lantului curent
        foreach ($f in @($files | Where-Object { $keep.ContainsKey($_.Path) })) {
            foreach ($a in (Get-Ancestors $files $f)) { $keep[$a.Path] = $true }
        }
        $del = @($files | Where-Object { -not $keep.ContainsKey($_.Path) })
        if ($del.Count -gt 0) {
            Write-Log ("Retentie: sterg {0} incremente vechi din {1} ({2:N1} MB)" -f $del.Count, $chains[$i].Name, (($del | Measure-Object Size -Sum).Sum / 1MB))
            $del | ForEach-Object { Remove-Item -Path $_.Path -Force }
        }
    }

    # 3) jurnale vechi
    if (Test-Path $LogDir) {
        Get-ChildItem -Path $LogDir -Filter 'nbackup_*.log' |
            Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$LogKeepDays) } |
            Remove-Item -Force
    }
}

function Remove-Leftovers {
    # Resturi dupa o rulare intrerupta: *.part si foldere de lant fara L0
    if (-not (Test-Path $BackupRoot)) { return }
    Get-ChildItem -Path $BackupRoot -Recurse -File -Filter '*.part' | ForEach-Object {
        Write-Log "Sterg fisierul neterminat $($_.FullName)" 'WARN'
        Remove-Item $_.FullName -Force
    }
    Get-ChildItem -Path $BackupRoot -Directory | Where-Object { $_.Name -match '^\d{8}_\d{4}$' } | ForEach-Object {
        if (@(Get-ChainFiles $_.FullName | Where-Object { $_.Level -eq 0 }).Count -eq 0 -and
            @(Get-ChildItem $_.FullName -Force).Count -eq 0) {
            Remove-Item $_.FullName -Force
        }
    }
}

# ---------------------------------------------------------------- main

$mutexName = 'Global\nbackup_' + (($Database.ToLowerInvariant()) -replace '[^a-z0-9]', '_')
$mutex = New-Object System.Threading.Mutex($false, $mutexName)
$owned = $false
try {
    try { $owned = $mutex.WaitOne(0) } catch [System.Threading.AbandonedMutexException] { $owned = $true }
    if (-not $owned) {
        Write-Log 'Un backup anterior inca ruleaza - sar peste aceasta rulare.'
        exit 0
    }

    if (-not (Test-Path $NBackupExe)) { throw "Nu gasesc $NBackupExe" }
    if (-not (Test-Path $BackupRoot)) { New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null }

    # Credentiale: ISC_USER/ISC_PASSWORD le citesc atat nbackup cat si isql,
    # iar parola nu apare in linia de comanda a proceselor.
    $env:ISC_USER = $User
    if (Test-Path $PasswordFile) {
        $env:ISC_PASSWORD = (Get-Content -Path $PasswordFile -Raw).Trim()
    } elseif (-not $env:ISC_PASSWORD) {
        throw "Lipseste parola: nici $PasswordFile, nici variabila ISC_PASSWORD"
    }

    # Un nbackup pornit de altcineva (nu de noi - noi tinem mutex-ul)
    if (Get-Process -Name 'nbackup' -ErrorAction SilentlyContinue) {
        Write-Log 'Ruleaza deja un nbackup.exe pornit din afara scriptului - sar peste.' 'WARN'
        exit 0
    }

    # Baza ramasa in modul backup dupa o rulare intrerupta (delta creste la nesfarsit)
    $state = Get-BackupState
    if ($state -eq 2) {
        Write-Log 'Baza imbina acum fisierul delta (merge) - sar peste aceasta rulare.' 'WARN'
        exit 0
    }
    if ($state -eq 1) {
        if (-not (Test-Path $StalledFile)) { Set-Content -Path $StalledFile -Value (Get-Date).ToString('o') -Encoding ASCII }
        $since = [datetime]::Parse((Get-Content $StalledFile -Raw).Trim())
        $min = [int]((Get-Date) - $since).TotalMinutes
        if ($StalledMinutes -gt 0 -and $min -ge $StalledMinutes) {
            Write-Log "Baza e in modul backup (stalled) de $min min fara nbackup activ - nbackup -N (END BACKUP)." 'WARN'
            if (-not $DryRun) {
                $r = Invoke-Tool $NBackupExe @('-N', $DbConn)
                if ($r.ExitCode -ne 0) { throw "nbackup -N a esuat ($($r.ExitCode)): $($r.Output)" }
                Remove-Item $StalledFile -Force -ErrorAction SilentlyContinue
            }
        } else {
            Write-Log "Baza e in modul backup (stalled) de $min min (nbackup -L extern?) - sar peste; dupa $StalledMinutes min se deblocheaza automat." 'WARN'
        }
        exit 0
    }
    Remove-Item $StalledFile -Force -ErrorAction SilentlyContinue

    if (-not $DryRun) { Remove-Leftovers }

    # ---- alegerea nivelului
    $chains = @(Get-Chains)
    $cur = if ($chains.Count -gt 0) { $chains[-1] } else { $null }
    $files = @(if ($cur) { $cur.Files })

    if ($Level -ge 0) { $desired = $Level } else { $desired = Get-DesiredLevel $files $false }

    if ($desired -eq 0 -and (Test-Path $Database)) {
        $need = [int64]((Get-Item $Database).Length * $L0SpaceFactor)
        $free = Get-FreeBytes $BackupRoot
        if ($free -ge 0 -and $free -lt $need) {
            $msg = "Spatiu insuficient pentru L0: liber {0:N1} GB, necesar {1:N1} GB." -f ($free / 1GB), ($need / 1GB)
            if (-not $cur) { throw $msg }
            Write-Log "$msg Continui lantul curent cu incremente." 'ERROR'
            $desired = Get-DesiredLevel $files $true
            if ($desired -eq 0) { $desired = 1 }
            $script:L0Failed = $true
        }
    }

    $lvl = $desired
    if ($lvl -gt 0) {
        if (-not $cur) { $lvl = 0 }
        else { $lvl = [Math]::Min($lvl, $files[-1].Level + 1) }
    }

    $stamp = $Now.ToString('yyyyMMdd_HHmmss')
    if ($lvl -eq 0) {
        $chainPath = Join-Path $BackupRoot $Now.ToString('yyyyMMdd_HHmm')
    } else {
        $chainPath = $cur.Path
    }
    $target = Join-Path $chainPath ('{0}_L{1}_{2}.nbk' -f $DbTag, $lvl, $stamp)

    if ($DryRun) {
        Write-Log ("DryRun: nivel dorit L{0}, efectiv L{1} -> {2}" -f $desired, $lvl, $target)
        exit 0
    }
    if (Test-Path $target) { throw "Fisierul exista deja: $target" }
    if (-not (Test-Path $chainPath)) { New-Item -ItemType Directory -Path $chainPath -Force | Out-Null }

    # ---- backup
    $part = "$target.part"
    $nbArgs = @('-B', "$lvl", $DbConn, $part, '-D', $DirectIO, '-NODBTRIGGERS')
    if ($lvl -eq 0) {
        # Istoricul din RDB$BACKUP_HISTORY: se pastreaza cat acopera lanturile retinute
        $nbArgs += @('-CLEAN_HISTORY', '-KEEP', "$($KeepChains * 7 + 2)", 'DAYS')
    }
    Write-Log "Pornesc L$lvl -> $target"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $r = Invoke-Tool $NBackupExe $nbArgs -LowPriority
    $sw.Stop()

    if ($r.ExitCode -ne 0 -or -not (Test-Path $part)) {
        Remove-Item $part -Force -ErrorAction SilentlyContinue
        if ($lvl -eq 0 -and @(Get-ChildItem $chainPath -Force).Count -eq 0) { Remove-Item $chainPath -Force }
        throw "nbackup L$lvl a esuat (cod $($r.ExitCode)): $($r.Output)"
    }
    Rename-Item -Path $part -NewName ([System.IO.Path]::GetFileName($target))
    $size = (Get-Item $target).Length
    Write-Log ("OK L{0}: {1:N1} MB in {2:N0} s{3}" -f $lvl, ($size / 1MB), $sw.Elapsed.TotalSeconds,
               $(if ($r.Output) { " | $($r.Output -replace '\s+', ' ')" } else { '' }))

    Invoke-Retention
    if (Test-Path variable:script:L0Failed) { exit 1 }   # task-ul sa arate eroarea
    exit 0
}
catch {
    Write-Log $_.Exception.Message 'ERROR'
    exit 1
}
finally {
    if ($owned) { $mutex.ReleaseMutex() }
    $mutex.Dispose()
}
