#!/usr/bin/env bash
# PostToolUse Hook: 格式守衛
# AI 寫完檔案後自動執行 prettier 格式化
#
# Exit Codes:
#   0 = 繼續（格式化成功或非目標檔案）
#   1 = 警告但繼續（格式化失敗）

# Read tool input from stdin (Claude Code passes JSON via stdin)
INPUT=$(cat)

# Parse file path from JSON
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# 只格式化支援的副檔名
if echo "$FILE_PATH" | grep -qE '\.(ts|tsx|js|jsx|json|css|md|html|yaml|yml)$'; then
  if command -v npx &> /dev/null; then
    npx prettier --write "$FILE_PATH" 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "[FORMAT] Prettier applied to $FILE_PATH" >&2
      exit 0
    else
      echo "[WARN] Prettier failed for $FILE_PATH (continuing)" >&2
      exit 1
    fi
  else
    echo "[WARN] npx not found, skipping format" >&2
    exit 1
  fi
fi

exit 0
