# Agentic Coding 實戰
## 從 Chat UI 到 Claude Code

**總時長：90 分鐘｜對象：軟體工程師**

---

## Part 0｜開場與破冰
> 5 min

- 互動提問：你們現在怎麼用 AI 寫代碼？
- Chat UI 模式的典型痛點
  - 重複 paste context
  - 沒有記憶
  - 無法自動化
  - 每個人 AI 行為不一致
- **今天的目標**：讓 AI 從「聰明的 autocomplete」升級成**團隊共用的自動化 coding agent**

---

## Part 1｜心智模型轉換：從 Chat 到 Agent
> 8 min

### 核心架構：四層

| 層次 | 工具 | 特性 |
|------|------|------|
| 永久記憶 | `CLAUDE.md` | 每次 session 都讀，確定性 |
| 可重用流程 | `Skills` | AI 判斷時機，或手動呼叫 |
| 自動化守衛 | `Hooks` | 事件觸發，完全確定性 |
| 外部整合 | `MCP` | 連接第三方工具與資料 |

> 💡 **核心心智模型**：CLAUDE.md + Hooks 是確定性的，Skills + Agents 是機率性的。
> 設計時先想清楚你要的是「每次都發生」還是「AI 判斷時發生」。

### 今天的敘事弧線 (The Narrative Arc)

```
[被動記憶] CLAUDE.md 
  → [主動工作流] Skills 
  → [強制守衛] Hooks 
  → [打破邊界] MCP 
  → [團隊共享] Git 
  → [專業分工] Subagents 
  → [最終對齊] SDD (OpenSpec)
```

---

## Part 2｜CLAUDE.md — 給 AI 的長期記憶
> 12 min

**演進邏輯：** 「AI 雖然聰明，但每次開新 Session 都要重教一遍（專案架構、規範）。我們需要一個**被動的長期記憶**，讓 AI 一進場就進入狀況。」

### 是什麼
- 每個 session 啟動時自動讀取的 Markdown 指令檔
- 分層：全域 (`~/.claude/CLAUDE.md`) vs 專案 (`.claude/CLAUDE.md`)

### 寫什麼
- 專案架構概述（讓 AI 不用每次重新摸索）
- 技術棧 & 命名慣例
- 禁止行為（不得修改 `migrations/`、不得直接 push main）
- 常用指令：`pnpm dev`、`pnpm test` 等

### 🎯 Demo
展示有無 CLAUDE.md 時，AI 對同一個問題的第一個回應差異。

---

## Part 3｜Skills — 從「被動記憶」到「主動工作流」
> 12 min

**演進邏輯：** 「有了記憶後，AI 知道『規則』了，但它還是被動等我下指令。我們能不能把重複的 SOP (如 Code Review, PR 撰寫) 變成**主動觸發的技能**？」

### 是什麼
- 放在 `.claude/skills/<name>/SKILL.md` 的指令包
- AI 會根據當前情境自動決定是否使用，也可手動呼叫

### 關鍵設計：Description
- Description 優化好可將 AI 自動觸發率從 20% 提升到 90%
- 把團隊的隱性 SOP 編碼進 skill

### 🎯 Demo
建立 `code-review` skill，展示 AI 在你說「幫我看這段修改」時自動觸發專家級 Review。

---

## Part 4｜Hooks — 從「機率觸發」到「確定性守護」
> 12 min

**演進邏輯：** 「Skill 是讓 AI *『可以』* 怎麼做，但它是機率性的（AI 可能忘記）。對於底線 (如 Lint, Format, Security)，我們需要 **100% 確定觸發的守衛**。」

### 是什麼
- 事件驅動腳本（PreToolUse, PostToolUse）
- **不依賴 AI 判斷**，只要觸發特定行為就執行

### 實用場景
- 寫檔後自動跑 Lint (PostToolUse)
- 阻止寫入敏感目錄或 Secrets (PreToolUse)

### 🎯 Demo
1. PostToolUse → 寫檔後自動跑 `prettier`。
2. PreToolUse → 偵測到寫入 `.env` 時強制阻止。

---

## Part 5｜MCP — 打破本機 Codebase 的圍牆
> 7 min

**演進邏輯：** 「現在 AI 在本機已經被管得很好了。但軟體開發不只是寫 code，我們需要連接 Issue、PR、文件，甚至外部 API。我們要讓 AI **具備連接外部世界的插槽**。」

### 是什麼
- Model Context Protocol：讓 Claude Code 呼叫外部服務的標準介面
- 從「唯讀代碼」變成「操作 GitHub/Slack/Jira」

### 🎯 Demo
AI 透過 MCP 查詢 GitHub issue，直接在 terminal 產出對應的修改。

---

## Part 6｜團隊協作 — 把 AI 設定納入版本控制 (Git)
> 8 min

**演進邏輯：** 「如果只有我一個人的 AI 具備記憶、技能、守衛與外部連接，團隊效率還是低。我們要把這些 AI 基礎設施**像 Code 一樣 Commit 進 Git**。」

### 核心主張
> CLAUDE.md、Skills、Hooks 不是個人偏好，是**團隊的工程基礎設施**。

### 具體價值
- **新人 Onboarding**：Clone repo 即獲得專家級 AI 輔助，零口頭交接。
- **行為一致性**：所有人共享相同的 AI 守衛與規範。

---

## Part 7｜Subagents — 從「單一大腦」到「專業分工」
> 8 min（無 Demo）

**演進邏輯：** 「當全團隊都開始用 Agent 處理複雜任務時，單一 AI 的大腦容量 (Context) 會失焦。我們需要透過 **Subagents** 來實現分工與『互相監督』。」

### 單一 Agent 的問題
- Context 污染：規劃者與實作者是同一人，容易產生偏差。

### 角色分工 (Orchestration)
- Planner (不寫代碼) ↔ Engineer (只管實作) ↔ QA (獨立驗證)
- **互相監督**：QA 用不同 Context 驗證代碼，比同一個 AI 自問自答可靠得多。

---

## Part 8｜SDD — 最終對齊：基於 OpenSpec 的規格驅動開發
> 12 min

**演進邏輯：** 「工具、分工、守衛都到位了，最後一個失敗點是：如果我們給的指令本身就很模糊，AI 還是會做錯。我們要用**規格文件 (Spec)** 作為最後的對齊關鍵。」

### SDD 核心流程
1. 寫 Spec (邊界、成功標準、約束)
2. 人工審查對齊
3. AI 實作 (Hooks 守護，Subagents 分工)
4. 對照 Spec 驗收

### 🎯 Demo
完整短循環：寫 Spec → AI 提問澄清 → 實作 → 依據 Spec 驗收。

---

## Part 9｜Q&A & 總結
> 8 min

### 總結
從個人習慣，演進到全團隊共享的 **Agentic Development Workflow**。

---

## 時間總覽 (合計 92 min)
| 段落 | 內容 | 時間 |
|------|------|------|
| Part 0-1 | 開場與心智模型 | 13 min |
| Part 2-4 | 長期記憶、技能與守護 (核心三層) | 36 min |
| Part 5 | MCP 外部擴充 | 7 min |
| Part 6 | 團隊 Git 基礎設施化 | 8 min |
| Part 7-8 | 分工、監督與 SDD 最終對齊 | 20 min |
| Part 9 | Q&A | 8 min |
