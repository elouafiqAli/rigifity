#!/usr/bin/env bash
# =============================================================================
# build.sh — POSIX LaTeX harness for the Expositiones satellite (O3)
# Compiles the Short Research Note for submission to Expositiones Mathematicae.
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

STEM='manuscript'
MODE='reading'
CLEAN=0
QUIET=0

usage() {
    cat <<EOF
Usage: $0 [--clean] [--quiet] [--mode <reading|review|final>]
  --clean              Remove all LaTeX build artifacts (.aux, .bbl, .log, etc.)
  --quiet              Suppress per-step progress output
  --mode <reading>     Build the author-reading PDF (default)
  --mode <review>      Build the EES-submission PDF (line-numbered, double-spaced)
  --mode <final>       Build the publisher-typeset PDF (1-column)
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)  CLEAN=1; shift ;;
        --quiet)  QUIET=1; shift ;;
        --mode)   MODE="$2"; shift 2 ;;
        -h|--help) usage; exit 0 ;;
        *)        echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

case $MODE in
    reading|review|final) ;;
    *) echo "Invalid mode: $MODE"; usage; exit 1 ;;
esac

ARTIFACT_EXTS=(aux bbl blg log out toc idx ilg ind lof lot fls fdb_latexmk synctex.gz spl)

clean_artifacts() {
    for ext in "${ARTIFACT_EXTS[@]}"; do
        rm -f "${STEM}.${ext}"
    done
}

check_tool() {
    local name=$1
    if ! command -v "$name" >/dev/null 2>&1; then
        echo "  [FAIL] $name not found in PATH"
        return 1
    fi
    [[ $QUIET -eq 0 ]] && echo "  [ ok ] $name -> $(command -v "$name")"
    return 0
}

set_document_mode() {
    local m=$1
    # Comment all three documentclass lines (idempotent)
    sed -i.bak \
        -e 's|^\\documentclass\[review,12pt,a4paper\]{elsarticle}|% \\documentclass[review,12pt,a4paper]{elsarticle}|' \
        -e 's|^\\documentclass\[preprint,12pt,a4paper\]{elsarticle}|% \\documentclass[preprint,12pt,a4paper]{elsarticle}|' \
        -e 's|^\\documentclass\[1p,12pt,a4paper,times,authoryear\]{elsarticle}|% \\documentclass[1p,12pt,a4paper,times,authoryear]{elsarticle}|' \
        "$STEM.tex"

    # Uncomment the chosen mode
    case $m in
        review)  sed -i.bak 's|% \\documentclass\[review,12pt,a4paper\]{elsarticle}|\\documentclass[review,12pt,a4paper]{elsarticle}|' "$STEM.tex" ;;
        reading) sed -i.bak 's|% \\documentclass\[preprint,12pt,a4paper\]{elsarticle}|\\documentclass[preprint,12pt,a4paper]{elsarticle}|' "$STEM.tex" ;;
        final)   sed -i.bak 's|% \\documentclass\[1p,12pt,a4paper,times,authoryear\]{elsarticle}|\\documentclass[1p,12pt,a4paper,times,authoryear]{elsarticle}|' "$STEM.tex" ;;
    esac

    rm -f "$STEM.tex.bak"
}

build_latex() {
    echo ""
    echo "=== Building: $STEM.tex (mode: $MODE) ==="

    if [[ ! -f "$STEM.tex" ]]; then
        echo "  [FAIL] $STEM.tex not found"
        return 1
    fi

    echo "  pdflatex pass 1 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$STEM" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 1 (see $STEM.log)"; return 1; }

    echo "  bibtex ..."
    bibtex "$STEM" >/dev/null 2>&1 || echo "  [WARN] bibtex warnings (see $STEM.blg)"

    echo "  pdflatex pass 2 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$STEM" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 2 (see $STEM.log)"; return 1; }

    echo "  pdflatex pass 3 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$STEM" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 3 (see $STEM.log)"; return 1; }

    if [[ ! -f "$STEM.pdf" ]]; then
        echo "  [FAIL] $STEM.pdf not produced"
        return 1
    fi

    return 0
}

get_page_count() {
    if [[ ! -f "$STEM.pdf" ]]; then echo "n/a"; return; fi
    if command -v pdfinfo >/dev/null 2>&1; then
        pdfinfo "$STEM.pdf" | awk '/^Pages:/ {print $2}'
    else
        strings "$STEM.pdf" 2>/dev/null | grep -c '/Type /Page' || echo "?"
    fi
}

get_word_count() {
    if [[ ! -f "$STEM.tex" ]]; then echo "n/a"; return; fi
    sed -e 's/%.*$//' \
        -e 's/\\[a-zA-Z]\+\(\{[^}]*\}\)\?/ /g' \
        -e 's/[{}]//g' \
        -e 's/\$[^$]*\$//g' \
        "$STEM.tex" | wc -w
}

# =============================================================================
# Main
# =============================================================================

[[ $QUIET -eq 0 ]] && {
    echo "Expositiones satellite (O3) — LaTeX build harness"
    echo "===================================================="
    echo "Working dir: $SCRIPT_DIR"
    echo "Mode: $MODE (use --mode <reading|review|final>)"
    echo ""
    echo "Toolchain check:"
}

if ! check_tool pdflatex || ! check_tool bibtex; then
    echo ""
    echo "ERROR: required LaTeX tools missing. Install a TeX distribution:"
    echo "  Windows: MiKTeX (https://miktex.org/) or TeX Live"
    echo "  Linux:   sudo apt install texlive-full"
    echo "  macOS:   MacTeX (https://www.tug.org/mactex/)"
    echo ""
    echo "Also required: the Elsevier elsarticle class (usually bundled in TeX Live full)."
    exit 1
fi

if [[ $CLEAN -eq 1 ]]; then
    echo ""
    echo "Cleaning LaTeX artifacts..."
    clean_artifacts
    echo "Done."
    exit 0
fi

set_document_mode "$MODE"

if build_latex; then
    STATUS=PASS
else
    STATUS=FAIL
fi

# Summary
echo ""
echo "=== Summary ==="
echo "-----------------------------------------------"
printf "%-12s %-10s %-10s %-10s\n" "Manuscript" "Status" "Pages" "Words"
echo "-----------------------------------------------"

pages=$([ "$STATUS" = "PASS" ] && get_page_count || echo "n/a")
words=$(get_word_count)
printf "%-12s %-10s %-10s %-10s\n" "$STEM" "$STATUS" "$pages" "$words"
echo "-----------------------------------------------"
echo ""

# Page-count gate for submission mode
if [[ "$MODE" = "review" || "$MODE" = "final" ]]; then
    if [[ "$STATUS" = "PASS" && "$pages" =~ ^[0-9]+$ && "$pages" -gt 10 ]]; then
        echo "WARNING: Page count $pages exceeds Expositiones Short Research Note limit of 10 pages."
        echo "Reduce the manuscript before submission."
    fi
fi

if [[ "$STATUS" = "PASS" ]]; then
    echo "HARNESS: PASS"
    exit 0
else
    echo "HARNESS: FAIL"
    exit 1
fi
