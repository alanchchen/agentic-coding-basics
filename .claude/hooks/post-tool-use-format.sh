#!/usr/bin/env bash
# PostToolUse Hook: 格式守衛
# AI 寫完檔案後自動執行 prettier 格式化
#
# Exit Codes:
#   0 = 繼續（格式化成功或非目標檔案）
#   1 = 警告但繼續（格式化失敗）

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-}"

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# 只格式化支援的副檔名
if echo "$FILE_PATH" | grep -qE '\.(ts|tsx|js|jsx|json|css|md|html|yaml|yml)$'; then
  if command -v npx &> /dev/null; then
    npx prettier --write "$FILE_PATH" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "[FORMAT] Prettier applied to $FILE_PATH"
      exit 0
    else
      echo "[WARN] Prettier failed for $FILE_PATH (continuing)"
      exit 1
    fi
  else
    echo "[WARN] npx not found, skipping format"
    exit 1
  fi
fi

exit 0
