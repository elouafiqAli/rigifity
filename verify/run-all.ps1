# run-all.ps1 — harness driver
#
# Two-step verification of the manuscript:
#   1. Lean kernel build (lake build of lean/)
#   2. Python numerics (verify/numerics.py)
#
# Exit codes:
#   0  full harness PASS
#   1  any step FAIL
#
# Provenance:
#   Plan: 14-harness_and_reproduction.md §5 (verify/) and §6 (reproduction handbook).

$ErrorActionPreference = 'Stop'
$scriptRoot = $PSScriptRoot
$repoRoot = Split-Path -Parent $scriptRoot

Write-Host ""
Write-Host "=== Rigidity harness ===" -ForegroundColor Cyan
Write-Host "Repo: $repoRoot"
Write-Host ""

# ------------------------------------------------------------------------
# Step 1: Lean kernel build
# ------------------------------------------------------------------------
Write-Host "--- Step 1: Lean kernel build ---" -ForegroundColor Cyan
Push-Location (Join-Path $repoRoot 'lean')
try {
    if (-not (Get-Command lake -ErrorAction SilentlyContinue)) {
        Write-Host "[SKIP] Step 1: 'lake' not found in PATH." -ForegroundColor Yellow
        Write-Host "       Install elan from https://github.com/leanprover/elan"
        Write-Host "       then 'elan toolchain install $(Get-Content lean-toolchain)'"
        Write-Host "       and re-run this script."
        $leanResult = "SKIP"
    } else {
        if (-not (Test-Path 'lake-manifest.json')) {
            Write-Host "lake-manifest.json missing; running 'lake update' (one-time)..."
            lake update
            if ($LASTEXITCODE -ne 0) {
                Write-Host "[FAIL] lake update" -ForegroundColor Red
                exit 1
            }
        }
        # Pull precompiled mathlib oleans (saves hours vs building from source).
        # The cache binary lives under .lake/packages/mathlib/scripts/cache.
        Write-Host "Pulling precompiled mathlib oleans (lake exe cache get)..."
        lake exe cache get
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[WARN] 'lake exe cache get' failed; build will compile mathlib from source (hours)." -ForegroundColor Yellow
            Write-Host "       Continuing with 'lake build' anyway." -ForegroundColor Yellow
        }
        lake build
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[FAIL] Step 1: Lean kernel build" -ForegroundColor Red
            exit 1
        }
        Write-Host "[PASS] Step 1: Lean kernel build" -ForegroundColor Green
        $leanResult = "PASS"
    }
} finally {
    Pop-Location
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
if ($leanResult -eq "SKIP") {
    Write-Host "=== HARNESS: PARTIAL (Python only; Lean skipped — install elan) ===" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "=== HARNESS: PASS ===" -ForegroundColor Green
    exit 0
}
