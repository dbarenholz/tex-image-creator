#!/bin/bash

function mk_pdf() {
  local file="$1"
  pdflatex -shell-escape "$file" &>/dev/null

  if [[ $? -ne 0 ]]; then
    echo "Failed to make PDF for $file"
    exit 1
  fi

  # Cleanup auxiliary files
  local base="${file%.tex}"
  rm -f "${base}.aux" "${base}.log" "${base}.out"
}

function mk_svg() {
  local pdf="$1"
  local svg="$2"

  inkscape --pdf-poppler --export-type="svg" --pages=1 -o "$svg" "$pdf"

  if [[ $? -ne 0 ]]; then
    echo "Failed to make svg for $pdf"
    exit 1
  fi
}

function mv_to_svg() {
  local file="$1"
  mkdir -p ../svg
  mv "$file" ../svg/
}

function mv_to_pdf() {
  local file="$1"
  mkdir -p ../pdf
  mv "$file" ../pdf/
}

function process() {
  local tex="$1"
  echo "Processing $tex ..."
  mk_pdf "$tex"

  local pdf="${tex%.tex}.pdf"
  local svg="${tex%.tex}.svg"
  mk_svg "$pdf" "$svg"
  mv_to_svg "$svg"
  mv_to_pdf "$pdf"
}

function main() {
  # Go into the source directory
  cd src

  # Run `process` for each tex file
  for tex in $(fd . --extension 'tex' --strip-cwd-prefix='always'); do
    if [[ "$tex" == "setup.tex" ]]; then
      continue
    fi
    process "$tex"
  done

  # Go back, and suppress output
  cd - &>/dev/null
}

main
