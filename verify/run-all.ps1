# run-all.ps1 — harness driver
#
# Two-step verification of the manuscript:
#   1. Lean kernel build (lake build of lean/, invoked through WSL Debian)
#   2. Python numerics (verify/numerics.py)
#
# Exit codes:
#   0  full harness PASS (or PARTIAL when Lean toolchain unavailable)
#   1  any step FAIL
#
# The Lean step prefers WSL Debian because the Windows-side lake build would
# compile mathlib from source (hours); the WSL host has elan + pre-populated
# mathlib cache at ~/.cache/mathlib/ (~408 MB of .ltar oleans).
#
# Override the WSL distro with -WslDistro <name>; pass -NoWsl to use a
# Windows-native lake (must be on PATH).
#
# Provenance:
#   Plan: 14-harness_and_reproduction.md §5 (verify/) and §6 (reproduction).

[CmdletBinding()]
param(
    [string]$WslDistro = 'Debian',
    [switch]$NoWsl
)

$ErrorActionPreference = 'Stop'
$scriptRoot = $PSScriptRoot
$repoRoot = Split-Path -Parent $scriptRoot

# In WSL, the workspace is reachable at /mnt/<drive>/... — compute it from
# $repoRoot so this works wherever the repo lives.
function ConvertTo-WslPath([string]$winPath) {
    $p = $winPath -replace '\\', '/'
    if ($p -match '^([A-Za-z]):/(.*)') {
        $drive = $Matches[1].ToLower()
        $rest = $Matches[2]
        return "/mnt/$drive/$rest"
    }
    return $p
}

$wslRepoRoot = ConvertTo-WslPath $repoRoot
$wslLeanDir = "$wslRepoRoot/lean"

Write-Host ""
Write-Host "=== Rigidity harness ===" -ForegroundColor Cyan
Write-Host "Repo: $repoRoot"
Write-Host "WSL view: $wslRepoRoot (distro: $WslDistro)"
Write-Host ""

# ------------------------------------------------------------------------
# Step 1: Lean kernel build
# ------------------------------------------------------------------------
Write-Host "--- Step 1: Lean kernel build ---" -ForegroundColor Cyan

function Test-WslAvailable([string]$Distro) {
    if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) { return $false }
    $out = & wsl -d $Distro -- bash -lc 'which lake' 2>&1
    return ($LASTEXITCODE -eq 0 -and $out -match '/lake$')
}

$useWsl = (-not $NoWsl) -and (Test-WslAvailable -Distro $WslDistro)

if ($useWsl) {
    Write-Host "Using WSL $WslDistro for Lean (lake found at WSL-side elan toolchain)."
    # Cold sequence: lake update + lake exe cache get + lake build.
    # Cache get pulls oleans from ~/.cache/mathlib (~408 MB local, fast).
    $bashCmd = @"
set -e
cd $wslLeanDir
if [ ! -f lake-manifest.json ]; then
  echo 'lake-manifest.json missing; running lake update (one-time)...'
  lake update
fi
echo 'Pulling precompiled mathlib oleans (lake exe cache get)...'
lake exe cache get || echo '[WARN] cache get failed; build will compile mathlib from source.'
lake build
"@
    & wsl -d $WslDistro -- bash -lc $bashCmd
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[FAIL] Step 1: Lean kernel build (WSL)" -ForegroundColor Red
        exit 1
    }
    Write-Host "[PASS] Step 1: Lean kernel build (via WSL $WslDistro)" -ForegroundColor Green
    $leanResult = 'PASS'
} else {
    Push-Location (Join-Path $repoRoot 'lean')
    try {
        if (-not (Get-Command lake -ErrorAction SilentlyContinue)) {
            Write-Host "[SKIP] Step 1: 'lake' not found in PATH (Windows-side) and WSL unavailable." -ForegroundColor Yellow
            Write-Host "       Either install elan (https://github.com/leanprover/elan)"
            Write-Host "       or run on a machine with WSL Debian + Lean toolchain installed."
            $leanResult = 'SKIP'
        } else {
            if (-not (Test-Path 'lake-manifest.json')) {
                Write-Host "lake-manifest.json missing; running 'lake update' (one-time)..."
                lake update
                if ($LASTEXITCODE -ne 0) {
                    Write-Host "[FAIL] lake update" -ForegroundColor Red
                    exit 1
                }
            }
            Write-Host "Pulling precompiled mathlib oleans (lake exe cache get)..."
            lake exe cache get
            if ($LASTEXITCODE -ne 0) {
                Write-Host "[WARN] 'lake exe cache get' failed; build will compile mathlib from source (hours)." -ForegroundColor Yellow
            }
            lake build
            if ($LASTEXITCODE -ne 0) {
                Write-Host "[FAIL] Step 1: Lean kernel build (Windows-native)" -ForegroundColor Red
                exit 1
            }
            Write-Host "[PASS] Step 1: Lean kernel build (Windows-native)" -ForegroundColor Green
            $leanResult = 'PASS'
        }
    } finally {
        Pop-Location
    }
}

# ------------------------------------------------------------------------
# Step 2: Python numerics
# ------------------------------------------------------------------------
Write-Host ""
Write-Host "--- Step 2: Python numerics ---" -ForegroundColor Cyan
Push-Location $scriptRoot
try {
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "[FAIL] Step 2: 'python' not found in PATH." -ForegroundColor Red
        exit 1
    }
    python numerics.py
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[FAIL] Step 2: Python numerics" -ForegroundColor Red
        exit 1
    }
    Write-Host "[PASS] Step 2: Python numerics" -ForegroundColor Green
} finally {
    Pop-Location
}

# ------------------------------------------------------------------------
# Summary
# ------------------------------------------------------------------------
Write-Host ""
if ($leanResult -eq 'SKIP') {
    Write-Host "=== HARNESS: PARTIAL (Python only; Lean skipped — install elan or set up WSL Debian) ===" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "=== HARNESS: PASS ===" -ForegroundColor Green
    exit 0
}
