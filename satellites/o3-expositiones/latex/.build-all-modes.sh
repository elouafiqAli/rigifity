#!/usr/bin/env bash
# Internal helper: build all three Elsevier modes and report page counts.
# Toggles documentclass lines in manuscript.tex, runs the full LaTeX cycle
# for each mode, copies the result to manuscript-<mode>.pdf, then restores
# the file to submission (review) mode on exit.
#
# Used by the agent during the Expositiones submission build. Not part of
# the user-facing harness; the published build.sh keeps a single active
# mode.

set -euo pipefail
cd "$(dirname "$0")"

TEX=manuscript.tex
BACKUP=$(mktemp)
cp "$TEX" "$BACKUP"
trap 'cp "$BACKUP" "$TEX" && rm -f "$BACKUP"' EXIT

build_one() {
  local mode="$1"
  rm -f manuscript.aux manuscript.bbl manuscript.blg manuscript.log \
        manuscript.out manuscript.spl manuscript.pdf
  if ! pdflatex -interaction=nonstopmode -halt-on-error manuscript >/dev/null 2>&1; then
    echo "  pdflatex pass 1 FAILED in $mode mode; last 20 log lines:"
    tail -20 manuscript.log
    return 1
  fi
  bibtex manuscript >/dev/null 2>&1 || true
  pdflatex -interaction=nonstopmode -halt-on-error manuscript >/dev/null 2>&1 || true
  if ! pdflatex -interaction=nonstopmode -halt-on-error manuscript >/dev/null 2>&1; then
    echo "  pdflatex pass 3 FAILED in $mode mode; last 20 log lines:"
    tail -20 manuscript.log
    return 1
  fi
  cp manuscript.pdf "manuscript-${mode}.pdf"
}

set_mode() {
  # Start from a known state (all three commented), then uncomment the
  # requested mode.  Address each line by its unique class-argument
  # signature, so the substitution is idempotent regardless of the
  # previous commented/uncommented state.
  local mode="$1"
  cp "$BACKUP" "$TEX"

  sed -i 's|^\\documentclass\[review,12pt,a4paper\]{elsarticle}|% \\documentclass[review,12pt,a4paper]{elsarticle}|' "$TEX"
  sed -i 's|^\\documentclass\[preprint,12pt,a4paper\]{elsarticle}|% \\documentclass[preprint,12pt,a4paper]{elsarticle}|' "$TEX"
  sed -i 's|^\\documentclass\[1p,12pt,a4paper,times\]{elsarticle}|% \\documentclass[1p,12pt,a4paper,times]{elsarticle}|' "$TEX"

  case "$mode" in
    review)
      sed -i 's|^% \\documentclass\[review,12pt,a4paper\]{elsarticle}|\\documentclass[review,12pt,a4paper]{elsarticle}|' "$TEX"
      ;;
    reading)
      sed -i 's|^% \\documentclass\[preprint,12pt,a4paper\]{elsarticle}|\\documentclass[preprint,12pt,a4paper]{elsarticle}|' "$TEX"
      ;;
    final)
      sed -i 's|^% \\documentclass\[1p,12pt,a4paper,times\]{elsarticle}|\\documentclass[1p,12pt,a4paper,times]{elsarticle}|' "$TEX"
      ;;
  esac

  local n
  n=$(grep -cE '^\\documentclass' "$TEX" || true)
  if [[ "$n" -ne 1 ]]; then
    echo "  ERROR: set_mode($mode) left $n active documentclass lines"
    grep -nE '^(%? *)?\\documentclass' "$TEX" || true
    return 1
  fi
}

for mode in review reading final; do
  set_mode "$mode"
  echo ">>> building $mode mode..."
  build_one "$mode"
done

echo "---"
ls -la manuscript-*.pdf
echo "---page counts---"
for f in manuscript-review.pdf manuscript-reading.pdf manuscript-final.pdf; do
  n=$(pdfinfo "$f" 2>/dev/null | awk '/^Pages/ {print $2}')
  echo "$f : $n pages"
done
