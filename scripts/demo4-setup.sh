#!/usr/bin/env bash
# Demo 4 Setup: MCP 跨工具協作
# 用途：展示 MCP 設定並驗證 GitHub MCP 連線
#
# 使用方式：
#   ./scripts/demo4-setup.sh show      # 展示 MCP 設定內容
#   ./scripts/demo4-setup.sh check     # 檢查 GitHub Token 並驗證 API 連線

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SETTINGS_FILE="$REPO_DIR/.claude/settings.json"

case "${1:-help}" in
  show)
    echo "--- MCP 設定 (from .claude/settings.json) ---"
    if command -v jq &> /dev/null; then
      jq '.mcpServers' "$SETTINGS_FILE"
    else
      cat "$SETTINGS_FILE"
    fi
    echo ""
    echo "說明："
    echo "  GitHub MCP Server 讓 AI 能直接查詢 GitHub API"
    echo "  包括：Issue 列表、PR 資訊、Branch 管理等"
    ;;

  check)
    PASS=true

    # Step 1: 檢查 Token 是否存在
    echo "=== GitHub API 預檢 ==="
    echo ""
    if [ -n "${GITHUB_TOKEN:-}" ]; then
      echo "[OK] GITHUB_TOKEN 已設定"
      echo "     Token 前 8 字元: ${GITHUB_TOKEN:0:8}..."
    else
      echo "[FAIL] GITHUB_TOKEN 未設定"
      echo ""
      echo "  請設定環境變數："
      echo "    export GITHUB_TOKEN=ghp_your_token_here"
      echo ""
      echo "  或使用 gh auth token 取得："
      echo '    export GITHUB_TOKEN=$(gh auth token)'
      PASS=false
    fi

    echo ""

    # Step 2: 驗證 API 實際可用性
    if [ "$PASS" = true ]; then
      echo "--- 驗證 GitHub API 連線 ---"
      HTTP_CODE=$(curl -s -o /tmp/gh-api-check.json -w "%{http_code}" \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Accept: application/vnd.github+json" \
        https://api.github.com/user 2>/dev/null || echo "000")

      if [ "$HTTP_CODE" = "200" ]; then
        USERNAME=$(cat /tmp/gh-api-check.json | grep -o '"login":"[^"]*"' | head -1 | cut -d'"' -f4)
        echo "[OK] API 連線成功 (HTTP $HTTP_CODE)"
        echo "     登入身份: $USERNAME"
      elif [ "$HTTP_CODE" = "401" ]; then
        echo "[FAIL] Token 無效或已過期 (HTTP 401)"
        echo "  請重新產生 Token 或執行："
        echo '    export GITHUB_TOKEN=$(gh auth token)'
        PASS=false
      elif [ "$HTTP_CODE" = "000" ]; then
        echo "[FAIL] 無法連線到 GitHub API（網路問題）"
        echo "  請確認網路連線正常"
        PASS=false
      else
        echo "[FAIL] GitHub API 回應異常 (HTTP $HTTP_CODE)"
        cat /tmp/gh-api-check.json 2>/dev/null || true
        PASS=false
      fi
      rm -f /tmp/gh-api-check.json
    fi

    echo ""
    if [ "$PASS" = true ]; then
      echo "=== 預檢通過：Demo 4 已就緒 ==="
    else
      echo "=== 預檢失敗：請修正上述問題後重試 ==="
      exit 1
    fi
    ;;

  *)
    echo "Usage: $0 {show|check}"
    echo ""
    echo "  show     展示 MCP 設定"
    echo "  check    檢查 GitHub Token 並驗證 API 連線"
    echo ""
    echo "注意：MCP 設定已整合在 .claude/settings.json 中，隨 repo 一起管理。"
    exit 1
    ;;
esac
