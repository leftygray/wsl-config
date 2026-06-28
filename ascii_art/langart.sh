#!/usr/bin/env bash
#
# langart.sh - render ASCII art logos from onefetch's languages.yaml file 
# (OneFetch: https://github.com/o2sh/onefetch)
#
# Created by Claude Opus 4.8 - 22 June 2026 
#
# Usage:
#   ./langart.sh <Language>      Show art for a language (case-insensitive)
#   ./langart.sh --list          List all available languages
#   ./langart.sh --random        Show a random language
#   ./langart.sh --no-color ...  Disable ANSI colors
#   ./langart.sh --help          Show this help
#
# The YAML file path can be overridden with the LANGUAGES_YAML env var
# or the --file <path> option. By default it looks for languages.yaml
# next to this script, then in the current directory.

set -euo pipefail

# ---------------------------------------------------------------------------
# Locate the YAML file
# ---------------------------------------------------------------------------
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
yaml="${LANGUAGES_YAML:-}"

# ---------------------------------------------------------------------------
# ANSI color map: onefetch uses the 8 standard color names as foreground.
# ---------------------------------------------------------------------------
declare -A ANSI=(
  [black]=30 [red]=31 [green]=32 [yellow]=33
  [blue]=34 [magenta]=35 [cyan]=36 [white]=37
)
RESET=$'\e[0m'

use_color=1

usage() {
  sed -n '3,18p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

die() { echo "error: $*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# Parse arguments
# ---------------------------------------------------------------------------
mode="show"
target=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)   usage; exit 0 ;;
    --list|-l)   mode="list" ;;
    --random|-r) mode="random" ;;
    --no-color)  use_color=0 ;;
    --file)      shift; [[ $# -gt 0 ]] || die "--file needs a path"; yaml="$1" ;;
    --*)         die "unknown option: $1" ;;
    *)           target="$1" ;;
  esac
  shift
done

# Resolve YAML path if not set explicitly
if [[ -z "$yaml" ]]; then
  if   [[ -f "$script_dir/languages.yaml" ]]; then yaml="$script_dir/languages.yaml"
  elif [[ -f "./languages.yaml" ]];          then yaml="./languages.yaml"
  else die "languages.yaml not found; set LANGUAGES_YAML or use --file"; fi
fi
[[ -f "$yaml" ]] || die "file not found: $yaml"

# ---------------------------------------------------------------------------
# List all top-level language keys (lines starting in column 0 ending in ':')
# ---------------------------------------------------------------------------
list_langs() {
  grep -E '^[^[:space:]].*:$' "$yaml" | sed 's/:$//'
}

if [[ "$mode" == "list" ]]; then
  list_langs
  exit 0
fi

# ---------------------------------------------------------------------------
# Resolve target (case-insensitive) for show/random
# ---------------------------------------------------------------------------
if [[ "$mode" == "random" ]]; then
  target="$(list_langs | shuf -n1)"
elif [[ -z "$target" ]]; then
  usage; exit 1
fi

# Case-insensitive match against real key names
real_name="$(list_langs | awk -v t="$target" 'tolower($0)==tolower(t){print; found=1; exit} END{if(!found) exit 1}')" \
  || die "language not found: $target  (try --list)"

# ---------------------------------------------------------------------------
# Extract the ascii block and the ansi color list for one language.
# awk emits two sections separated by marker lines so bash can split them.
# ---------------------------------------------------------------------------
parsed="$(awk -v name="$real_name" '
  # Top-level key (column 0, ends with ":")
  /^[^ \t].*:$/ {
    cur = $0; sub(/:$/, "", cur)
    inblock = (cur == name)
    in_ascii = 0; in_ansi = 0
    next
  }
  inblock != 1 { next }

  # Start of the ascii block scalar:  "  ascii: |"
  /^  ascii: *\|/ { in_ascii = 1; in_ansi = 0; print "@@ASCII@@"; next }

  # Start of the ansi list:  "    ansi:"
  /^    ansi:/ { in_ascii = 0; in_ansi = 1; print "@@ANSI@@"; next }

  in_ascii == 1 {
    # ascii content is indented 4 spaces; a drop to <=2 indent ends the block
    if ($0 ~ /^    / || $0 == "") { line = $0; sub(/^    /, "", line); print "A>" line }
    else { in_ascii = 0 }
    next
  }

  in_ansi == 1 {
    if ($0 ~ /^      - /) { c = $0; sub(/^      - */, "", c); gsub(/"/, "", c); print "C>" c }
    else if ($0 ~ /^    [^ ]/) { in_ansi = 0 }   # next key under colors (hex/chip)
    next
  }
' "$yaml")"

# Split parsed output into the ascii lines and the color list
mapfile -t ascii_lines < <(printf '%s\n' "$parsed" | sed -n 's/^A>//p')
mapfile -t colors      < <(printf '%s\n' "$parsed" | sed -n 's/^C>//p')

[[ ${#ascii_lines[@]} -gt 0 ]] || die "no ascii art found for $real_name"

# ---------------------------------------------------------------------------
# Render: replace {N} placeholders with the ANSI escape for colors[N].
# ---------------------------------------------------------------------------
render_line() {
  local line="$1"
  if [[ "$use_color" -eq 0 ]]; then
    # strip every {N} placeholder
    printf '%s\n' "$(printf '%s' "$line" | sed -E 's/\{[0-9]\}//g')"
    return
  fi
  # Walk through the line, swapping {N} tokens for escapes
  local result="$line"
  local i
  for i in "${!colors[@]}"; do
    local name="${colors[$i]}"
    local code="${ANSI[$name]:-0}"
    local esc=$'\e['"$code"'m'
    result="${result//\{$i\}/$esc}"
  done
  # Any leftover placeholders (index beyond the list) -> reset
  result="$(printf '%s' "$result" | sed -E 's/\{[0-9]\}//g')"
  printf '%s%s\n' "$result" "$RESET"
}

for l in "${ascii_lines[@]}"; do
  render_line "$l"
done
