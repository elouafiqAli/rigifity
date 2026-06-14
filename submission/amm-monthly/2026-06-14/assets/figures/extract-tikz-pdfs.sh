#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

build_one() {
  local figure_name="$1"
  local figure_dir="$script_dir/$figure_name"
  local build_dir="$figure_dir/.build"
  local pdf_file="$figure_dir/$figure_name.pdf"
  local eps_file="$figure_dir/$figure_name.eps"

  mkdir -p "$build_dir"
  pdflatex -interaction=nonstopmode -halt-on-error -output-directory "$build_dir" "$figure_dir/$figure_name.tex"
  mv -f "$build_dir/$figure_name.pdf" "$pdf_file"
  pdftops -eps "$pdf_file" "$eps_file"
  rm -rf "$build_dir"
}

build_one dictionary
build_one mechanism
build_one resolution