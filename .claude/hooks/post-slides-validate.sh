#!/usr/bin/env bash
# PostToolUse Hook: 投影片品質驗證
# AI 編輯 slides.md 後，自動執行 validate-slides.sh 掃描全文
#
# Exit Codes:
#   0 = 繼續（驗證通過或非 slides.md）
#   1 = 警告但繼續（驗證失敗，提示違規）

# Read tool input from stdin (Claude Code passes JSON via stdin)
INPUT=$(cat)

# Parse file path from JSON
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only validate when slides.md is modified
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if ! echo "$FILE_PATH" | grep -q "slides\.md"; then
  exit 0
fi

# Run the validation script
REPO_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
VALIDATE_SCRIPT="$REPO_DIR/scripts/validate-slides.sh"

if [ -f "$VALIDATE_SCRIPT" ]; then
  bash "$VALIDATE_SCRIPT"
  RESULT=$?
  if [ "$RESULT" -ne 0 ]; then
    echo ""
    echo "投影片品質驗證未通過，請修正上述違規內容。"
    exit 1
  fi
else
  echo "[WARN] validate-slides.sh not found at $VALIDATE_SCRIPT"
  exit 0
fi

exit 0
