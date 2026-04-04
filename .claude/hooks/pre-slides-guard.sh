#!/usr/bin/env bash
# PreToolUse Hook: 投影片時間資訊攔截
# 在 AI 寫入 slides.md 前，檢查內容是否包含時間關鍵字
# 如果包含，阻擋寫入並顯示錯誤訊息
#
# Exit Codes:
#   0 = 繼續執行（非 slides.md 或內容無違規）
#   2 = 阻擋並顯示錯誤（偵測到時間資訊）

# Get the file path from Claude's environment
FILE_PATH="${CLAUDE_TOOL_INPUT_FILE_PATH:-}"

# Only check writes to slides.md
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if ! echo "$FILE_PATH" | grep -q "slides\.md"; then
  exit 0
fi

# Get the content that is about to be written
CONTENT="${CLAUDE_TOOL_INPUT_CONTENT:-}"
NEW_STRING="${CLAUDE_TOOL_INPUT_NEW_STRING:-}"

# Check both possible content sources (Write uses content, Edit uses new_string)
CHECK_TEXT="${CONTENT}${NEW_STRING}"

if [ -z "$CHECK_TEXT" ]; then
  exit 0
fi

# Check for time-related patterns in the content
if echo "$CHECK_TEXT" | grep -qE '[0-9]+\s*(分鐘|min\b|小時|hour)'; then
  echo "BLOCKED: Time information not allowed in slides.md"
  echo ""
  echo "偵測到時間相關內容即將寫入投影片。"
  echo "時間資訊應放在講者稿 (scripts.md)，不應出現在投影片上。"
  exit 2
fi

# Check for audience labels
if echo "$CHECK_TEXT" | grep -qE '(軟體工程師|Team Lead|Tech Lead)'; then
  echo "BLOCKED: Audience labels not allowed in slides.md"
  echo ""
  echo "偵測到受眾標籤即將寫入投影片。"
  echo "受眾資訊屬於內部文件，不應出現在投影片上。"
  exit 2
fi

exit 0
