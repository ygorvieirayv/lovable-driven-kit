<#
  ldk-check.ps1 - deterministic validation for Lovable Driven Kit state.
  Usage:
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts\ldk-check.ps1 -Root .

  Validates ldk/ledger.md and proof reports. This script is intentionally ASCII-only.
#>

param(
  [string]$Root = "."
)

$ErrorActionPreference = "Stop"

$RootAbs = (Resolve-Path -LiteralPath $Root).Path
$script:Errors = 0
$script:Warnings = 0

function ErrorMsg($m) {
  Write-Host "ERROR $m"
  $script:Errors++
}

function WarnMsg($m) {
  Write-Host "WARN  $m"
  $script:Warnings++
}

function Rel($p) {
  $full = [System.IO.Path]::GetFullPath($p)
  if ($full.StartsWith($RootAbs)) {
    return $full.Substring($RootAbs.Length).TrimStart('\','/').Replace('\','/')
  }
  return $full.Replace('\','/')
}

function Text($p) {
  return Get-Content -Raw -Encoding UTF8 -LiteralPath $p
}

function CleanCell($v) {
  return ($v.Trim() -replace '^`|`$', '')
}

function RankProof($v) {
  switch ($v) {
    "P1" { return 1 }
    "P2" { return 2 }
    "P3" { return 3 }
    "P4" { return 4 }
    "none" { return 0 }
    default { return -1 }
  }
}

function Marker($text, $name) {
  $pattern = "(?m)^" + [regex]::Escape($name) + ":\s*(.+?)\s*$"
  $m = [regex]::Match($text, $pattern)
  if ($m.Success) { return $m.Groups[1].Value.Trim() }
  return $null
}

$allowedRisk = @("trivial", "baixo", "medio", "alto")
$allowedState = @("idea", "planned", "approved", "building", "proof-pending", "done", "partial", "blocked", "reopened")
$allowedProof = @("P1", "P2", "P3", "P4")
$allowedTaskState = @("backlog", "ready", "in-progress", "proof-pending", "done", "blocked")

$ledger = Join-Path $RootAbs "ldk\ledger.md"
if (-not (Test-Path -LiteralPath $ledger)) {
  ErrorMsg "missing ldk/ledger.md"
} else {
  foreach ($line in (Get-Content -Encoding UTF8 -LiteralPath $ledger)) {
    if ($line -notmatch '^\|') { continue }
    if ($line -match '^\|\s*(-+|ID)\s*\|') { continue }
    $cells = $line.Trim() -split '\|'
    if ($cells.Count -lt 8) {
      ErrorMsg "ldk/ledger.md: malformed row: $line"
      continue
    }

    $id = CleanCell $cells[1]
    $feature = CleanCell $cells[2]
    $risk = CleanCell $cells[3]
    $state = CleanCell $cells[4]
    $required = CleanCell $cells[5]
    $evidence = CleanCell $cells[6]

    if ($id -notmatch '^F[A-Za-z0-9_-]+$') {
      ErrorMsg "ldk/ledger.md: row ID '$id' must start with F (example: F1)"
    }
    if ($allowedRisk -notcontains $risk) {
      ErrorMsg "ldk/ledger.md: ${id} has invalid Risk '$risk'"
    }
    if ($allowedState -notcontains $state) {
      ErrorMsg "ldk/ledger.md: ${id} has invalid State '$state'"
    }
    if ($allowedProof -notcontains $required) {
      ErrorMsg "ldk/ledger.md: ${id} has invalid Proof required '$required'"
    }

    if (-not [string]::IsNullOrWhiteSpace($evidence) -and $evidence -ne "-") {
      if ($evidence -match '(?i)(^|/)(plan|brief)\.md$') {
        ErrorMsg "ldk/ledger.md: ${id} Last evidence must not point to plan/brief '$evidence'"
      }
      if (@("idea", "planned", "approved", "building", "proof-pending") -contains $state) {
        ErrorMsg "ldk/ledger.md: ${id} state '$state' must keep Last evidence empty"
      }
    }

    if ($state -eq "done") {
      if ([string]::IsNullOrWhiteSpace($evidence) -or $evidence -eq "-") {
        ErrorMsg "ldk/ledger.md: ${id} is done but Last evidence is empty"
        continue
      }

      $proofPath = Join-Path $RootAbs ($evidence -replace '/', '\')
      if (-not (Test-Path -LiteralPath $proofPath)) {
        ErrorMsg "ldk/ledger.md: ${id} points to missing proof '$evidence'"
        continue
      }

      $proofText = Text $proofPath
      $status = Marker $proofText "Status"
      $proofRisk = Marker $proofText "Risk"
      $proofRequired = Marker $proofText "Proof level required"
      $achieved = Marker $proofText "Proof level achieved"

      if ($status -ne "DONE") {
        ErrorMsg "$(Rel $proofPath): ledger is done but proof Status is '$status'"
      }
      if ($proofRisk -and $proofRisk -ne $risk) {
        WarnMsg "$(Rel $proofPath): proof Risk '$proofRisk' differs from ledger '$risk'"
      }
      if ($proofRequired -ne $required) {
        ErrorMsg "$(Rel $proofPath): proof required '$proofRequired' differs from ledger '$required'"
      }
      if ((RankProof $achieved) -lt (RankProof $required)) {
        ErrorMsg "$(Rel $proofPath): achieved '$achieved' is lower than required '$required'"
      }
      if ($proofText -match '(?mi)^\s*-\s*AC[0-9]+:\s*not covered\b') {
        ErrorMsg "$(Rel $proofPath): DONE proof has not covered AC"
      }

      $selfChecksYes = @(
        "Required proof identified",
        "All essential AC covered",
        "Evidence exists for every covered AC",
        "Proof level achieved >= required"
      )
      foreach ($check in $selfChecksYes) {
        $pattern = "(?mi)^[ \t]*-[ \t]*" + [regex]::Escape($check) + ":[ \t]*yes\b"
        if ($proofText -notmatch $pattern) {
          ErrorMsg "$(Rel $proofPath): DONE proof self-check '$check' must be yes"
        }
      }
      if ($proofText -notmatch '(?mi)^[ \t]*-[ \t]*Critical errors known:[ \t]*no\b') {
        ErrorMsg "$(Rel $proofPath): DONE proof self-check 'Critical errors known' must be no"
      }
      if ($proofText -notmatch '(?mi)^[ \t]*-[ \t]*LDK engine drift detected:[ \t]*no\b') {
        ErrorMsg "$(Rel $proofPath): DONE proof self-check 'LDK engine drift detected' must be no"
      }

      $requiredRank = RankProof $required
      if ($requiredRank -ge 1 -and $proofText -notmatch '(?mi)^[ \t]*-[ \t]*Screenshot or visual observation:[ \t]*\S') {
        ErrorMsg "$(Rel $proofPath): P1+ proof needs screenshot or visual observation"
      }
      if ($requiredRank -ge 2 -and $proofText -notmatch '(?mi)^[ \t]*-[ \t]*Main user flow tested:[ \t]*yes\b') {
        ErrorMsg "$(Rel $proofPath): P2+ proof needs Main user flow tested: yes"
      }
      if ($requiredRank -ge 3 -and $proofText -notmatch '(?mi)^[ \t]*-[ \t]*Automated test result:[ \t]*pass\b') {
        ErrorMsg "$(Rel $proofPath): P3+ proof needs Automated test result: pass"
      }
      if ($requiredRank -ge 4) {
        if ($proofText -notmatch '(?mi)^[ \t]*-[ \t]*CI result:[ \t]*pass\b') {
          ErrorMsg "$(Rel $proofPath): P4 proof needs CI result: pass"
        }
        if ($proofText -notmatch '(?mi)^[ \t]*-[ \t]*GitHub diff available:[ \t]*yes\b') {
          ErrorMsg "$(Rel $proofPath): P4 proof needs GitHub diff available: yes"
        }
      }
    }
  }
}

$featureRoot = Join-Path $RootAbs "ldk\features"
if (Test-Path -LiteralPath $featureRoot) {
  foreach ($plan in Get-ChildItem -Path $featureRoot -Recurse -Filter "plan.md" -ErrorAction SilentlyContinue) {
    foreach ($line in (Get-Content -Encoding UTF8 -LiteralPath $plan.FullName)) {
      if ($line -notmatch '^\|') { continue }
      if ($line -match '^\|\s*(-+|ID)\s*\|') { continue }
      $cells = $line.Trim() -split '\|'
      if ($cells.Count -lt 8) { continue }
      $id = CleanCell $cells[1]
      $state = CleanCell $cells[$cells.Count - 2]
      if ($id -notmatch '^T[A-Za-z0-9_-]+$') {
        ErrorMsg "$(Rel $plan.FullName): task row ID '$id' must start with T (example: T1)"
      }
      if ($allowedTaskState -notcontains $state) {
        ErrorMsg "$(Rel $plan.FullName): invalid task state '$state'"
      }
    }
  }
}

$verifyTargets = @()
$ldkRoot = Join-Path $RootAbs "ldk"
if (Test-Path -LiteralPath $ldkRoot) {
  $verifyTargets += Get-ChildItem -Path $ldkRoot -Recurse -Filter "*.md" -ErrorAction SilentlyContinue
}
foreach ($f in $verifyTargets) {
  $count = ([regex]::Matches((Text $f.FullName), '\[VERIFY\]')).Count
  if ($count -gt 0) {
    Write-Host "INFO  $(Rel $f.FullName): $count [VERIFY]"
  }
}

Write-Host "----------------------------------------"
Write-Host "ldk-check: $($script:Errors) error(s), $($script:Warnings) warning(s)."
if ($script:Errors -gt 0) {
  exit 1
}
exit 0
