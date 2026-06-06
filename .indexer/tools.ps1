#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Bootstrap and drive the rigidity-indexer.

.DESCRIPTION
    Single entry point for the .indexer/ Python tool. Creates a uv-managed
    venv on first use, installs deps, and dispatches to the indexer CLI.

.PARAMETER Action
    setup    Create .venv/ and install dependencies (idempotent).
    index    Run `rigidity-index index` (forwards extra args).
    query    Run `rigidity-index query` (forwards extra args).
    stats    Run `rigidity-index stats`.
    clear    Run `rigidity-index clear`.

.EXAMPLE
    .indexer/tools.ps1 setup
    .indexer/tools.ps1 index --limit 1 --root unit-fractions
    .indexer/tools.ps1 query "polynomial Freiman Ruzsa" -k 5 --ext .lean
    .indexer/tools.ps1 stats
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0, Mandatory = $true)]
    [ValidateSet('setup', 'index', 'query', 'stats', 'clear')]
    [string] $Action,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $Forwarded
)

$ErrorActionPreference = 'Stop'

$indexerDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$venv = Join-Path $indexerDir '.venv'
$pythonExe = if ($IsWindows -or $env:OS -eq 'Windows_NT') {
    Join-Path $venv 'Scripts/python.exe'
} else {
    Join-Path $venv 'bin/python'
}

function Ensure-Setup {
    if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
        throw "uv not found on PATH. Install from https://docs.astral.sh/uv/ (winget install astral-sh.uv)."
    }

    if (-not (Test-Path $venv)) {
        Write-Host "[indexer] creating venv at $venv via uv..." -ForegroundColor Cyan
        Push-Location $indexerDir
        try {
            & uv venv --python 3.13 .venv
        } finally {
            Pop-Location
        }
    }

    Write-Host "[indexer] installing/updating dependencies..." -ForegroundColor Cyan
    Push-Location $indexerDir
    try {
        & uv pip install --python $pythonExe --editable . | Out-Host
    } finally {
        Pop-Location
    }
}

function Invoke-CLI([string] $Sub, [string[]] $Extras) {
    if (-not (Test-Path $pythonExe)) {
        Write-Host "[indexer] venv missing; running setup first..." -ForegroundColor Yellow
        Ensure-Setup
    }
    if ($null -eq $Extras) { $Extras = @() }
    & $pythonExe -m indexer $Sub @Extras
    exit $LASTEXITCODE
}

switch ($Action) {
    'setup' {
        Ensure-Setup
        Write-Host "[indexer] OK. Try: .indexer/tools.ps1 index --limit 1 --root unit-fractions" -ForegroundColor Green
    }
    'index' { Invoke-CLI 'index' $Forwarded }
    'query' { Invoke-CLI 'query' $Forwarded }
    'stats' { Invoke-CLI 'stats' $Forwarded }
    'clear' { Invoke-CLI 'clear' $Forwarded }
}
