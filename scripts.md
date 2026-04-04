# Agentic Coding 實戰：講稿與時間規劃

## 總覽與時間估算 (總計 86 分鐘)

| 章節 | 預計時間 | 投影片 | 核心重點 |
| :--- | :--- | :--- | :--- |
| **Part 0: 開場與破冰** | 6 min | Slide 1-4 | 痛點共鳴、設定目標 |
| **Part 1: Claude Code 初探** | 5 min | Slide 5-8 | CLI 工具、對比 Chat UI、`.claude/` 目錄 |
| **Part 2: 架構思維** | 6 min | Slide 9-11 | 五種功能（含確定性 vs. 機率性） |
| **Part 3: CLAUDE.md** | 7 min | Slide 12-15 | 長期記憶、技術棧鎖定、邊界定義 |
| **Part 4: Skills** | 14 min | Slide 16-21 + Demo 2 | SOP 封裝、Demo 2 (slide-review 品質審查) |
| **Part 5: Hooks** | 13 min | Slide 22-28 + Demo 3 | 確定性守護、Demo 3 (PostToolUse 驗證 / PreToolUse 攔截) |
| **Part 6: MCP** | 7 min | Slide 29-31 + Demo 4 | 打破邊界、Demo 4 (GitHub MCP 跨工具協作) |
| **Part 7: Subagents** | 9 min | Slide 32-35 + Demo 5 | 角色分工、Demo 5 (presentation-reviewer 委派實戰) |
| **Part 8: OpenSpec** | 12 min | Slide 36-40 + Demo 6 | 規格驅動、Demo 6 (opsx:propose → opsx:apply 現場實戰) |
| **Part 9: 結語 + Q&A** | 7 min | Slide 41-44 | 導入路徑、未來展望、Q&A |

---

## 逐頁講稿 (Scripts)

---

### [Slide 1] 標題頁
**時間：~30 秒**

各位夥伴好，歡迎來到今天的技術分享。我們今天要聊的主題是「Agentic Coding 實戰：從個人工具到團隊基礎設施」。

這不只是關於如何使用 AI 寫程式，而是如何從我們習慣的 Chat UI 模式，演進到像 Claude Code 這樣具備 Agent 能力的開發流程。

> 過場：點擊「開始」按鈕進入下一頁。

---

### [Slide 2] Part 0 章節頁：AI 寫代碼的「天花板」
**時間：~15 秒**

讓我們從一個大家都有共鳴的問題開始。

> 過場：直接翻頁。

---

### [Slide 3] 你有這種感覺嗎？
**時間：~1 分 30 秒**

（投影片顯示大字：「有了 AI，為什麼開發速度沒有提升 10 倍？」）

大家現在怎麼用 AI 寫代碼？我相信很多人已經在用 ChatGPT、Claude.ai，甚至各種 AI-assisted IDE 這類工具。但我想問一個問題：你覺得你的開發速度真的因此提升了 10 倍嗎？

（停頓，讓聽眾思考）

大部分人的答案是「沒有」。可能快了一點，但離 10 倍還很遠。為什麼？

> [v-click] 觸發底部文字：「問題不在 AI 不夠強，問題在我們用錯方式。」

對，問題不在 AI 不夠聰明，而是我們跟 AI 互動的方式有三個根本瓶頸。

> 過場：翻到下一頁看這三個瓶頸。

---

### [Slide 4] Chat UI 的三道牆
**時間：~3 分鐘**

（依序點擊三個卡片）

> [v-click 1] Context 碎片化

第一道牆：**Context 碎片化**。每次開一個新的對話，你都要重新貼上專案的背景資料、架構說明、coding style。AI 永遠不知道你的專案全貌。

> [v-click 2] 知識無法傳承

第二道牆：**知識無法傳承**。你們團隊裡一定有人的 Prompt 寫得特別好，但這些好的做法存在他自己的腦袋裡，其他人不知道。AI 的表現取決於「誰在打字」，而不是團隊的集體智慧。

> [v-click 3] 行為不可預測

第三道牆：**行為不可預測**。同樣的問題，這次 AI 回答得很好，下次換個 Session 就寫出完全不同的東西。沒有一致性，你無法信任它。

> [v-click 4] 底部核心訊息

所以今天的核心目標就是：把 AI 從一個「聰明的 autocomplete」，升級為團隊共用的「數位工程師」。我們要實現兩件事：**規格驅動開發 (SDD)** 和**自動化守護**。

> 過場：那要怎麼做到？我們需要一個架構。

---

### [Slide 5] Part 1 章節頁：Claude Code 初探
**時間：~15 秒**

讓我先確保大家對 Claude Code 有個基本認識，再進入架構討論。

> 過場：直接翻頁。

---

### [Slide 6] Claude Code 是什麼？
**時間：~1 分 30 秒**

（依序點擊三個卡片）

很多人聽到 Claude Code，第一反應是「又一個 Chat UI 嗎？」不是。

> [v-click 1] 終端機 CLI

Claude Code 是跑在**終端機裡**的 CLI 工具。你不是在瀏覽器裡對話，你是在自己的 terminal 裡用指令驅動它。

> [v-click 2] 直接動手

它能讀取你的檔案、執行指令、寫入程式碼。不是「告訴你怎麼做」，而是**直接幫你做**。

> [v-click 3] 本機環境

最關鍵的是——它在你的**本機環境**裡動手。你的 repo、你的工具、你的設定，它都看得到、用得到。不需要你手動把程式碼貼給它。

> [v-click 4] 底部說明

這不是 autocomplete，也不是聊天助理。它是能在你的環境裡自主行動的 Agent。

> 過場：那它和我們已經在用的 Chat UI 有什麼不同？

---

### [Slide 7] Chat UI vs Claude Code
**時間：~1 分 30 秒**

（左右對比）

這張投影片是今天 Part 1 的核心。讓我直接比較。

> [v-click 1] 左欄：Chat UI 的問題

Chat UI 的問題有三個：每次對話都是空白記憶，你必須重新交代背景；需要手動貼上 context——你的程式碼片段、規範文件、架構說明；而且行為不一致，這個 session 的結果和下個 session 可能完全不同。

> [v-click 2] 右欄：Claude Code 的不同

Claude Code 不一樣：它讀取 Repo 裡的設定檔，帶著你的**專案知識**醒來。你的技術棧、邊界規則、禁止行為，它都知道。而且行為可預測——因為規則都寫在 repo 裡，全團隊共享同一套 AI 體驗。

這個「讀取 Repo 設定」是怎麼做到的？就靠 `.claude/` 目錄。

> 過場：翻到下一頁。

---

### [Slide 8] `.claude/` 目錄
**時間：~1 分 30 秒**

（左欄目錄結構，右欄說明）

> [v-click 1] 左欄：目錄結構

`.claude/` 是 Claude Code 的**設定家目錄**。裡面放三種東西：`CLAUDE.md` 是 AI 的入職手冊；`skills/` 放可重用的技能包；`settings.json` 放 Hooks 自動化守衛的設定。

> [v-click 2] 右欄：跟著 Git 走

這個目錄最重要的特性是：**跟著 Git 走**。你把它 commit 進 repo，版本可追溯，任何變更都可以走 PR Review。

它不是某個工程師個人電腦裡的設定，而是整個團隊共同維護的「AI 行為合約」。你有新成員加入，clone 完 repo，他的 Claude Code 就立刻具備了所有團隊知識。

> 過場：現在知道 Claude Code 是什麼了，接下來問題是——它裡面應該放什麼？這就帶我們進入架構討論。

---

### [Slide 9] Part 2 章節頁：架構思維
**時間：~15 秒**

接下來，我要帶大家建立一個心智模型：Claude Code 的五種功能。

> 過場：直接翻頁。

---

### [Slide 10] 從個人到團隊：為什麼 `.claude/` 要跟著 Git 走？
**時間：~2 分 30 秒**

（左欄直接顯示「今日以前」的現狀）

在進入架構之前，我想先講一個最重要的觀念。大家看左邊，這是我們今天以前的現狀：
- Prompt 存在各自的記憶裡
- 好的做法靠口耳相傳
- 每個人的 AI 體驗不同
- 無法 Review、無法版本控制

聽起來很像什麼？很像沒有 Git 之前的軟體開發。

> [v-click 1] 顯示右欄「今日之後」

但如果我們把 AI 的配置放進一個 `.claude/` 目錄，然後 commit 進 Git，一切就不一樣了。知識變成可審核的程式碼，全團隊共享一致的 AI 行為，AI 配置的變更也可以走 PR Review。

> [v-click 2] 底部核心洞察

**核心洞察：AI 的配置是基礎設施的一部分，不是個人資產。** 這句話請大家記住，是今天最重要的一個觀念。

> 過場：接下來看這個基礎設施的五種功能。

---

### [Slide 11] 五種功能（含確定性 vs. 機率性）
**時間：~3 分鐘**

（依序點擊五個卡片）

> [v-click 1] 記憶 (Memory)

第一個功能：**記憶**。透過 `CLAUDE.md`，讓 AI 永遠知道你的專案、技術棧與邊界。這屬於**確定性**的範疇——每次對話必定載入，不依賴 AI 的記憶。

> [v-click 2] 技能 (Skills)

第二個功能：**技能**。`.claude/skills/` 目錄下的指令包，把團隊 SOP 編碼化。這是**機率性**的——AI 根據描述判斷何時觸發，但好的 Skill Description 能大幅提高一致性。

> [v-click 3] 守衛 (Governance)

第三個功能：**守衛**。`settings.json` 裡的 Hooks，不靠 AI 判斷，強制執行。確定性的底線——寫完檔案一定跑 Prettier，碰到 .env 一定攔截。

> [v-click 4] 連結 (Connectivity)

第四個功能：**連結**。MCP（Model Context Protocol）向外連接，打破本機邊界。AI 能直接查 GitHub Issue、讀資料庫、取 Monitoring 數據。這是機率性的——AI 判斷何時呼叫哪個外部工具。

> [v-click 5] 分工 (Delegation)

第五個功能：**分工**。定義在 `.claude/agents/` 的角色專屬 Agent，讓 AI 向內分工。Planner 只管計畫、Engineer 只管實作、QA 只管審核。同樣是機率性——AI 協調與委派。

**MCP 向外連接，Agents 向內分工——方向不同，但都是在擴展 AI 的能力邊界。**

> [v-click 6] 底部金句

記住這個原則：**「先建立底線（確定性），再追求加速（機率性）。」** 今天的演進路線就是按照這個順序走的。

> 過場：好，讓我們從第一個功能「記憶」開始。

---

### [Slide 12] Part 3 章節頁：長期記憶
**時間：~15 秒**

接下來，我們深入聊 CLAUDE.md。這是最容易上手、ROI 最高的一層。

> 過場：直接翻頁。

---

### [Slide 13] CLAUDE.md 不是 README
**時間：~2 分鐘**

（左欄顯示 README 的特性）

很多人第一次聽到 CLAUDE.md 會覺得：「這不就是 README 嗎？」不一樣。

README 是給人看的說明文件，偶爾更新，不影響 AI 的行為。

> [v-click 1] 顯示右欄 CLAUDE.md 的特性

CLAUDE.md 是給 AI 看的**入職手冊**。它定義了 AI 能做什麼、不能做什麼，隨著專案演進持續更新，而且最關鍵的是——它**直接決定 AI 的每一個決策**。

> [v-click 2] 底部金句

我喜歡用一個比喻：**「CLAUDE.md 是你與 AI 的合約。」** 合約寫得越清楚，合作就越順利。

> 過場：讓我用兩個案例說明怎麼寫好這份合約。

---

### [Slide 14] 案例 1：技術棧鎖定
**時間：~2 分鐘**

（左欄說明問題）

第一個案例：技術棧鎖定。問題是什麼？AI 推薦了過時的 `pages/` 目錄結構，而你們團隊已經全面轉移到 Next.js 的 App Router。

> [v-click 1] 顯示解法 code block

解法很簡單：在 CLAUDE.md 裡寫清楚。列出你的 Tech Stack，並且用 NEVER 明確標示禁止項目。這段 Markdown 不到 10 行，但效果巨大。

> [v-click 2] 顯示結果

結果是：AI 永遠使用正確的語法，你不再需要每次糾正，而且新成員加入團隊時也能得到正確的 AI 建議，因為這份 CLAUDE.md 是 commit 在 repo 裡的。

> 過場：第二個案例更關鍵——邊界定義。

---

### [Slide 15] 案例 2：邊界定義
**時間：~2 分鐘**

（左欄說明問題）

這個案例來自真實經驗。AI 自作主張修改了 `migrations/` 目錄裡的檔案，結果生產環境的 Schema 出了問題。

> [v-click 1] 顯示解法 code block

解法是明確定義 Boundaries。告訴 AI：永遠不能編輯 migrations 目錄、所有 Schema 變更只能走 Prisma DSL、永遠不能繞過 authMiddleware。

> [v-click 2] 顯示漸進式揭露策略

這裡還有一個重要策略叫**漸進式揭露**。CLAUDE.md 裡只放路標和規則，細節文件放在 `docs/` 目錄下，AI 需要時會自己去讀。這樣可以避免 Context 被稀釋。

> 過場：有了記憶，接下來是技能。

---

### [Slide 16] Part 4 章節頁：Skills
**時間：~15 秒**

接下來，我們看如何把團隊的 SOP 變成 AI 的技能包。

> 過場：直接翻頁。

---

### [Slide 17] 什麼是 Skill？
**時間：~2 分鐘**

（依序點擊三個卡片）

Skill 有三個核心價值：

> [v-click 1] 主動性

**主動性**：AI 知道「什麼時候」應該主動使用這個流程。不需要你每次都手動呼叫。

> [v-click 2] 一致性

**一致性**：每次執行的結果格式相同，可預期。不會今天跑出一種格式、明天換一種。

> [v-click 3] 可傳承

**可傳承**：Senior 工程師的最佳實踐，變成全團隊的標準。

> [v-click 4] 底部路徑

Skill 的實現很簡單：在 `.claude/skills/` 目錄下建立一個 Skill 目錄並放入 SKILL.md。一個 Skill 目錄就等於一個可重用的 AI 工作流程。

> 過場：讓我用兩個實際案例來說明。

---

### [Slide 18] 案例 1：投影片品質審查 Skill
**時間：~2 分鐘**

（顯示痛點）

痛點是什麼？每次修改投影片後，你怎麼確認沒有混入時間資訊或受眾標籤？人工 review 很容易遺漏，而且標準因人而異。

> [v-click 1] 左欄 Skill 定義

看左邊這個 `slide-review` Skill 定義。關鍵在 `When to use` 區塊——它明確告訴 AI 觸發時機：使用者說「幫我審查投影片」，或說「review slides」，或修改了 slides.md 後。步驟是逐行掃描，偵測禁止樣式，然後輸出結構化報告。

> [v-click 2] 右欄品質審查報告

右邊是 AI 執行完這個 Skill 後產出的報告。清楚標示哪一行有違規、違規的類型、以及建議修正方向。格式固定、可預期——這就是 Skill 帶來的一致性。

> 過場：第二個案例是前端團隊很有感的——設計系統合規檢查。

---

### [Slide 19] 案例 2：設計系統合規檢查
**時間：~1 分 30 秒**

（顯示痛點）

痛點：開發者習慣性地手寫 `bg-[#f0f]` 或 `p-[13px]` 這類 arbitrary value，設計債不斷累積。

> [v-click 1] 左欄 Skill 定義

這個 Skill 會掃描所有 hardcoded 的顏色值和間距值，然後對應到 Design Token 建議替換方案。

> [v-click 2] 右欄對比

右邊很直觀：紅色是違規的寫法，綠色是合規的寫法。AI 不只告訴你哪裡不對，還直接建議正確的 token。

> 過場：這兩個案例的共通點是什麼？Skill 的 Description 寫得好不好，決定了它的觸發率。

---

### [Slide 20] 心法：觸發率 90% 的 Skill Description
**時間：~2 分鐘**

（左右對比）

這是今天 Skill 這段最重要的一張投影片。

左邊是壞的寫法：「Checks security of the application.」就這樣。

> [v-click 1] 底部紅框

AI 看到這種描述，根本不知道「什麼時候」該用它。結果就是只有你明確呼叫 `/check-security` 時它才會跑。

> [v-click 2] 右欄好的寫法

右邊是好的寫法：`When to use` 區塊明確列出觸發條件——新增 admin 檔案時、建立 API route 時、建立 PR 前、提到 security 這個詞時。

寫好這個 Description，AI 的自動觸發率可以從 20% 飆到 90%。差別就在這裡。

> 過場：Skill 解決了「加速」，但有些事情不能靠機率。接下來是「守衛」。

---

### [Demo 2 佔位投影片] Demo Time：Skills 實作
**時間：過場 ~15 秒**

（螢幕出現 Demo 2 佔位頁）

好，第二個 Demo。我們要用這場演講自己的 `slide-review` Skill，現場審查 slides.md 的品質。大約 6 分鐘。

> 過場：切換到終端機。

---

### [Demo 2] Skills 實作（約 6 分鐘）

**操作步驟：**

1. 展示 Skill 定義檔案：
   ```bash
   cat .claude/skills/slide-review/SKILL.md
   ```
   說明：「看這個 `When to use` 區塊——它定義了觸發條件。接下來我就用這個描述觸發它。」

2. 先在 slides.md 植入一個刻意的違規（demo 腳本自動植入，或現場手動加入一行含「90 分鐘」的內容），然後請 AI 審查：
   ```bash
   claude "我剛更新了投影片，幫我做品質審查"
   ```
   **預期結果：** AI 識別到 `slide-review` Skill 的觸發條件，自動載入並掃描 slides.md，產出包含違規位置與建議修正的結構化報告。

3. 展示報告格式的一致性：「不管誰問、怎麼問，只要符合觸發條件，輸出格式都一樣。這就是 Skill 的價值——品質審查不再依賴個人習慣。」

**備用方案（Demo 失敗時）：**
展示預先準備好的終端機截圖或錄影，說明：「這是 AI 自動觸發 slide-review Skill 的畫面。注意看它是自動判斷要執行審查的，我只是說了『幫我做品質審查』。」

**[Improvisation Checkpoint]**
若 AI 沒有自動觸發 `slide-review` Skill，而是直接開始審查或給出通用回覆：
說「讓我明確指定 Skill」，然後執行：
```bash
claude "請用 slide-review skill 審查 slides.md，並輸出結構化報告"
```
若 AI 輸出格式不符合 Skill 的 Output Format，說明：「Skill 的觸發是機率性的，但好的 `When to use` 描述能大幅提升觸發率。讓我展示預先準備的報告格式。」（展示已準備好的報告截圖）

> 過場：有了記憶和技能，接下來是最硬核的一層——Hooks。

---

### [Slide 22] Part 5 章節頁：Hooks
**時間：~15 秒**

接下來，我們來看確定性的自動化防線。

> 過場：直接翻頁。

---

### [Slide 23] 為什麼需要 Hooks？
**時間：~1 分 30 秒**

（大字問題）

讓我問大家一個問題：你能保證 AI **每次**都記得跑 Lint 嗎？

（停頓）

> [v-click 1] 大字「不行。」

不行。AI 是機率性的，它有時候記得、有時候忘記。而格式不一致、安全漏洞這種事情，一次都不能容忍。

> [v-click 2] 核心價值說明

所以 Hooks 的核心價值就是：讓關鍵行為從「機率性」變成「確定性」。不依賴 AI 的判斷，直接強制執行。這就是我們說的「底線」。

> 過場：看一下 Hook 的運作機制。

---

### [Slide 24] Hook 生命週期
**時間：~1 分 30 秒**

（依序點擊三個階段）

Hook 的生命週期很簡單，只有三個節點：

> [v-click 1] PreToolUse

**PreToolUse**：AI 準備執行工具之前。你可以在這裡做攔截。例如偵測到 AI 要修改 .env 檔案，直接阻止。

> [v-click 2] 工具執行

中間是工具的實際執行：寫檔、讀檔、執行命令等等。

> [v-click 3] PostToolUse

**PostToolUse**：工具執行完畢之後。你可以在這裡做補齊。例如寫完檔案後自動跑 Prettier。

> [v-click 4] 底部說明

你可以在任何生命週期節點插入自訂邏輯。而且這些邏輯是用一般的 Shell Script 寫的，不需要學新語言。

> 過場：來看兩個實際案例。

---

### [Slide 25] 案例 1：投影片守衛 (PostToolUse)
**時間：~2 分鐘**

（左欄設定）

第一個案例：投影片守衛。設定很簡單：在 PostToolUse 裡，當 AI 使用 Write、Edit 或 MultiEdit 工具後，自動執行 `scripts/validate-slides.sh` 掃描 slides.md。

> [v-click 1] 右欄效果

效果有兩個輸出：`[GUARD] OK` 代表內容合規、`[GUARD] WARN: forbidden pattern` 代表偵測到違規——比如時間資訊或受眾標籤出現在投影片上。

這就是確定性的美好之處——你不需要在 CLAUDE.md 裡寫「請記得審查投影片」，因為 Hook 在 AI 寫完的瞬間就自動驗了。

> 過場：第二個案例是內容攔截。

---

### [Slide 26] 案例 2：內容攔截 (PreToolUse)
**時間：~2 分鐘**

（左欄設定）

這次是 PreToolUse。邏輯是：當 AI 嘗試用 Write 或 Edit 工具修改 slides.md 時，先讀取即將寫入的內容，檢查是否包含時間關鍵字，例如「90 分鐘」或「min」。如果是，直接 exit 2 阻擋。

> [v-click 1] 右欄效果

效果是：`BLOCKED: Time information not allowed in slides.md`。AI 沒有機會決定要不要守規則——Hook 在寫入前就先攔截了。

注意這裡的關鍵：不是 CLAUDE.md 告訴 AI「不要寫時間」，而是 Hook 在工具層強制阻斷。即使 AI 判斷失誤、或被使用者指令帶偏，Hook 照樣攔截。

> [v-click 2] Exit Code 說明

Exit Code 的控制邏輯：Exit 0 表示「繼續執行」、Exit 2 表示「阻擋並顯示錯誤訊息」、其他 Exit Code 表示「顯示警告但繼續」。這讓你可以精細控制 Hook 的嚴重程度。

> 過場：最後看一個進階延伸應用。

---

### [Slide 27] 延伸應用：Worktree 自動管理
**時間：~1 分 30 秒**

（說明場景）

這是一個選用的進階案例。場景是：你的團隊需要同時開發多個 Feature，每個 Feature 需要獨立的環境。

> [v-click 1] 左欄 Script

透過 PostToolUse Hook，我們可以偵測 AI 是否執行了 `git checkout -b` 建立新分支。如果是，就自動觸發 `setup_worktree.sh` 腳本——自動建立 Git Worktree、安裝依賴、設置環境變數。

> [v-click 2] 右欄好處

好處是：開發者不需要手動切換環境、AI 可以並行處理多個任務、環境設置錯誤率降為零。

這個例子展示了 Hooks 的潛力不只是「防守」，還可以做「自動化設置」。

> 過場：好，到這裡我們已經搞定了內部的記憶、技能、守衛三層。接下來要打破本機的圍牆。

---

### [Demo 3 佔位投影片] Demo Time：Hooks 自動化守衛實戰
**時間：過場 ~15 秒**

（螢幕出現 Demo 3 佔位頁）

第三個 Demo。我們要用這場演講的 slides.md 作為目標——觸發 PostToolUse 驗證守衛，以及嘗試寫入時間資訊觸發 PreToolUse 攔截。大約 5 分鐘。

> 過場：切換到終端機。

---

### [Demo 3] Hooks 實戰（約 5 分鐘）

**操作步驟：**

1. 展示 settings.json 中的 Hook 設定：
   ```bash
   cat .claude/settings.json
   ```
   說明：「看這兩個 Hook——PostToolUse 執行驗證腳本、PreToolUse 攔截時間資訊。」

2. 觸發 PostToolUse（投影片守衛）：
   ```bash
   claude "幫我在 slides.md 的 Part 4 章節加入一張新的投影片"
   ```
   **預期結果：** AI 寫完 slides.md 後，`validate-slides.sh` 自動執行，輸出 `[GUARD] OK` 或 `[GUARD] WARN: forbidden pattern`。

3. 觸發 PreToolUse（時間資訊攔截）：
   ```bash
   claude "在投影片加上這場演講的時間資訊：90 分鐘"
   ```
   **預期結果：** Hook 讀取即將寫入的內容，偵測到「90 分鐘」，攔截並輸出 `BLOCKED: Time information not allowed in slides.md`，AI 的寫入操作被阻斷。

4. 簡要說明 Hook 的確定性特質：「AI 沒有機會決定要不要守規則。即使我明確要求它寫入時間，Hook 照樣攔截。這就是確定性執行。」

**備用方案（Demo 失敗時）：**
口述：「在實際操作中，當 AI 寫完 slides.md 的瞬間，你會看到終端機自動跑了驗證腳本，輸出 `[GUARD] OK`。而當 AI 嘗試寫入『90 分鐘』時，你會看到紅色的 `BLOCKED` 訊息，操作被直接阻斷。」

**[Improvisation Checkpoint]**
若 PostToolUse Hook 沒有自動觸發（例如環境問題或 settings.json 未生效）：
展示 `settings.json` 內容並口述邏輯：「正常情況下，AI 寫完的瞬間 Hook 自動跑。今天環境有些狀況，讓我直接執行腳本給大家看效果。」然後手動執行：
```bash
bash scripts/validate-slides.sh
```
若 PreToolUse Hook 沒有攔截時間資訊：
說「Hook 的攔截邏輯依賴環境變數。讓我展示這段腳本的邏輯。」（展示攔截腳本的 if 條件），重點說明「這段邏輯是確定性的——只要 Hook 正確載入，就一定攔截。」

> 過場：內部搞定了，接下來打破邊界。

---

### [Slide 29] Part 6 章節頁：MCP
**時間：~15 秒**

接下來，我們看如何讓 AI 連接外部世界。

> 過場：直接翻頁。

---

### [Slide 30] MCP：讓 AI 具備「特務身分」
**時間：~2 分 30 秒**

（顯示說明文字）

MCP，全名 Model Context Protocol，是一個讓 AI 能連接外部系統的協議。有了它，AI 不再被限制在本機的 Codebase 裡。

> [v-click 1-3] 依序點擊三個 MCP 類型

我們可以連接各種外部系統：
- **GitHub MCP**：直接查詢 Issue、建立 PR、管理 Branch
- **Database MCP**：查詢生產數據、分析效能問題
- **Monitoring MCP**：讀取 Metrics、分析 Log

> [v-click 4] 底部案例

舉一個完整的例子：AI 讀取 GitHub Issue #123，理解需求，自動建立 feature branch，完成實作，然後建立 PR。全程自動，你只需要在最後做 Code Review。

> 過場：MCP 讓 AI 向外連接。接下來我們看 Demo，然後聊 AI 向內分工。

---

### [Demo 4 佔位投影片] Demo Time：MCP 跨工具協作
**時間：過場 ~15 秒**

（螢幕出現 Demo 4 佔位頁）

第四個 Demo，大約 3 分鐘。我們用 GitHub MCP 來展示 AI 如何打破本機限制，直接查詢外部系統的資訊。

> 過場：切換到終端機。

---

### [Demo 4] MCP 跨工具協作（約 3 分鐘）

**操作步驟：**

1. 展示 MCP 設定：
   ```bash
   ./scripts/demo4-setup.sh show
   ```

2. 使用 GitHub MCP：
   ```bash
   claude "查看 GitHub 上最近的 3 個 open issue"
   ```
   **預期結果：** AI 透過 GitHub MCP 列出 issue 清單。

3. 簡要說明 MCP 如何打破本機限制。

**備用方案（Demo 失敗時）：**
口述：「在我們團隊的日常開發中，AI 可以直接讀取 GitHub Issue 的內容，不需要你手動複製貼上。這看起來是小事，但對 Agentic Workflow 來說是關鍵的一步——AI 能主動獲取任務的上下文。」

**[Improvisation Checkpoint]**
若 GitHub MCP 連線失敗或 issue 清單無法顯示：
說「MCP 連線需要 GitHub token，今天的網路環境有些不確定性。讓我展示這個串接的設定方式。」展示 MCP 的 `claude_desktop_config.json` 或 `.claude/settings.json` 裡的 MCP 設定片段，口述：「這段設定告訴 Claude Code 可以呼叫哪個 MCP Server，以及如何啟動它。一旦設定完成，AI 就能主動查詢外部系統，不需要你手動複製貼上。」

> 過場：MCP 是向外連接。接下來聊向內分工——Subagents。

---

### [Slide 32] Part 7 章節頁：Subagents
**時間：~15 秒**

接下來，我們看如何讓 AI 做角色分工。

> 過場：直接翻頁。

---

### [Slide 33] Subagents：讓 AI 具備「專家大腦」
**時間：~2 分 30 秒**

（副標題問題）

為什麼 Planner 與 Engineer 必須分開？

> [v-click 1-3] 依序點擊三個 Agent 卡片

答案是**角色專業化**：

**Planner Agent**：只管計畫，絕不寫 code。輸出是 Tasks List。因為不碰實作，它能更客觀地評估需求和風險。

**Engineer Agent**：只管實作，照計畫執行。輸出是 Code Changes。因為目標明確，它不會隨意改需求。

**QA / Reviewer Agent**：獨立 Context，專門找漏洞和問題。輸出是 Review Report。因為它不是寫 code 的那個 Agent，所以能用全新視角審核。

> 過場：那多 Agent 到底比單一 Agent 好在哪？

---

### [Slide 34] 為什麼多 Agent 比單一 Agent 更好？
**時間：~2 分鐘**

（左右對比）

> [v-click 1] 左欄：單一 Agent 的盲點

單一 Agent 有三個盲點：寫完 code 後自己 Review 容易看不見自己的錯誤；計畫與實作混在同一個 Context 裡容易妥協——「這裡太難了，改個簡單的做法吧」；而且無法客觀評估自己的產出品質。

> [v-click 2] 右欄：多 Agent 的優勢

多 Agent 的優勢是：QA Agent 用全新的 Context 審核，能找到更多問題；角色分離讓每個 Agent 專注自己的任務；「互相監督」機制極大化了最終品質。

這跟人類團隊的道理一樣——你不會讓同一個人寫 code 又自己 approve PR。

> 過場：說了這麼多理論，讓我現場示範這場演講本身的 Subagents。

---

### [Demo 5 佔位投影片] Demo Time：Subagents 角色分工實戰
**時間：過場 ~15 秒**

（螢幕出現 Demo 5 佔位頁）

第五個 Demo，約 5 分鐘。這場演講的 `.claude/agents/` 目錄已經定義了真實運行的 Subagents。我們現場觸發它們。

> 過場：切換到終端機。

---

### [Demo 5] Subagents 角色分工實戰（約 5 分鐘）

> **時間結構說明（僅供講者參考）：**
> - Step 1：展示 Agent 定義檔（~1 分鐘）
> - Step 2：現場觸發委派（~3 分鐘，含 AI 回應）
> - Step 3：說明 frontmatter 結構（~1 分鐘）

---

#### Step 1：展示 Agent 定義檔 【目標時間：~1 分鐘】

這場演講的 `.claude/agents/` 目錄裡定義了三個 Subagents：

```bash
ls .claude/agents/
# presentation-reviewer.md
# slides-creator.md
```

打開 `presentation-reviewer.md`，看一下 frontmatter：它定義了這個 agent 的 `name`、`description`（觸發條件）、`model`（使用的模型）、以及 `tools`（被限制只能讀取特定檔案）。這個 agent 的職責就是審查投影片，它不能寫入、不能執行指令——職責邊界明確。

---

#### Step 2：現場觸發委派 【目標時間：~3 分鐘（含 AI 回應）】

現在我們請主 agent 委派工作給 presentation-reviewer：

```bash
claude "請 presentation-reviewer 審查目前的投影片"
```

注意觀察：主 agent 會識別出這個請求應該委派給 `presentation-reviewer` subagent，然後 subagent 自動讀取 `slides.md`，產出結構化的審查報告——包含各章節的結構評估與建議。

（等待輸出，指出報告的結構性）

這就是「主 agent 不需要知道所有細節」的實現——它知道要委派，subagent 知道怎麼做。

---

#### Step 3：說明 frontmatter 結構的意義 【目標時間：~1 分鐘】

回頭看這個 frontmatter。`model` 可以指定不同模型——QA 任務可以用便宜的模型、複雜分析才用高階模型。`tools` 欄位限制了這個 agent 的存取範圍，它只能讀，不能寫——職責邊界由設定強制執行，不靠 AI 自律。

**重點：這不是玩具範例，這就是這場演講實際運行的基礎設施。**

---

**備用方案（Demo 失敗或 subagent 輸出過長時）：**
若 AI 輸出過長或格式不佳，快速說：「報告的詳細程度視任務而定。讓我展示 frontmatter 結構——這才是 Subagents 的關鍵設計。」（展示 `presentation-reviewer.md` 的 frontmatter，說明 model、tools 的設計意圖）

**[Improvisation Checkpoint]**
若 AI 沒有自動委派給 subagent，而是直接自己開始審查：
說「讓我明確指定使用哪個 agent。」然後執行：
```bash
claude "請用 presentation-reviewer agent 審查投影片，我要看結構化報告"
```
若仍無法觸發，展示 `.claude/agents/presentation-reviewer.md` 的完整內容，口述：「角色分工讓主 agent 不需要知道所有細節——它只需要知道有這個 agent 存在，任務怎麼做由 agent 的定義來決定。」

> 過場：外部連接和分工都有了。最後一塊拼圖是：規格驅動。

---

### [Slide 36] Part 8 章節頁：OpenSpec
**時間：~15 秒**

接下來進入今天的核心精華——OpenSpec，一套讓人機在動手前先對齊的規格驅動工具集。

> 過場：直接翻頁。

---

### [Slide 37] 所有錯誤的根源
**時間：~1 分 30 秒**

（空白畫面，等待點擊）

我想先問大家：你覺得用 AI 開發時，最大的錯誤來源是什麼？是 AI 太笨嗎？是 Prompt 不對嗎？

> [v-click 1] 大字「人機不對齊」

答案是：**人機不對齊**。

> [v-click 2] 三行說明

你以為 AI 理解了你的需求。AI 以為它理解了你的需求。**但雙方其實理解的是不同的東西。**

這種不對齊在模糊需求時特別嚴重。你說「做一個用戶管理頁面」，但你腦中的畫面和 AI 腦中的畫面可能完全不同。

> 過場：OpenSpec 就是為了解決這個問題而生的工具。

---

### [Slide 38] OpenSpec：四個 Skills
**時間：~2 分 30 秒**

（依序點擊四個 Skill 卡片）

OpenSpec 是一套官方工具集，由四個 Skills 組成：

> [v-click 1] explore

**`explore`** — 釐清需求，成為你的思考夥伴。在你真正動手之前，先把問題想清楚。它不只是問問題，而是陪你深度探索：你真正要解決的是什麼？邊界在哪裡？

> [v-click 2] propose

**`propose`** — 這是 OpenSpec 的核心。你給出一個需求描述，它一步產出完整的 Proposal、Design 和 Tasks——三份文件，全部自動生成。從這一刻起，人機雙方對「做什麼」有了共同的合約。

> [v-click 3] apply

**`apply`** — 執行 spec 中的任務。不是猜測你要什麼，而是按照已對齊的 Proposal 逐步執行，不走鐘，不越界。

> [v-click 4] archive

**`archive`** — 完成即歸檔。每一個 change 都有完整記錄，未來可追溯，團隊可審查。

> 過場：來看看這四個步驟如何串在一起。

---

### [Slide 39] OpenSpec 的核心邏輯
**時間：~2 分鐘**

> [v-click 1] 核心觀點

**先對齊，再執行。規格是人機之間的合約。**

這句話和我們一開始說的 CLAUDE.md 呼應——CLAUDE.md 是「長期合約」，OpenSpec 的 Proposal 是「每次任務的短期合約」。

> [v-click 2-5] 四個步驟依序出現

`explore` → `propose` → `apply` → `archive`

每一步都有確定性：你知道 AI 做了什麼、為什麼做、做完了什麼。

> [v-click 6] 金句卡片

**先建立底線（確定性），再追求加速（機率性）。**

OpenSpec 讓你把「對齊」這件事變成確定性步驟，再讓 AI 在清晰的邊界內加速執行。

> 過場：理論夠了，我們來看真實的操作。

---

### [Demo 6 佔位投影片] Demo Time：OpenSpec 現場實戰
**時間：過場 ~15 秒**

（螢幕出現 Demo 6 佔位頁）

最後一個 Demo，我要用 OpenSpec 現場做一件事——修改這場演講本身的投影片。

> 過場：切換到終端機。

---

### [Demo 6] OpenSpec 現場實戰（約 5 分鐘）

> **時間結構說明（僅供講者參考）：**
> - Step 1：展示已備好的 Proposal（~1 分鐘）
> - Step 2：執行 opsx:apply，即時產出新投影片（~3 分鐘，含 AI 回應）
> - Step 3：收尾金句（~30 秒）

---

#### Step 1：展示已生成的 Proposal 【目標時間：~1 分鐘】

在 Demo 之前，我已經用 `opsx:propose` 建立了一個 Proposal。需求是：

> 「在這場演講的投影片中，新增一張介紹 OpenSpec 四個 Skills 的頁面。」

讓我們打開這份 Proposal：

（展示 Proposal 文件，指出關鍵欄位）

看這份文件——**Proposal** 定義了為什麼要加這張投影片：讓觀眾在 Demo 之前先理解工具的全貌。**Design** 說明這張投影片的結構：四個 Skills 各佔一個卡片，用 v-click 漸進揭露。**Tasks** 只有一項：在 slides.md 中新增對應的投影片 Markdown。

這就是 `opsx:propose` 的價值——一條需求進去，完整規格出來，人機雙方在動手之前先對齊。

---

#### Step 2：執行 opsx:apply，投影片即時出現 【目標時間：~3 分鐘（含 AI 回應）】

現在我們執行 `opsx:apply`：

（在終端機執行 opsx:apply，選擇對應的 Proposal）

注意 AI 在做什麼——它不是憑感覺開始寫，而是按照 Proposal 的 Tasks 逐步執行。它知道要去哪個位置插入、插入什麼格式、v-click 怎麼排。

（等待 AI 完成，投影片呈現在螢幕上）

> 過場：請看螢幕。

---

#### Step 3：收尾金句 【目標時間：~30 秒】

你剛才看到的這張投影片，是在這場演講進行中被加進來的。

這不是事先準備好的魔術——Proposal 定義了「做什麼」，`opsx:apply` 按照合約執行。需求清楚，執行不走鐘。

**這就是規格驅動的威力。**

---

**備用方案（Demo 失敗或時間不足時）：**
展示已準備好的 Proposal 文件，口述四個階段的價值：「在實際操作中，`opsx:propose` 自動生成這份文件，`opsx:apply` 按照 Tasks 一步步執行。最終的成果不是 AI 猜出來的，而是合約驅動出來的。」

> 過場：進入結語。

---

### [Slide 41] Part 9 章節頁：結語與團隊導入
**時間：~15 秒**

最後 6 分鐘，我們聊聊怎麼把今天學到的東西帶回你的團隊。

> 過場：直接翻頁。

---

### [Slide 42] 團隊導入路徑
**時間：~2 分鐘**

（依序點擊四個階段）

導入不需要一步到位。我建議分四個階段：

> [v-click 1] Week 1-2

**Week 1-2：個人實驗**。先在自己的專案建立 CLAUDE.md，記錄最常被 AI 搞錯的三件事。幾乎零成本。

> [v-click 2] Week 3-4

**Week 3-4：團隊分享**。在 Team Meeting 展示一個具體的 Hook 或 Skill 案例，讓結果說話。不要推銷概念，直接展示效果。

> [v-click 3] Month 2

**Month 2：共同維護**。把 `.claude/` 目錄加入 Repo，建立 PR Review 流程，讓整個團隊一起貢獻和迭代。

> [v-click 4] Month 3+

**Month 3+：系統化**。導入 OpenSpec，所有新功能開發都從 `opsx:propose` 開始。到這一步，你的團隊就真正擁有了 Agentic Workflow。

> 過場：最後看一下未來的樣貌。

---

### [Slide 43] 未來展望
**時間：~1 分 30 秒**

> [v-click 1] 左欄列表

想像一下：當團隊的所有規範都變成 Agentic Config——技術決策在 CLAUDE.md、團隊流程在 Skills、品質守護在 Hooks、功能規格在 OpenSpec Proposals。

> [v-click 2] 右欄結論

這時候 AI 就不只是工具了。它是你的數位團隊成員，和你一起維護同一套工程文化。新人 clone repo，AI 立刻具備所有知識和防護機制。這就是從「個人工具」到「團隊基礎設施」的演進。

> 過場：翻到最後一頁。

---

### [Slide 44] 謝謝大家！
**時間：~45 秒 + Q&A 約 3 分鐘**

（三個行動建議依序點擊）

最後三個具體的行動建議，讓你今天回去就能開始：

> [v-click 1] 今天就能做

**今天就能做**：建立 CLAUDE.md，記錄你的技術棧和三個最常被 AI 搞錯的邊界。

> [v-click 2] 本週可以做

**本週可以做**：寫一個 Skill，自動化你最常手動執行的流程。

> [v-click 3] 下個月目標

**下個月目標**：導入 OpenSpec，讓所有功能開發從 `opsx:propose` 開始。

謝謝大家！官方文件在 docs.anthropic.com。接下來歡迎提問。

---

## Q&A 預備問答

**Q: CLAUDE.md 會不會讓 Context 太大影響效能？**
A: 這就是為什麼我們提到「漸進式揭露」。CLAUDE.md 只放路標，細節文件放在其他地方讓 AI 按需載入。

**Q: Hooks 會不會拖慢 AI 的執行速度？**
A: Hook Script 通常是輕量的 Shell 命令，執行時間在毫秒到秒級。跟 CI/CD 的 pre-commit hook 一樣，這點延遲換來的是確定性保證。

**Q: MCP Server 的安全性如何保證？**
A: MCP Server 本質是你自己部署和控制的服務。你可以限制它的權限範圍，例如 GitHub MCP 只開讀取權限。

**Q: 小團隊或個人開發者也適用嗎？**
A: 完全適用。甚至個人開發者更適合，因為你沒有同事幫你 Review AI 的產出，所以 Hooks 和 SDD 的確定性機制對你更重要。

**Q: 除了 Claude Code，其他 AI 工具也能這樣做嗎？**
A: `.claude/` 的概念是 Claude Code 特有的，但架構思維是通用的。任何支援配置化的 AI 工具都可以套用「記憶 → 技能 → 守衛 → 連結 → 分工」這五種功能的框架。

**Q: CLAUDE.md 如何與 .cursorrules 等其他工具的配置檔共存？**
A: 兩者完全可以並存在同一個專案中，各自服務對應的 AI 工具。CLAUDE.md 是 Claude Code 專用的記憶與規則檔案，.cursorrules 則是其他 AI-assisted IDE 讀取的配置。團隊成員使用不同工具時，各自維護對應的配置檔即可，內容可以保持一致的規範，只是格式不同。
