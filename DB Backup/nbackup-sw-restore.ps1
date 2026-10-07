<#
.SYNOPSIS
  Restaureaza baza din backup-urile facute de nbackup-sw.ps1, la un moment dat.

.DESCRIPTION
  Alege lantul care contine momentul cerut si, in el, fisierele necesare:
  cel mai recent fisier <= moment (de orice nivel) plus bazele lui
  (L(n-1) anterior, recursiv pana la L0), apoi ruleaza
    nbackup -R <Target> L0 [L1 [L2 [L3]]]
  Baza restaurata e un fisier NOU (Target nu trebuie sa existe) - nu se
  restaureaza peste baza de lucru. Dupa verificare, baza se poate pune in
  locul celei stricate cu serverul oprit sau se conecteaza sub alt alias.

.EXAMPLE
  .\nbackup-sw-restore.ps1 -List
  .\nbackup-sw-restore.ps1 -Target F:\restore\sw5.fdb
  .\nbackup-sw-restore.ps1 -Target F:\restore\sw5.fdb -PointInTime '2026-09-25 14:40'
#>
[CmdletBinding()]
param(
    # Fisierul bazei restaurate (nou)
    [string]$Target,
    [string]$BackupRoot  = 'E:\Backup\nbackup\SW',
    [string]$FirebirdDir = 'C:\Program Files\Firebird\Firebird_5_0',
    # Momentul la care se restaureaza (implicit - ultimul backup)
    [datetime]$PointInTime = [datetime]::MaxValue,
    # Doar afiseaza fisierele alese
    [switch]$List
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 2
$FileRegex = '_L(?<lvl>[0-3])_(?<ts>\d{8}_\d{6})\.nbk$'

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

if (-not $List -and -not $Target) { throw 'Indicati -Target (fisierul bazei restaurate) sau -List.' }

# Lantul: cel mai nou folder care are L0 facut pana la momentul cerut
$chain = $null
foreach ($dir in (Get-ChildItem -Path $BackupRoot -Directory | Where-Object { $_.Name -match '^\d{8}_\d{4}$' } | Sort-Object Name -Descending)) {
    $files = @(Get-ChainFiles $dir.FullName)
    $l0 = @($files | Where-Object { $_.Level -eq 0 -and $_.Time -le $PointInTime })
    if ($l0.Count -gt 0) { $chain = $dir; break }
}
if (-not $chain) { throw "Nu exista niciun L0 pana la $PointInTime in $BackupRoot" }

# Ultimul fisier <= moment, apoi bazele lui pana la L0
$avail = @($files | Where-Object { $_.Time -le $PointInTime })
$cur = $avail[-1]
$sel = @($cur)
while ($cur.Level -gt 0) {
    $prev = @($avail | Where-Object { $_.Level -eq ($cur.Level - 1) -and $_.Time -lt $cur.Time })
    if ($prev.Count -eq 0) { throw "Lant incomplet: lipseste baza L$($cur.Level - 1) pentru $($cur.Path)" }
    $cur = $prev[-1]
    $sel = @($cur) + $sel
}

Write-Host "Lant: $($chain.FullName)"
Write-Host ("Starea bazei restaurate: {0:yyyy-MM-dd HH:mm:ss} (inceputul ultimului backup ales)" -f $sel[-1].Time)
$sel | ForEach-Object { Write-Host ("  L{0}  {1:yyyy-MM-dd HH:mm:ss}  {2,12:N1} MB  {3}" -f $_.Level, $_.Time, ($_.Size / 1MB), (Split-Path $_.Path -Leaf)) }
if ($List) { exit 0 }

if (Test-Path $Target) { throw "Fisierul $Target exista deja - alegeti un fisier nou." }
$targetDir = Split-Path $Target -Parent
if ($targetDir -and -not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }

$exe = Join-Path $FirebirdDir 'nbackup.exe'
$args2 = @('-R', $Target) + @($sel | ForEach-Object { $_.Path })
Write-Host "Restaurez in $Target ..."
& $exe @args2
if ($LASTEXITCODE -ne 0) { throw "nbackup -R a esuat (cod $LASTEXITCODE)" }
Write-Host 'Gata. Verificati baza (ex. gfix -v -full) inainte de a o pune in productie.'
