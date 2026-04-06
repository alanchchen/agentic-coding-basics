#!/usr/bin/env bash
# validate-slides.sh — 投影片品質守衛腳本
# 掃描 slides.md 中不應出現的 forbidden patterns
#
# Exit Codes:
#   0 = 通過，沒有違規
#   1 = 發現違規
#
# 用法：
#   bash scripts/validate-slides.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SLIDES_FILE="$REPO_DIR/slides.md"

if [ ! -f "$SLIDES_FILE" ]; then
  echo "[GUARD] ERROR: slides.md not found at $SLIDES_FILE"
  exit 1
fi

# Strip HTML comments (<!-- ... -->, possibly multi-line) before scanning.
# This prevents speaker notes embedded in comments from triggering false positives.
STRIPPED_CONTENT=$(perl -0777 -pe 's/<!--.*?-->//gs' "$SLIDES_FILE")

FOUND_VIOLATIONS=0
IN_CODE_BLOCK=0

while IFS= read -r line || [ -n "$line" ]; do
  LINE_NUM=$((${LINE_NUM:-0} + 1))

  # Track code block boundaries (``` fenced blocks)
  if echo "$line" | grep -qE '^\s*```'; then
    if [ "$IN_CODE_BLOCK" -eq 0 ]; then
      IN_CODE_BLOCK=1
    else
      IN_CODE_BLOCK=0
    fi
    continue
  fi

  # Skip lines inside code blocks
  if [ "$IN_CODE_BLOCK" -eq 1 ]; then
    continue
  fi

  # Check for session/time-allocation patterns
  # These catch time metadata (session length, time budget) but NOT narrative uses
  # like "浪費 3 小時" or "15 分鐘的 Spec 撰寫" which are valid slide content
  if echo "$line" | grep -qE '\b[0-9]+\s*min\b'; then
    MATCH=$(echo "$line" | grep -oE '[0-9]+\s*min' | head -1)
    echo "[GUARD] WARN: forbidden pattern found: \"$MATCH\" on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

  if echo "$line" | grep -qE '(場次|適合|時間分配|共計|總計|預計).*分鐘|分鐘.*(場次|演講|分享)'; then
    MATCH=$(echo "$line" | grep -oE '.*分鐘.*' | head -1)
    echo "[GUARD] WARN: forbidden pattern found: \"分鐘\" (session context) on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

  if echo "$line" | grep -qE '(場次|適合|時間分配|共計|總計|預計).*小時|小時.*(場次|演講|分享)'; then
    MATCH=$(echo "$line" | grep -oE '.*小時.*' | head -1)
    echo "[GUARD] WARN: forbidden pattern found: \"小時\" (session context) on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

  # Check for audience label patterns
  if echo "$line" | grep -q '軟體工程師'; then
    echo "[GUARD] WARN: forbidden pattern found: \"軟體工程師\" on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

  if echo "$line" | grep -q 'Team Lead'; then
    echo "[GUARD] WARN: forbidden pattern found: \"Team Lead\" on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

  if echo "$line" | grep -q 'Tech Lead'; then
    echo "[GUARD] WARN: forbidden pattern found: \"Tech Lead\" on line $LINE_NUM"
    FOUND_VIOLATIONS=1
  fi

done <<< "$STRIPPED_CONTENT"

if [ "$FOUND_VIOLATIONS" -eq 1 ]; then
  echo ""
  echo "[GUARD] FAILED: slides.md contains forbidden patterns. Please fix the violations above."
  exit 1
else
  echo "[GUARD] OK: slides.md passed quality check"
  exit 0
fi
