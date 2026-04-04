# Agentic Coding：從個人工具到團隊基礎設施
## 從 Chat UI 到 Claude Code 的演進之路

---

## Part 0｜開場：AI 寫代碼的「天花板」
> 6 min

- **互動提問**：為什麼有了 AI，你的開發速度沒有提升 10 倍？
- **Chat UI 的瓶頸**：Context 碎片化、知識無法傳承、行為不可預測。
- **今日核心**：分享如何透過 `.claude/` 設定，將 Claude Code 轉化為團隊的「數位工程師」，實現規格驅動 (SDD) 與自動化守護。

---

## Part 1｜Claude Code 初探：這不是另一個 Chat UI
> 5 min

- **Claude Code 是什麼**：跑在終端機裡的 CLI 工具，不是網頁聊天介面。它能讀你的檔案、執行指令、寫入程式碼——在你的本機環境裡直接動手。
- **與 Chat UI 最大的差異**：Chat UI 每次對話都是空白記憶。Claude Code 能讀取 Repo 裡的設定檔，讓 AI 帶著專案知識醒來。
- **`.claude/` 目錄**：Claude Code 的設定家目錄。這裡放的東西，決定 AI 在這個專案裡的行為、記憶、技能與守衛。它是一份跟著 Git 走的「AI 行為合約」。
- **破冰示意**：用一張圖對比「Chat UI 的對話泡泡」vs「Claude Code 讀取 Repo 的實際畫面」，建立視覺錨點。

---

## Part 2｜架構思維：Agentic Workflow 的五層演進
> 6 min

- **為什麼 `.claude/` 應該跟著 Git 走**：設定即代碼，共同維護，版本可追溯——這才是讓 AI 成為團隊成員而非個人玩具的關鍵。
- **五層架構模型**：
  1. **記憶 (Memory)**：`CLAUDE.md` - 專案知識與開發規範。
  2. **技能 (Skills)**：`Skills` - 將重複的 SOP 編碼化為工具。
  3. **守衛 (Governance)**：`Hooks` - 確保 AI 行為符合預期的自動化檢查。
  4. **連結 (Connectivity)**：`MCP` - 打破本機邊界，連接 GitHub、Database、Monitoring 等外部系統。
  5. **分工 (Delegation)**：`Agents` - 定義在 `.claude/agents/`，實現角色專業化與任務委派。
- **實戰敘事弧線**：記憶 → 技能 → 守衛 → MCP 外部連接 → Agents 專業分工 → SDD 規格對齊。

---

## Part 3｜長期記憶：告別「每次都要重教」
> 7 min

- **核心經驗**：CLAUDE.md 不是 README，它是「入職手冊」。
- **結構解說**：用這場演講本身的 CLAUDE.md 為例，現場打開講解三個層次：
  1. **技術棧鎖定**：明確告訴 AI 用什麼、不用什麼（框架、套件、禁止語法）。
  2. **邊界定義**：哪些目錄絕對不能碰、哪些操作需要走固定流程。
  3. **行為合約**：讓 AI 的輸出有可預期的形狀（命名規則、回傳格式、文件結構）。
- **關鍵觀念**：CLAUDE.md 跟著 Git 走，等於把「入職訓練」版本控制了。新成員 clone repo，AI 就已經知道規矩。

---

## Part 4｜Skills：將團隊 SOP 編碼化
> 14 min (Concept: 8m / **Demo: 6m**)

- **核心經驗**：Skill 的價值在於「主動性」與「一致性」。
- **案例分享**：自動化安全審計、設計系統合規檢查。
- **【Demo】用這場演講的品質審查 Skill 示範**（約 6 分鐘）：
  - 展示 `slide-review` Skill 定義：`When to use` 描述觸發時機，Skill 檢查 `slides.md` 是否有時間資訊、受眾標籤等違規。
  - 先在 `slides.md` 插入一個刻意的違規（demo 腳本自動植入），再請 AI「幫我審查剛修改的投影片」。
  - AI 觸發 Skill，掃描 `slides.md`，產出結構化報告指出違規位置與建議修正。
  - **重點**：同樣問法、同樣輸出格式——Skill 讓品質審查不依賴個人習慣。

---

## Part 5｜Hooks：確定性的自動化防線
> 13 min (Concept: 8m / **Demo: 5m**)

- **核心經驗**：別讓 AI 決定要不要執行守衛，直接在 Hook 強制執行。
- **案例分享**：格式守衛、內容攔截。
- **延伸應用**：Worktree 自動管理（選用，視時間彈性決定是否展開）。
- **【Demo】自動化守衛現場展示**（用這場演講本身）：
  - **PostToolUse**：請 AI 在 `slides.md` 加入新投影片。寫入後 Hook 自動執行 `scripts/validate-slides.sh`，掃描全文，輸出 `[GUARD] OK` 或 `[GUARD] WARN: forbidden pattern`。
  - **PreToolUse**：請 AI「在投影片加上這場演講的時間資訊：90 分鐘」。Hook 讀取即將寫入的內容，偵測到時間關鍵字，攔截並輸出 `BLOCKED: Time information not allowed in slides.md`。
  - **重點**：AI 沒有機會決定要不要守規則——Hook 先攔截，確定性執行。

---

## Part 6｜MCP：打破本機邊界，連接外部世界
> 7 min (Concept: 4m / **Demo: 3m**)

- **MCP 核心概念**：Model Context Protocol，讓 AI 具備「特務」身分，主動連接 GitHub、Database、Monitoring 等外部系統。
- **為什麼重要**：AI 不再只能看 Codebase，能讀取 Issue、查詢 DB、觀察 Metrics，形成完整的情境感知。
- **案例分享**：GitHub MCP 串接，AI 自動讀取 Issue 並對應代碼變更。
- **【Demo】GitHub MCP 跨工具協作**（約 3 分鐘）：
  - 透過 GitHub MCP 查詢近期的 Open Issue 清單。
  - 展示 AI 如何打破本機 Codebase 限制，主動獲取外部系統的上下文資訊。

---

## Part 7｜Subagents：角色分工與任務委派
> 9 min (Concept: 4m / **Demo: 5m**)

- **Subagents 核心概念**：定義在 `.claude/agents/`，每個 Agent 有獨立的系統提示與專注領域。
- **與 MCP 的本質差異**：MCP 向外連接（外部系統），Agents 向內分工（內部角色）。
- **實作模式**：主 Agent 委派任務，子 Agent 專注執行，彼此分工而非互相干擾。
- **【Demo】用這場演講本身示範 Subagents**（約 5 分鐘）：
  - 這場演講的 `.claude/agents/` 就定義了 `presentation-reviewer`、`slides-creator`、`demo-code-generator` 三個專責 Agent。
  - 現場觸發 `presentation-reviewer` 審查剛才修改的投影片，展示 Agent 自動讀取素材並產出結構化報告。
  - 說明每個 Agent 如何透過 frontmatter 限制工具存取範圍、聚焦職責，避免越權。
  - **重點**：這不是玩具範例，這就是這場演講實際運行的基礎設施。

---

## Part 8｜OpenSpec：規格驅動開發的實際工具
> 12 min (Concept: 7m / **Demo: 5m**)

- **核心概念**：所有的錯誤都源於「人機不對齊」。OpenSpec 是一套讓人機在動手前先對齊的工具集。
- **四個 Skills**：`explore`（釐清需求）→ `propose`（建立 Proposal）→ `apply`（執行任務）→ `archive`（歸檔完成）。
- **【Demo】OpenSpec 現場實戰**（約 5 分鐘）：
  - **事前（Setup）**：使用 `opsx:propose` 建立一個真實 Proposal——需求是「在這場演講的投影片中，新增一張介紹 OpenSpec 四個 Skills 的頁面」。Proposal 已預先產生，存在 repo 中。
  - **現場 Step 1**：展示已生成的 Proposal，說明它定義了「做什麼、為什麼、成功標準」。
  - **現場 Step 2**：執行 `opsx:apply`，AI 直接修改 `slides.md`，新投影片即時出現在投影螢幕上。
  - **收尾重點**：「你剛才看到的這張投影片，是在這場演講進行中被加進來的。這就是 Spec 驅動的威力——需求清楚，執行不走鐘。」
  - **Fallback**：若 `opsx:apply` 輸出不理想，直接展示 Proposal 內容，口述四個階段的價值。

---

## Part 9｜結語與 Q&A
> 7 min

- **團隊導入路徑**：如何說服團隊開始使用 `.claude/`？分為個人實驗、團隊分享、共同維護、系統化四個階段。
- **未來展望**：當團隊的所有規範都變成了 Agentic Config。
- **Q&A 互動**：預留時間回答聽眾問題。

---

## 時間分配總覽 (86 min)
| 段落 | 重點 | 時間 | Demo 佔比 |
|------|------|------|-----------|
| Part 0 | 開場與痛點 | 6 min | - |
| Part 1 | Claude Code 初探 | 5 min | - |
| Part 2 | 五層架構 | 6 min | - |
| Part 3 | 記憶 (CLAUDE.md) | 7 min | - |
| Part 4 | 技能 (Skills) | 14 min | 43% (6m) |
| Part 5 | 守衛 (Hooks) | 13 min | 38% (5m) |
| Part 6 | MCP 外部連接 | 7 min | 43% (3m) |
| Part 7 | Subagents 分工 | 9 min | 56% (5m) |
| Part 8 | SDD 規格驅動 | 12 min | 42% (5m) |
| Part 9 | 結語 + Q&A | 7 min | - |
