#!/usr/bin/env bash
# =============================================================================
# build.sh — POSIX harness for satellite O3 (CRAS submission)
# Compiles both English and French manuscripts of the chord-substitution note
# for submission to Comptes Rendus Mathématique.
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CLEAN=0
EN_ONLY=0
FR_ONLY=0
QUIET=0

usage() {
    cat <<EOF
Usage: $0 [--clean] [--en-only] [--fr-only] [--quiet]
  --clean    Remove all LaTeX build artifacts (.aux, .bbl, .log, etc.)
  --en-only  Build only the English manuscript
  --fr-only  Build only the French manuscript
  --quiet    Suppress per-step progress output
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --clean)    CLEAN=1; shift ;;
        --en-only)  EN_ONLY=1; shift ;;
        --fr-only)  FR_ONLY=1; shift ;;
        --quiet)    QUIET=1; shift ;;
        -h|--help)  usage; exit 0 ;;
        *)          echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

ARTIFACT_EXTS=(aux bbl blg log out toc idx ilg ind lof lot fls fdb_latexmk synctex.gz)

clean_artifacts() {
    local stem=$1
    for ext in "${ARTIFACT_EXTS[@]}"; do
        rm -f "${stem}.${ext}"
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

build_latex() {
    local stem=$1
    local label=$2

    echo ""
    echo "=== Building: $label ($stem.tex) ==="

    if [[ ! -f "$stem.tex" ]]; then
        echo "  [FAIL] $stem.tex not found"
        return 1
    fi

    echo "  pdflatex pass 1 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$stem" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 1 (see $stem.log)"; return 1; }

    echo "  bibtex ..."
    bibtex "$stem" >/dev/null 2>&1 || echo "  [WARN] bibtex warnings (see $stem.blg)"

    echo "  pdflatex pass 2 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$stem" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 2 (see $stem.log)"; return 1; }

    echo "  pdflatex pass 3 ..."
    pdflatex -interaction=nonstopmode -halt-on-error "$stem" >/dev/null 2>&1 || {
        echo "  [FAIL] pdflatex pass 3 (see $stem.log)"; return 1; }

    if [[ ! -f "$stem.pdf" ]]; then
        echo "  [FAIL] $stem.pdf not produced"
        return 1
    fi

    return 0
}

get_page_count() {
    local pdf=$1
    if [[ ! -f "$pdf" ]]; then echo "n/a"; return; fi
    if command -v pdfinfo >/dev/null 2>&1; then
        pdfinfo "$pdf" | awk '/^Pages:/ {print $2}'
    else
        # Fallback: rough count via grep
        strings "$pdf" 2>/dev/null | grep -c '/Type /Page' || echo "?"
    fi
}

get_word_count() {
    local tex=$1
    if [[ ! -f "$tex" ]]; then echo "n/a"; return; fi
    sed -e 's/%.*$//' \
        -e 's/\\[a-zA-Z]\+\(\{[^}]*\}\)\?/ /g' \
        -e 's/[{}]//g' \
        -e 's/\$[^$]*\$//g' \
        "$tex" | wc -w
}

# =============================================================================
# Main
# =============================================================================

[[ $QUIET -eq 0 ]] && {
    echo "Satellite O3 — LaTeX build harness"
    echo "===================================="
    echo "Working dir: $SCRIPT_DIR"
    echo ""
    echo "Toolchain check:"
}

if ! check_tool pdflatex || ! check_tool bibtex; then
    echo ""
    echo "ERROR: required LaTeX tools missing. Install a TeX distribution:"
    echo "  Windows: MiKTeX (https://miktex.org/) or TeX Live"
    echo "  Linux:   sudo apt install texlive-full"
    echo "  macOS:   MacTeX (https://www.tug.org/mactex/)"
    exit 1
fi

if [[ $CLEAN -eq 1 ]]; then
    echo ""
    echo "Cleaning LaTeX artifacts..."
    for stem in chord-substitution-en chord-substitution-fr; do
        clean_artifacts "$stem"
    done
    echo "Done."
    exit 0
fi

declare -A results

if [[ $FR_ONLY -eq 0 ]]; then
    if build_latex chord-substitution-en "English manuscript"; then
        results[en]=PASS
    else
        results[en]=FAIL
    fi
fi
if [[ $EN_ONLY -eq 0 ]]; then
    if build_latex chord-substitution-fr "French manuscript"; then
        results[fr]=PASS
    else
        results[fr]=FAIL
    fi
fi

# Summary
echo ""
echo "=== Summary ==="
echo "----------------------------------------------------------------"
printf "%-10s %-10s %-10s %-10s\n" "Manuscript" "Status" "Pages" "Words"
echo "----------------------------------------------------------------"

for lang in en fr; do
    if [[ -z "${results[$lang]+x}" ]]; then continue; fi
    stem="chord-substitution-$lang"
    pages=$([ "${results[$lang]}" = PASS ] && get_page_count "$stem.pdf" || echo "n/a")
    words=$(get_word_count "$stem.tex")
    printf "%-10s %-10s %-10s %-10s\n" "${lang^^}" "${results[$lang]}" "$pages" "$words"
done
echo "----------------------------------------------------------------"
echo ""

# Exit status
all_ok=1
for r in "${results[@]}"; do
    if [[ "$r" != "PASS" ]]; then all_ok=0; fi
done
if [[ $all_ok -eq 1 ]]; then
    echo "HARNESS: PASS"
    exit 0
else
    echo "HARNESS: FAIL"
    exit 1
fi
