#!/usr/bin/env bash
# ldk-check.sh - deterministic validation for Lovable Driven Kit state.
set -uo pipefail

ROOT="${1:-.}"
ROOT="$(cd "$ROOT" 2>/dev/null && pwd -P)"
if [ -z "$ROOT" ]; then
  echo "ERROR invalid root"
  exit 1
fi

ERRORS=0
WARNINGS=0

error() { echo "ERROR $1"; ERRORS=$((ERRORS + 1)); }
warn() { echo "WARN  $1"; WARNINGS=$((WARNINGS + 1)); }
rel() { printf '%s\n' "${1#"$ROOT"/}"; }

rank_proof() {
  case "$1" in
    P1) echo 1 ;;
    P2) echo 2 ;;
    P3) echo 3 ;;
    P4) echo 4 ;;
    none) echo 0 ;;
    *) echo -1 ;;
  esac
}

marker() {
  local file="$1" name="$2"
  grep -m1 -E "^${name}:[[:space:]]*" "$file" | sed -E "s/^${name}:[[:space:]]*//; s/[[:space:]]+$//" || true
}

clean_cell() {
  sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//; s/^`//; s/`$//'
}

valid_in() {
  local value="$1"; shift
  local item
  for item in "$@"; do
    [ "$value" = "$item" ] && return 0
  done
  return 1
}

LEDGER="$ROOT/ldk/ledger.md"
if [ ! -f "$LEDGER" ]; then
  error "missing ldk/ledger.md"
else
  while IFS= read -r line; do
    echo "$line" | grep -qE '^\|' || continue
    echo "$line" | grep -qE '^\|[[:space:]]*(-+|ID)[[:space:]]*\|' && continue
    IFS='|' read -r _ id feature risk state required evidence _rest <<< "$line"
    id="$(printf '%s' "$id" | clean_cell)"
    feature="$(printf '%s' "$feature" | clean_cell)"
    risk="$(printf '%s' "$risk" | clean_cell)"
    state="$(printf '%s' "$state" | clean_cell)"
    required="$(printf '%s' "$required" | clean_cell)"
    evidence="$(printf '%s' "$evidence" | clean_cell)"

    echo "$id" | grep -qE '^F[A-Za-z0-9_-]+$' || error "ldk/ledger.md: row ID '$id' must start with F (example: F1)"
    valid_in "$risk" trivial baixo medio alto || error "ldk/ledger.md: $id has invalid Risk '$risk'"
    valid_in "$state" idea planned approved building proof-pending done partial blocked reopened || error "ldk/ledger.md: $id has invalid State '$state'"
    valid_in "$required" P1 P2 P3 P4 || error "ldk/ledger.md: $id has invalid Proof required '$required'"

    if [ -n "$evidence" ] && [ "$evidence" != "-" ]; then
      echo "$evidence" | grep -qiE '(^|/)(plan|brief)\.md$' && \
        error "ldk/ledger.md: $id Last evidence must not point to plan/brief '$evidence'"
      case "$state" in
        idea|planned|approved|building|proof-pending)
          error "ldk/ledger.md: $id state '$state' must keep Last evidence empty"
          ;;
      esac
    fi

    if [ "$state" = "done" ]; then
      if [ -z "$evidence" ] || [ "$evidence" = "-" ]; then
        error "ldk/ledger.md: $id is done but Last evidence is empty"
        continue
      fi
      proof="$ROOT/${evidence//\\//}"
      if [ ! -f "$proof" ]; then
        error "ldk/ledger.md: $id points to missing proof '$evidence'"
        continue
      fi

      status="$(marker "$proof" "Status")"
      proof_risk="$(marker "$proof" "Risk")"
      proof_required="$(marker "$proof" "Proof level required")"
      achieved="$(marker "$proof" "Proof level achieved")"

      [ "$status" = "DONE" ] || error "$(rel "$proof"): ledger is done but proof Status is '$status'"
      [ -z "$proof_risk" ] || [ "$proof_risk" = "$risk" ] || warn "$(rel "$proof"): proof Risk '$proof_risk' differs from ledger '$risk'"
      [ "$proof_required" = "$required" ] || error "$(rel "$proof"): proof required '$proof_required' differs from ledger '$required'"

      if [ "$(rank_proof "$achieved")" -lt "$(rank_proof "$required")" ]; then
        error "$(rel "$proof"): achieved '$achieved' is lower than required '$required'"
      fi
      grep -qiE '^[[:space:]]*-[[:space:]]*AC[0-9]+:[[:space:]]*not covered\b' "$proof" && \
        error "$(rel "$proof"): DONE proof has not covered AC"

      for check in \
        "Required proof identified" \
        "All essential AC covered" \
        "Evidence exists for every covered AC" \
        "Proof level achieved >= required"
      do
        grep -qiE "^[[:space:]]*-[[:space:]]*$check:[[:space:]]*yes\\b" "$proof" || \
          error "$(rel "$proof"): DONE proof self-check '$check' must be yes"
      done
      grep -qiE '^[[:space:]]*-[[:space:]]*Critical errors known:[[:space:]]*no\b' "$proof" || \
        error "$(rel "$proof"): DONE proof self-check 'Critical errors known' must be no"
      grep -qiE '^[[:space:]]*-[[:space:]]*LDK engine drift detected:[[:space:]]*no\b' "$proof" || \
        error "$(rel "$proof"): DONE proof self-check 'LDK engine drift detected' must be no"

      required_rank="$(rank_proof "$required")"
      if [ "$required_rank" -ge 1 ] && ! grep -qiE '^[[:space:]]*-[[:space:]]*Screenshot or visual observation:[[:space:]]*\S' "$proof"; then
        error "$(rel "$proof"): P1+ proof needs screenshot or visual observation"
      fi
      if [ "$required_rank" -ge 2 ] && ! grep -qiE '^[[:space:]]*-[[:space:]]*Main user flow tested:[[:space:]]*yes\b' "$proof"; then
        error "$(rel "$proof"): P2+ proof needs Main user flow tested: yes"
      fi
      if [ "$required_rank" -ge 3 ] && ! grep -qiE '^[[:space:]]*-[[:space:]]*Automated test result:[[:space:]]*pass\b' "$proof"; then
        error "$(rel "$proof"): P3+ proof needs Automated test result: pass"
      fi
      if [ "$required_rank" -ge 4 ]; then
        grep -qiE '^[[:space:]]*-[[:space:]]*CI result:[[:space:]]*pass\b' "$proof" || error "$(rel "$proof"): P4 proof needs CI result: pass"
        grep -qiE '^[[:space:]]*-[[:space:]]*GitHub diff available:[[:space:]]*yes\b' "$proof" || error "$(rel "$proof"): P4 proof needs GitHub diff available: yes"
      fi
    fi
  done < "$LEDGER"
fi

if [ -d "$ROOT/ldk/features" ]; then
  while IFS= read -r plan; do
    while IFS= read -r line; do
      echo "$line" | grep -qE '^\|' || continue
      echo "$line" | grep -qE '^\|[[:space:]]*(-+|ID)[[:space:]]*\|' && continue
      id="$(printf '%s\n' "$line" | awk -F'|' '{v=$2; gsub(/^[ \t]+|[ \t]+$/, "", v); print v}')"
      state="$(printf '%s\n' "$line" | awk -F'|' '{v=$(NF-1); gsub(/^[ \t]+|[ \t]+$/, "", v); print v}')"
      echo "$id" | grep -qE '^T[A-Za-z0-9_-]+$' || error "$(rel "$plan"): task row ID '$id' must start with T (example: T1)"
      valid_in "$state" backlog ready in-progress proof-pending done blocked || \
        error "$(rel "$plan"): invalid task state '$state'"
    done < "$plan"
  done < <(find "$ROOT/ldk/features" -name plan.md -type f)
fi

if [ -d "$ROOT/ldk" ]; then
  while IFS= read -r file; do
    count="$(grep -c '\[VERIFY\]' "$file" 2>/dev/null || true)"
    if [ "$count" -gt 0 ]; then
      echo "INFO  $(rel "$file"): $count [VERIFY]"
    fi
  done < <(find "$ROOT/ldk" -type f -name '*.md')
fi

echo "----------------------------------------"
echo "ldk-check: $ERRORS error(s), $WARNINGS warning(s)."
if [ "$ERRORS" -gt 0 ]; then
  exit 1
fi
exit 0
