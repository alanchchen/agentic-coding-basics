#!/usr/bin/env bash
# Demo 3 Setup: Hooks 自動化守衛
# 用途：確保 Demo 3 的環境就緒（hooks 設定、slides.md 乾淨）
#
# 使用方式：
#   ./scripts/demo3-setup.sh reset    # 確保 slides.md 乾淨（清除 demo2 injection）
#   ./scripts/demo3-setup.sh check    # 驗證 hooks 設定是否正確

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SETTINGS_FILE="$REPO_DIR/.claude/settings.json"
SLIDES_FILE="$REPO_DIR/slides.md"
VALIDATE_SCRIPT="$REPO_DIR/scripts/validate-slides.sh"

case "${1:-help}" in
  reset)
    # Step 1: Clean up any demo2 injection leftover
    echo "=== 清理 Demo 2 遺留 ==="
    bash "$REPO_DIR/scripts/demo2-setup.sh" reset

    # Step 2: Run validate-slides.sh to confirm slides.md is clean
    echo ""
    echo "=== 驗證 slides.md 狀態 ==="
    if bash "$VALIDATE_SCRIPT"; then
      echo "[OK] slides.md 已乾淨，Demo 3 可以開始"
    else
      echo "[WARN] slides.md 仍有違規內容，請手動檢查"
      exit 1
    fi
    ;;

  check)
    echo "=== 檢查 Hooks 設定 ==="
    ERRORS=0

    # Check settings.json exists
    if [ ! -f "$SETTINGS_FILE" ]; then
      echo "[FAIL] .claude/settings.json 不存在"
      ERRORS=$((ERRORS + 1))
    else
      echo "[OK] .claude/settings.json 存在"

      # Check PostToolUse hook for slides validation
      if grep -q "post-slides-validate.sh" "$SETTINGS_FILE"; then
        echo "[OK] PostToolUse hook: post-slides-validate.sh 已設定"
      else
        echo "[FAIL] PostToolUse hook: 找不到 post-slides-validate.sh"
        ERRORS=$((ERRORS + 1))
      fi

      # Check PreToolUse hook for slides.md time blocking
      if grep -q "BLOCKED.*Time information" "$SETTINGS_FILE" || grep -q "pre-slides-guard" "$SETTINGS_FILE"; then
        echo "[OK] PreToolUse hook: slides.md 時間攔截已設定"
      else
        echo "[FAIL] PreToolUse hook: 找不到 slides.md 時間攔截設定"
        ERRORS=$((ERRORS + 1))
      fi
    fi

    # Check validate-slides.sh exists and is executable
    if [ -f "$VALIDATE_SCRIPT" ]; then
      echo "[OK] scripts/validate-slides.sh 存在"
      if [ -x "$VALIDATE_SCRIPT" ]; then
        echo "[OK] scripts/validate-slides.sh 可執行"
      else
        echo "[WARN] scripts/validate-slides.sh 不可執行，請執行: chmod +x scripts/validate-slides.sh"
      fi
    else
      echo "[FAIL] scripts/validate-slides.sh 不存在"
      ERRORS=$((ERRORS + 1))
    fi

    echo ""
    if [ "$ERRORS" -eq 0 ]; then
      echo "[OK] 所有 Hooks 設定檢查通過，Demo 3 準備就緒"
    else
      echo "[FAIL] 有 $ERRORS 個問題需要修正"
      exit 1
    fi
    ;;

  *)
    echo "Usage: $0 {reset|check}"
    echo ""
    echo "  reset    清除 slides.md 的違規內容（含 demo2 遺留）"
    echo "  check    驗證 hooks 設定是否正確存在"
    echo ""
    echo "相關檔案："
    echo "  .claude/settings.json     — Hooks 設定"
    echo "  scripts/validate-slides.sh — PostToolUse 驗證腳本"
    exit 1
    ;;
esac
