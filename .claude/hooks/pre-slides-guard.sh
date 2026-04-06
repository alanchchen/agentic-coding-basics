#!/usr/bin/env bash
# PreToolUse Hook: 投影片時間資訊攔截
# 在 AI 寫入 slides.md 前，檢查內容是否包含時間關鍵字
# 如果包含，阻擋寫入並顯示錯誤訊息
#
# Exit Codes:
#   0 = 繼續執行（非 slides.md 或內容無違規）
#   2 = 阻擋並顯示錯誤（偵測到時間資訊）

# Read tool input from stdin (Claude Code passes JSON via stdin)
INPUT=$(cat)

# Parse file path from JSON
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only check writes to slides.md
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if ! echo "$FILE_PATH" | grep -q "slides\.md"; then
  exit 0
fi

# Get the content that is about to be written
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty')
NEW_STRING=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty')

# Check both possible content sources (Write uses content, Edit uses new_string)
CHECK_TEXT="${CONTENT}${NEW_STRING}"

if [ -z "$CHECK_TEXT" ]; then
  exit 0
fi

# Check for time-related patterns in the content
if echo "$CHECK_TEXT" | grep -qE '[0-9]+\s*(分鐘|min\b|小時|hour)'; then
  echo "BLOCKED: Time information not allowed in slides.md" >&2
  echo "" >&2
  echo "偵測到時間相關內容即將寫入投影片。" >&2
  echo "時間資訊應放在講者稿（slides.md 的 HTML comment 區塊），不應出現在投影片可見內容中。" >&2
  exit 2
fi

# Check for audience labels
if echo "$CHECK_TEXT" | grep -qE '(軟體工程師|Team Lead|Tech Lead)'; then
  echo "BLOCKED: Audience labels not allowed in slides.md" >&2
  echo "" >&2
  echo "偵測到受眾標籤即將寫入投影片。" >&2
  echo "受眾資訊屬於內部文件，不應出現在投影片可見內容中。" >&2
  exit 2
fi

exit 0
