# Project: Agentic Coding Basics（技術演講簡報）

這是一場技術演講的完整素材庫，主題為「Agentic Coding：從個人工具到團隊基礎設施」。

## Tech Stack
- 簡報框架：Slidev（`pnpm dev` 啟動）
- Package Manager：pnpm
- 語言：Markdown（slides.md）、Bash（demo scripts）

## Project Structure
```
slides.md          # 投影片主體（Slidev Markdown）
scripts.md         # 講者稿與 Demo 操作步驟
OUTLINE.md         # 演講大綱與時間分配
.claude/
  agents/          # Subagent 定義（presentation-reviewer, slides-creator, demo-code-generator）
  skills/          # 自定義 Skills（slide-review, slidev 等）
  hooks/           # Hook 腳本（PostToolUse / PreToolUse）
  settings.json    # Hooks 與 MCP 設定
scripts/
  validate-slides.sh    # slides.md 品質掃描
  demo-prepare.sh       # 演講前一鍵準備
  demo-reset-all.sh     # 全部 Demo 還原
  demo2-setup.sh        # Demo 2: slide-review 違規注入/還原
  demo3-setup.sh        # Demo 3: hooks 環境驗證/還原
  demo4-setup.sh        # Demo 4: MCP GitHub 設定
  demo5-setup.sh        # Demo 6: OpenSpec reset/check
```

## File Ownership（嚴格執行）
| 檔案 | 負責 Agent |
|------|-----------|
| `OUTLINE.md` | presentation-reviewer（可直接修改）|
| `slides.md` | slides-creator |
| `scripts.md` | slides-creator |
| `scripts/` demo 腳本 | demo-code-generator |

不得跨越所有權界線直接修改其他 agent 負責的檔案。

## Slides 內容規則（CRITICAL）

### 禁止出現在 slides.md 的內容
- 時間資訊（如「8 min」、「90 分鐘」、「預計 X 分鐘」）
- 受眾標籤（如「軟體工程師」、「Team Lead」、「Tech Lead」）
- 任何 OUTLINE.md 的規劃備註或編輯資訊

以上內容只能出現在 `scripts.md`（講者稿）。

### 已確定的投影片設計決策（NEVER 違反）
1. **「五層演進架構」與「確定性 vs. 機率性」合併為單張投影片** — 兩個概念共存，透過 v-click 漸進揭露。NEVER 拆回兩張。
2. **禁止加入「今日旅程地圖」投影片** — NEVER 重新加入任何形式的旅程地圖或路線導覽投影片。

## Demo 架構

所有 Demo 均使用這個 repo 本身作為 demo 環境，不需要額外的 Next.js 或其他專案。

| Demo | Part | 工具 | 目標 |
|------|------|------|------|
| Demo 2 | Part 4 | `slide-review` skill | 審查 slides.md 品質 |
| Demo 3 | Part 5 | PostToolUse / PreToolUse hooks | 守護 slides.md 內容 |
| Demo 4 | Part 6 | GitHub MCP | 查詢 GitHub Issues |
| Demo 5 | Part 7 | `.claude/agents/`（presentation-reviewer）| 展示 Subagents 分工 |
| Demo 6 | Part 8 | `opsx:propose` + `opsx:apply` | OpenSpec 規格驅動開發 |

## Skills 規範
- Skill 定義放在 `.claude/skills/<name>/SKILL.md`（子目錄格式，非單一檔案）
- Hook 腳本放在 `.claude/hooks/`（非 `scripts/hooks/`）
- Demo 的 setup/reset 腳本放在 `scripts/`
