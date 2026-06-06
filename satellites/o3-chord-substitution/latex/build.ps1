# =============================================================================
# build.ps1 — LaTeX compilation harness for satellite O3 (CRAS submission)
# Windows PowerShell harness — compiles both English and French manuscripts
# of the chord-substitution note for submission to Comptes Rendus Mathématique.
# =============================================================================

[CmdletBinding()]
param(
    [switch]$Clean,
    [switch]$EnOnly,
    [switch]$FrOnly,
    [switch]$Quiet
)

$ErrorActionPreference = 'Stop'
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

$artifactExts = @('aux', 'bbl', 'blg', 'log', 'out', 'toc', 'idx', 'ilg', 'ind', 'lof', 'lot', 'fls', 'fdb_latexmk', 'synctex.gz')

function Remove-LatexArtifacts {
    param([string]$Stem)
    foreach ($ext in $artifactExts) {
        $f = "$Stem.$ext"
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

function Invoke-LatexBuild {
    param([string]$Stem, [string]$Label)
    Write-Host ""
    Write-Host "=== Building: $Label ($Stem.tex) ===" -ForegroundColor Cyan

    if (-not (Test-Path "$Stem.tex")) {
        Write-Host "  [FAIL] $Stem.tex not found" -ForegroundColor Red
        return $false
    }

    # pdflatex -> bibtex -> pdflatex -> pdflatex
    Write-Host "  pdflatex pass 1 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $Stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 1 (see $Stem.log)" -ForegroundColor Red
        return $false
    }

    Write-Host "  bibtex ..." -ForegroundColor DarkGray
    & bibtex $Stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 2) {  # bibtex returns 2 on warnings
        Write-Host "  [WARN] bibtex returned $LASTEXITCODE (see $Stem.blg)" -ForegroundColor Yellow
    }

    Write-Host "  pdflatex pass 2 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $Stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 2 (see $Stem.log)" -ForegroundColor Red
        return $false
    }

    Write-Host "  pdflatex pass 3 ..." -ForegroundColor DarkGray
    & pdflatex -interaction=nonstopmode -halt-on-error $Stem 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [FAIL] pdflatex pass 3 (see $Stem.log)" -ForegroundColor Red
        return $false
    }

    if (-not (Test-Path "$Stem.pdf")) {
        Write-Host "  [FAIL] $Stem.pdf not produced" -ForegroundColor Red
        return $false
    }

    return $true
}

function Get-PageCount {
    param([string]$PdfPath)
    if (-not (Test-Path $PdfPath)) { return 'n/a' }
    # Lightweight page count via pdfinfo if available; else count /Type /Page in the PDF
    $pdfinfo = Get-Command pdfinfo -ErrorAction SilentlyContinue
    if ($pdfinfo) {
        $output = & pdfinfo $PdfPath 2>$null | Select-String -Pattern '^Pages:'
        if ($output) {
            return ($output -replace '^Pages:\s+', '').Trim()
        }
    }
    # Fallback: grep the PDF byte stream for `/Type /Page` (rough but workable)
    $bytes = [System.IO.File]::ReadAllBytes($PdfPath)
    $text = [System.Text.Encoding]::ASCII.GetString($bytes)
    $matches = [regex]::Matches($text, '/Type\s*/Page[^s]')
    return $matches.Count
}

function Get-WordCount {
    param([string]$TexPath)
    if (-not (Test-Path $TexPath)) { return 'n/a' }
    $content = Get-Content $TexPath -Raw
    # Strip LaTeX comments and commands for a rough estimate
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
    Write-Host "Satellite O3 — LaTeX build harness" -ForegroundColor Green
    Write-Host "===================================="
    Write-Host "Working dir: $scriptDir"
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
    exit 1
}

if ($Clean) {
    Write-Host ""
    Write-Host "Cleaning LaTeX artifacts..." -ForegroundColor Yellow
    foreach ($stem in @('chord-substitution-en', 'chord-substitution-fr')) {
        Remove-LatexArtifacts -Stem $stem
    }
    Write-Host "Done."
    exit 0
}

$results = @{}

if (-not $FrOnly) {
    $results['en'] = Invoke-LatexBuild -Stem 'chord-substitution-en' -Label 'English manuscript'
}
if (-not $EnOnly) {
    $results['fr'] = Invoke-LatexBuild -Stem 'chord-substitution-fr' -Label 'French manuscript'
}

# Summary
Write-Host ""
Write-Host "=== Summary ===" -ForegroundColor Green
Write-Host "----------------------------------------------------------------"
Write-Host ("{0,-10} {1,-10} {2,-10} {3,-10}" -f 'Manuscript', 'Status', 'Pages', 'Words')
Write-Host "----------------------------------------------------------------"

foreach ($lang in @('en', 'fr')) {
    if (-not $results.ContainsKey($lang)) { continue }
    $stem = "chord-substitution-$lang"
    $status = if ($results[$lang]) { 'PASS' } else { 'FAIL' }
    $color = if ($results[$lang]) { 'Green' } else { 'Red' }
    $pages = if ($results[$lang]) { Get-PageCount "$stem.pdf" } else { 'n/a' }
    $words = Get-WordCount "$stem.tex"
    Write-Host ("{0,-10} {1,-10} {2,-10} {3,-10}" -f $lang.ToUpper(), $status, $pages, $words) -ForegroundColor $color
}
Write-Host "----------------------------------------------------------------"
Write-Host ""

# Exit status
$allOk = $true
foreach ($r in $results.Values) { if (-not $r) { $allOk = $false } }
if ($allOk) {
    Write-Host "HARNESS: PASS" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "HARNESS: FAIL" -ForegroundColor Red
    exit 1
}
