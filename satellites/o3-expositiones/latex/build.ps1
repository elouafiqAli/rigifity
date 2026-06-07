# =============================================================================
# build.ps1 — Windows PowerShell LaTeX harness for the Expositiones satellite
# Compiles the Short Research Note for submission to Expositiones Mathematicae
# (Elsevier elsarticle class).
# =============================================================================

[CmdletBinding()]
param(
    [switch]$Clean,
    [switch]$Quiet,
    [ValidateSet('reading', 'review', 'final')]
    [string]$Mode = 'reading'
)

$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

$stem = 'manuscript'
$artifactExts = @('aux', 'bbl', 'blg', 'log', 'out', 'toc', 'idx', 'ilg', 'ind', 'lof', 'lot', 'fls', 'fdb_latexmk', 'synctex.gz', 'spl')

function Remove-LatexArtifacts {
    foreach ($ext in $artifactExts) {
        $f = "$stem.$ext"
        if (Test-Path $f) {
            Remove-Item $f -Force -ErrorAction SilentlyContinue
        }
    }
}

function Test-Tool {
    param([string]$Name)
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $cmd) {
        Write-Host "  [FAIL] $Name not found in PATH" -ForegroundColor Red
        return $false
    }
    if (-not $Quiet) { Write-Host "  [ ok ] $Name -> $($cmd.Source)" }
    return $true
}

function Set-DocumentMode {
    param([string]$ModeName)
    $tex = Get-Content "$stem.tex" -Raw

    # Comment all three documentclass lines (idempotent)
    $tex = $tex -replace '(?m)^\s*\\documentclass\[review,12pt,a4paper\]\{elsarticle\}', '% \\documentclass[review,12pt,a4paper]{elsarticle}'
    $tex = $tex -replace '(?m)^\s*\\documentclass\[preprint,12pt,a4paper\]\{elsarticle\}', '% \\documentclass[preprint,12pt,a4paper]{elsarticle}'
    $tex = $tex -replace '(?m)^\s*\\documentclass\[1p,12pt,a4paper,times,authoryear\]\{elsarticle\}', '% \\documentclass[1p,12pt,a4paper,times,authoryear]{elsarticle}'

    # Uncomment the chosen mode
    switch ($ModeName) {
        'review'  { $tex = $tex -replace '% \\documentclass\[review,12pt,a4paper\]\{elsarticle\}', '\documentclass[review,12pt,a4paper]{elsarticle}' }
        'reading' { $tex = $tex -replace '% \\documentclass\[preprint,12pt,a4paper\]\{elsarticle\}', '\documentclass[preprint,12pt,a4paper]{elsarticle}' }
        'final'   { $tex = $tex -replace '% \\documentclass\[1p,12pt,a4paper,times,authoryear\]\{elsarticle\}', '\documentclass[1p,12pt,a4paper,times,authoryear]{elsarticle}' }
    }

    Set-Content -Path "$stem.tex" -Value $tex -NoNewline
}

function Invoke-LatexBuild {
    Write-Host ""
    Write-Host "=== Building: $stem.tex (mode: $Mode) ===" -ForegroundColor Cyan

    if (-not (Test-Path "$stem.tex")) {
        Write-Host "  [FAIL] $stem.tex not found" -ForegroundColor Red
        return $false
    }

    Write-Host "  pdflatex pass 1 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 1 (see $stem.log)" -ForegroundColor Red
        return $false
    }

    Write-Host "  bibtex ..." -ForegroundColor DarkGray
    & bibtex $stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 2) {
        Write-Host "  [WARN] bibtex returned $LASTEXITCODE (see $stem.blg)" -ForegroundColor Yellow
    }

    Write-Host "  pdflatex pass 2 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 2 (see $stem.log)" -ForegroundColor Red
        return $false
    }

    Write-Host "  pdflatex pass 3 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 3 (see $stem.log)" -ForegroundColor Red
        return $false
    }

    if (-not (Test-Path "$stem.pdf")) {
        Write-Host "  [FAIL] $stem.pdf not produced" -ForegroundColor Red
        return $false
    }

    return $true
}

function Get-PageCount {
    $pdf = "$stem.pdf"
    if (-not (Test-Path $pdf)) { return 'n/a' }
    $pdfinfo = Get-Command pdfinfo -ErrorAction SilentlyContinue
    if ($pdfinfo) {
        $output = & pdfinfo $pdf 2>$null | Select-String -Pattern '^Pages:'
        if ($output) {
            return ($output -replace '^Pages:\s+', '').Trim()
        }
    }
    $bytes = [System.IO.File]::ReadAllBytes($pdf)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $matches = [regex]::Matches($text, '/Type\s*/Page[^s]')
    return $matches.Count
}

function Get-WordCount {
    if (-not (Test-Path "$stem.tex")) { return 'n/a' }
    $content = Get-Content "$stem.tex" -Raw
    $stripped = $content -replace '%.*', '' `
                         -replace '\\[a-zA-Z]+(\{[^}]*\})?', ' ' `
                         -replace '\{|\}', ' ' `
                         -replace '\$[^$]*\$', ' '
    $words = $stripped -split '\s+' | Where-Object { $_ -match '\S' }
    return $words.Count
}

# =============================================================================
# Main
# =============================================================================

if (-not $Quiet) {
    Write-Host "Expositiones satellite (O3) — LaTeX build harness" -ForegroundColor Green
    Write-Host "===================================================="
    Write-Host "Working dir: $scriptDir"
    Write-Host "Mode: $Mode (use -Mode <reading|review|final>)"
    Write-Host ""
    Write-Host "Toolchain check:"
}

$toolchainOk = (Test-Tool 'pdflatex') -and (Test-Tool 'bibtex')

if (-not $toolchainOk) {
    Write-Host ""
    Write-Host "ERROR: required LaTeX tools missing. Install a TeX distribution:" -ForegroundColor Red
    Write-Host "  Windows: MiKTeX (https://miktex.org/) or TeX Live"
    Write-Host "  Linux:   sudo apt install texlive-full"
    Write-Host "  macOS:   MacTeX (https://www.tug.org/mactex/)"
    Write-Host ""
    Write-Host "Also required: the Elsevier elsarticle class (usually bundled in TeX Live full)."
    exit 1
}

if ($Clean) {
    Write-Host ""
    Write-Host "Cleaning LaTeX artifacts..." -ForegroundColor Yellow
    Remove-LatexArtifacts
    Write-Host "Done."
    exit 0
}

# Switch the document mode in the .tex file
Set-DocumentMode -ModeName $Mode

$success = Invoke-LatexBuild

# Summary
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Green
Write-Host "-----------------------------------------------"
Write-Host ("{0,-12} {1,-10} {2,-10} {3,-10}" -f 'Manuscript', 'Status', 'Pages', 'Words')
Write-Host "-----------------------------------------------"

$status = if ($success) { 'PASS' } else { 'FAIL' }
$color  = if ($success) { 'Green' } else { 'Red' }
$pages  = if ($success) { Get-PageCount } else { 'n/a' }
$words  = Get-WordCount

Write-Host ("{0,-12} {1,-10} {2,-10} {3,-10}" -f $stem, $status, $pages, $words) -ForegroundColor $color
Write-Host "-----------------------------------------------"
Write-Host ""

# Page-count gate for submission mode
if ($Mode -eq 'review' -or $Mode -eq 'final') {
    if ($success -and $pages -match '^\d+$' -and [int]$pages -gt 10) {
        Write-Host "WARNING: Page count $pages exceeds Expositiones Short Research Note limit of 10 pages." -ForegroundColor Yellow
        Write-Host "Reduce the manuscript before submission." -ForegroundColor Yellow
    }
}

if ($success) {
    Write-Host "HARNESS: PASS" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "HARNESS: FAIL" -ForegroundColor Red
    exit 1
}
