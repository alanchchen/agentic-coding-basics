#!/usr/bin/env bash
# Master Reset: 重置所有 Demo 到初始狀態
# 在演講開始前或練習結束後執行
#
# 使用方式：
#   ./scripts/demo-reset-all.sh

set -euo pipefail

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================="
echo "  Agentic Coding Basics - Demo Reset"
echo "========================================="
echo ""

# Demo 1: Skills
echo "[1/4] 重置 Demo 1 (Skills - slide-review)..."
"$SCRIPTS_DIR/demo1-setup.sh" reset 2>/dev/null || true
echo ""

# Demo 2: Hooks
echo "[2/4] 重置 Demo 2 (Hooks - validate-slides)..."
"$SCRIPTS_DIR/demo2-setup.sh" reset 2>/dev/null || true
echo ""

# Demo 3: MCP (no persistent state to clean)
echo "[3/4] 重置 Demo 3 (MCP)..."
echo "[OK] MCP Demo 無需清理"
echo ""

# Demo 4: Subagents (no persistent state to clean)
echo "[4/5] 重置 Demo 4 (Subagents)..."
echo "[OK] Subagents Demo 無需清理"
echo ""

echo ""
echo "========================================="
echo "  All demos reset to initial state"
echo "========================================="
echo ""
echo "接下來執行 ./scripts/demo-prepare.sh 準備 Demo 環境"
