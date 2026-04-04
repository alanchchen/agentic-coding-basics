#!/usr/bin/env bash
# PreToolUse Hook: 安全攔截
# 阻止 AI 修改 .env、secrets、credentials 相關檔案
#
# Exit Codes:
#   0 = 繼續執行（檔案安全）
#   2 = 阻擋並顯示錯誤（檔案為敏感檔案）

FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-}"

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if echo "$FILE_PATH" | grep -qE '(\.env($|\.)|secrets|\.secret|credentials\.(json|yaml|yml|toml|xml|conf))'; then
  echo "BLOCKED: Cannot modify sensitive file: $FILE_PATH"
  echo ""
  echo "This file is protected by the security hook."
  echo "Sensitive files (.env, secrets, credentials.*) cannot be modified by AI."
  echo ""
  echo "If you need to update this file, please do it manually."
  exit 2
fi

exit 0
