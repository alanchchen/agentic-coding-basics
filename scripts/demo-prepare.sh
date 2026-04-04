#!/usr/bin/env bash
# Demo Prepare: 一鍵準備所有 Demo 環境
# 在演講開始前執行，設置所有 Demo 所需的前置條件
#
# 使用方式：
#   ./scripts/demo-prepare.sh

set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================="
echo "  Agentic Coding Basics - Demo Prepare"
echo "========================================="
echo ""

# 先重置一切
echo "[STEP 0] 先重置所有 Demo..."
"$SCRIPTS_DIR/demo-reset-all.sh"
echo ""

# Demo 2: slide-review skill 已在 .claude/skills/ 中，隨 repo 常駐
echo "[STEP 1] Demo 2 就緒 (Skills 在 .claude/skills/slide-review/SKILL.md)"
echo "  演示時執行: cat .claude/skills/slide-review/SKILL.md"
echo ""

# Demo 3: Hooks 已在 .claude/settings.json 中，隨 repo 常駐
echo "[STEP 2] Demo 3 就緒 (Hooks 在 .claude/settings.json)"
echo "  演示時執行: cat .claude/settings.json | jq '.hooks'"
echo ""

# Demo 4: 檢查 GitHub Token
echo "[STEP 3] 檢查 Demo 4 前置條件..."
"$SCRIPTS_DIR/demo4-setup.sh" check
echo ""

# Demo 5: Subagents — 無需額外 setup
echo "[STEP 4] Demo 5 就緒 (Agents 在 .claude/agents/)"
echo ""

# Demo 6: OpenSpec — 檢查 skills 是否存在，並備份 slides.md
echo "[STEP 5] 檢查 Demo 6 (OpenSpec) 前置條件..."
"$SCRIPTS_DIR/demo5-setup.sh" check
echo ""
echo "[STEP 5b] 備份 slides.md（供 Demo 6 reset 使用）..."
"$SCRIPTS_DIR/demo5-setup.sh" prepare
echo ""
echo "  [重要] Demo 6 事前準備："
echo "  請手動執行 opsx:propose 產生 Proposal："
echo "    claude 'opsx:propose 在投影片中新增一張介紹 OpenSpec 四個 Skills 的頁面'"
echo "  產生後可用 ./scripts/demo5-setup.sh show 確認內容"
echo ""

echo "========================================="
echo "  All demos prepared!"
echo "========================================="
echo ""
echo "Demo 流程提示："
echo ""
echo "  Demo 2 (6min): cat .claude/skills/slide-review/SKILL.md"
echo "                 ./scripts/demo2-setup.sh inject"
echo "                 claude '我剛更新了投影片，幫我做品質審查'"
echo ""
echo "  Demo 3 (5min): cat .claude/settings.json | jq '.hooks'"
echo "                 claude '幫我在 slides.md 加入一張新的 slide'"
echo "                 claude '在投影片加上這場演講的時間資訊：90 分鐘'"
echo ""
echo "  Demo 4 (3min): ./scripts/demo4-setup.sh show"
echo "                 claude '查看 GitHub 上最近的 3 個 open issue'"
echo ""
echo "  Demo 5 (5min): 展示 .claude/agents/ 下的 Agent 定義"
echo "                 claude '請 presentation-reviewer 審查投影片'"
echo ""
echo "  Demo 6 (5min): ./scripts/demo5-setup.sh show     # 展示預先產生的 Proposal"
echo "                 claude 'opsx:apply'               # 現場執行，新投影片即時出現"
echo "                 ./scripts/demo5-setup.sh reset    # 重置 slides.md"
echo ""
