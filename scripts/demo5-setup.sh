#!/usr/bin/env bash
# Demo 6 Setup: OpenSpec 規格驅動開發實戰
# 用途：管理 OpenSpec Demo 環境（對應 Part 8）
#
# 使用方式：
#   ./scripts/demo5-setup.sh show      # 展示已生成的 OpenSpec Proposal
#   ./scripts/demo5-setup.sh prepare   # 備份 slides.md（演講前執行）
#   ./scripts/demo5-setup.sh reset     # 還原 slides.md（移除 opsx:apply 加入的投影片）
#   ./scripts/demo5-setup.sh check     # 驗證 OpenSpec skills 是否可用

set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OPENSPEC_DIR="$REPO_DIR/.claude/skills"
SLIDES_FILE="$REPO_DIR/slides.md"
BACKUP_FILE="$REPO_DIR/slides.md.demo-backup"

case "${1:-help}" in
  show)
    # 尋找 OpenSpec 產生的 Proposal 檔案（通常在 .openspec/ 或 docs/specs/）
    PROPOSAL_DIRS=("$REPO_DIR/.openspec" "$REPO_DIR/docs/specs")
    found=false
    for dir in "${PROPOSAL_DIRS[@]}"; do
      if [ -d "$dir" ]; then
        echo "--- OpenSpec Proposals in $dir ---"
        find "$dir" -name "*.md" -type f | head -10 | while read -r f; do
          echo ""
          echo "=== $(basename "$f") ==="
          cat "$f"
        done
        found=true
      fi
    done
    if [ "$found" = false ]; then
      echo "[WARN] 尚未找到 Proposal 檔案。"
      echo "  請先執行 opsx:propose 產生 Proposal："
      echo "  claude 'opsx:propose 在投影片中新增一張介紹 OpenSpec 四個 Skills 的頁面'"
    fi
    ;;

  prepare)
    # 備份 slides.md，供 reset 時還原
    if [ -f "$SLIDES_FILE" ]; then
      cp "$SLIDES_FILE" "$BACKUP_FILE"
      echo "[OK] 已備份 slides.md -> slides.md.demo-backup"
    else
      echo "[WARN] slides.md 不存在，無法備份"
    fi
    ;;

  reset)
    # 還原 slides.md：優先使用備份，fallback 到 git checkout
    if [ -f "$BACKUP_FILE" ]; then
      cp "$BACKUP_FILE" "$SLIDES_FILE"
      rm "$BACKUP_FILE"
      echo "[CLEAN] 已從 slides.md.demo-backup 還原 slides.md"
    elif git -C "$REPO_DIR" ls-files --error-unmatch slides.md &>/dev/null; then
      git -C "$REPO_DIR" checkout -- slides.md 2>/dev/null && \
        echo "[CLEAN] 已還原 slides.md 到 git HEAD 版本（無備份，使用 git fallback）" || \
        echo "[WARN] git checkout 失敗，slides.md 可能不在 git 追蹤中"
      echo "[HINT] 下次請先執行 ./scripts/demo5-setup.sh prepare 建立備份"
    else
      echo "[WARN] 找不到 slides.md.demo-backup，且 slides.md 不在 git 追蹤中"
      echo "[HINT] 無法自動還原。請手動還原 slides.md，或先執行 prepare 建立備份。"
    fi
    # 清理 OpenSpec 可能產生的 Proposal 檔案（選用）
    if [ -d "$REPO_DIR/.openspec" ]; then
      echo "[INFO] .openspec/ 目錄存在，保留供下次 demo 使用"
      echo "  如需完全清除: rm -rf .openspec/"
    fi
    echo "[OK] Demo 6 (OpenSpec) 重置完成"
    ;;

  check)
    echo "--- 檢查 OpenSpec Skills ---"
    all_ok=true
    for skill in openspec-propose openspec-apply-change openspec-explore openspec-archive-change; do
      skill_dir="$OPENSPEC_DIR/$skill"
      if [ -d "$skill_dir" ]; then
        echo "[OK] $skill -> $skill_dir"
      else
        echo "[MISSING] $skill -> $skill_dir"
        all_ok=false
      fi
    done
    echo ""
    if [ "$all_ok" = true ]; then
      echo "[OK] 所有 OpenSpec skills 已就緒"
    else
      echo "[ERROR] 部分 OpenSpec skills 缺失，請確認 .claude/skills/ 內容"
      exit 1
    fi
    ;;

  *)
    echo "Usage: $0 {show|prepare|check|reset}"
    echo ""
    echo "  show      展示已生成的 OpenSpec Proposal"
    echo "  prepare   備份 slides.md（演講前執行）"
    echo "  check     驗證 OpenSpec skills 是否可用"
    echo "  reset     還原 slides.md（移除 opsx:apply 加入的投影片）"
    echo ""
    echo "Demo 流程："
    echo "  1. 事前: $0 prepare（備份 slides.md）"
    echo "  2. 事前: opsx:propose 產生 Proposal"
    echo "  3. 現場: 展示 Proposal -> 執行 opsx:apply"
    echo "  4. 重置: $0 reset"
    exit 1
    ;;
esac
