#!/usr/bin/env bash
# Demo 1 Setup: Skills (slide-review) 實作
# 用途：在 slides.md 植入刻意違規以供 Demo 演示，或還原乾淨狀態
#
# 使用方式：
#   ./scripts/demo1-setup.sh inject    # 植入違規內容
#   ./scripts/demo1-setup.sh reset     # 移除違規，還原乾淨狀態
#   ./scripts/demo1-setup.sh status    # 檢查目前是否有違規植入

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SLIDES_FILE="$REPO_DIR/slides.md"

# The marker we inject — a speaker note containing time info
# We inject it into the Demo 1 placeholder slide's section
INJECTION_MARKER="<!-- demo2-injection -->"
INJECTION_LINE="> 適合 90 分鐘場次"
INJECTION_FULL="${INJECTION_LINE} ${INJECTION_MARKER}"

# Target: the line after the Demo 1 placeholder slide description
# We look for the unique line in the Demo 1 slide
TARGET_LINE="用 slide-review Skill 現場審查這場演講的投影片"

case "${1:-help}" in
  inject)
    # Idempotent: check if already injected
    if grep -q "$INJECTION_MARKER" "$SLIDES_FILE" 2>/dev/null; then
      echo "[OK] 違規內容已存在，無需重複植入"
      grep -n "$INJECTION_MARKER" "$SLIDES_FILE"
      exit 0
    fi

    # Find the target line and inject after it
    if ! grep -q "$TARGET_LINE" "$SLIDES_FILE"; then
      echo "[ERROR] 找不到目標行: $TARGET_LINE"
      echo "slides.md 結構可能已變更，請手動檢查"
      exit 1
    fi

    # Use sed to insert after the target line
    if [[ "$(uname)" == "Darwin" ]]; then
      sed -i '' "/$TARGET_LINE/a\\
\\
${INJECTION_FULL}
" "$SLIDES_FILE"
    else
      sed -i "/$TARGET_LINE/a\\\\n${INJECTION_FULL}" "$SLIDES_FILE"
    fi

    echo "[INJECT] 已在 slides.md 植入違規內容："
    grep -n "$INJECTION_MARKER" "$SLIDES_FILE"
    echo ""
    echo "違規內容：$INJECTION_LINE"
    echo "用途：Demo 1 展示 slide-review Skill 偵測此違規"
    ;;

  reset)
    # Idempotent: remove injection if present
    if grep -q "$INJECTION_MARKER" "$SLIDES_FILE" 2>/dev/null; then
      if [[ "$(uname)" == "Darwin" ]]; then
        sed -i '' "/$INJECTION_MARKER/d" "$SLIDES_FILE"
      else
        sed -i "/$INJECTION_MARKER/d" "$SLIDES_FILE"
      fi
      # Also clean up any trailing blank line left by the injection
      if [[ "$(uname)" == "Darwin" ]]; then
        sed -i '' '/^$/N;/^\n$/d' "$SLIDES_FILE"
      fi
      echo "[CLEAN] 已移除植入的違規內容"
    else
      echo "[OK] slides.md 沒有植入的違規內容，無需清理"
    fi

    # Also clean up any demo-generated report files
    for f in "$REPO_DIR/slide-review-report.md" "$REPO_DIR/docs/slide-review-report.md"; do
      if [ -f "$f" ]; then
        rm "$f"
        echo "[CLEAN] 已刪除 $f"
      fi
    done

    echo "[OK] Demo 1 重置完成"
    ;;

  status)
    if grep -q "$INJECTION_MARKER" "$SLIDES_FILE" 2>/dev/null; then
      echo "[STATUS] 違規內容已植入："
      grep -n "$INJECTION_MARKER" "$SLIDES_FILE"
    else
      echo "[STATUS] slides.md 乾淨，無植入違規"
    fi
    ;;

  *)
    echo "Usage: $0 {inject|reset|status}"
    echo ""
    echo "  inject   在 slides.md 植入刻意違規（> 適合 90 分鐘場次）"
    echo "  reset    移除違規，還原 slides.md 到乾淨狀態"
    echo "  status   檢查目前是否有違規植入"
    echo ""
    echo "Skill 檔案位置: .claude/skills/slide-review/SKILL.md"
    exit 1
    ;;
esac
