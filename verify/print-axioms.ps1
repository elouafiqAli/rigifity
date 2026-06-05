#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Audit: print the axioms used by every theorem tagged @[rigidity_proved].

.DESCRIPTION
    Run via:

        ./verify/print-axioms.ps1

    Pipes lean/Audit/PrintAxioms.lean through lake env lean in WSL Debian.
    Expected: every theorem depends only on [propext, Classical.choice,
    Quot.sound]. Anything else (sorryAx, additional axioms) indicates
    cheating or unintended dependency drift.

.PARAMETER WslDistro
    The WSL distribution to use. Default: Debian.
#>

[CmdletBinding()]
param(
    [string] $WslDistro = 'Debian'
)

$ErrorActionPreference = 'Stop'

$wslHome  = (& wsl -d $WslDistro -- bash -lc 'echo $HOME').Trim()
$wslBuild = "$wslHome/rigidity-build"

Write-Host "=== Axiom audit ===" -ForegroundColor Magenta
Write-Host "Project: $wslBuild" -ForegroundColor DarkGray

$script = "set -e; export PATH=$wslHome/.local/bin:$wslHome/.elan/bin:/usr/local/bin:/usr/bin:/bin; cp /mnt/c/Users/aelouafiq/workdir/rigidity/lean/Audit/PrintAxioms.lean $wslBuild/PrintAxioms.lean; cd $wslBuild; lake env lean PrintAxioms.lean 2>&1; rm -f $wslBuild/PrintAxioms.lean"
$output = & wsl -d $WslDistro -- bash --noprofile --norc -c $script

# Display
$output | ForEach-Object { Write-Host $_ }

# Verify: every declared theorem should print exactly [propext, Classical.choice, Quot.sound].
$lines = $output -split "`n"
$failures = @()
$checked = 0
foreach ($line in $lines) {
    if ($line -match "depends on axioms: \[(.+)\]") {
        $checked++
        $axioms = $matches[1]
        # Allow any subset of the expected three (some theorems only need propext, etc.).
        $extra = ($axioms -split ',\s*') | Where-Object {
            $_ -notin @('propext', 'Classical.choice', 'Quot.sound')
        }
        if ($extra.Count -gt 0) {
            $failures += "  $line"
        }
    }
}

Write-Host ""
if ($checked -eq 0) {
    Write-Host "[FAIL] No theorems were checked. Lake may have failed silently." -ForegroundColor Red
    exit 1
}
if ($failures.Count -eq 0) {
    Write-Host "[PASS] All $checked proved theorems use only the three standard Lean axioms." -ForegroundColor Green
    exit 0
} else {
    Write-Host "[FAIL] The following theorems depend on unexpected axioms:" -ForegroundColor Red
    foreach ($f in $failures) { Write-Host $f -ForegroundColor Red }
    exit 1
}
