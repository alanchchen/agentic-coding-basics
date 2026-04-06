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

# Demo 1: slide-review skill 已在 .claude/skills/ 中，隨 repo 常駐
echo "[STEP 1] Demo 1 就緒 (Skills 在 .claude/skills/slide-review/SKILL.md)"
echo "  演示時執行: cat .claude/skills/slide-review/SKILL.md"
echo ""

# Demo 2: Hooks 已在 .claude/settings.json 中，隨 repo 常駐
echo "[STEP 2] Demo 2 就緒 (Hooks 在 .claude/settings.json)"
echo "  演示時執行: cat .claude/settings.json | jq '.hooks'"
echo ""

# Demo 3: 檢查 GitHub Token
echo "[STEP 3] 檢查 Demo 3 前置條件..."
"$SCRIPTS_DIR/demo3-setup.sh" check
echo ""

# Demo 4: Subagents — 無需額外 setup
echo "[STEP 4] Demo 4 就緒 (Agents 在 .claude/agents/)"
echo ""

echo "========================================="
echo "  All demos prepared!"
echo "========================================="
echo ""
echo "Demo 流程提示："
echo ""
echo "  Demo 1 (6min): cat .claude/skills/slide-review/SKILL.md"
echo "                 ./scripts/demo1-setup.sh inject"
echo "                 claude '我剛更新了投影片，幫我做品質審查'"
echo ""
echo "  Demo 2 (5min): cat .claude/settings.json | jq '.hooks'"
echo "                 claude '幫我在 slides.md 加入一張新的 slide'"
echo "                 claude '在投影片加上這場演講的時間資訊：90 分鐘'"
echo ""
echo "  Demo 3 (3min): ./scripts/demo3-setup.sh show"
echo "                 claude '查看 GitHub 上最近的 3 個 open issue'"
echo ""
echo "  Demo 4 (5min): 展示 .claude/agents/ 下的 Agent 定義"
echo "                 claude '請 presentation-reviewer 審查投影片'"
echo ""
