---
theme: seriph
background: https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=1920&q=80
class: text-center
highlighter: shiki
lineNumbers: true
info: |
  ## Agentic Coding 實戰
  從個人工具到團隊基礎設施
drawings:
  persist: false
transition: slide-left
title: Agentic Coding 實戰
mdc: true
---

# Agentic Coding 實戰

## 從個人工具到團隊基礎設施

<div class="pt-4 opacity-70 text-lg">
  從 Chat UI 到 Claude Code 的演進之路
</div>

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-4 py-2 rounded-full cursor-pointer border border-white/30" hover="bg-white/10">
    開始 <carbon:arrow-right class="inline ml-1"/>
  </span>
</div>
---
layout: intro
---

# Part 0
## AI 寫代碼的「天花板」

<p class="opacity-60 mt-2">互動開場</p>

---

# 你有這種感覺嗎？

<div class="flex items-center justify-center h-60">
  <div class="text-4xl font-bold text-center leading-relaxed">
    有了 AI，為什麼開發速度<br>
    <span class="text-primary">沒有提升 10 倍？</span>
  </div>
</div>

<div v-click class="text-center opacity-60 text-lg">
  問題不在 AI 不夠強，問題在我們用錯方式。
</div>

---

# Chat UI 的三道牆

<div class="grid grid-cols-3 gap-6 mt-8">

<div v-click class="p-6 rounded-lg bg-red/10 border border-red/30 text-center">
  <div class="text-4xl mb-4">📋</div>
  <h3 class="font-bold mb-2">Context 碎片化</h3>
  <p class="text-sm opacity-70">每次都要貼同樣的背景資料，AI 永遠不知道你的專案是怎麼回事。</p>
</div>

<div v-click class="p-6 rounded-lg bg-orange/10 border border-orange/30 text-center">
  <div class="text-4xl mb-4">🧠</div>
  <h3 class="font-bold mb-2">知識無法傳承</h3>
  <p class="text-sm opacity-70">資深工程師的 Prompt 沒人知道，AI 能力取決於誰在打字。</p>
</div>

<div v-click class="p-6 rounded-lg bg-yellow/10 border border-yellow/30 text-center">
  <div class="text-4xl mb-4">🎲</div>
  <h3 class="font-bold mb-2">行為不可預測</h3>
  <p class="text-sm opacity-70">這次寫對，下次換個 Session 就寫錯。沒有一致性。</p>
</div>

</div>

<div v-click class="mt-10 p-4 bg-primary/10 border-l-4 border-primary rounded-r">
  <b>今日核心：</b>將 AI 轉化為團隊的「數位工程師」，實現<b>規格驅動 (SDD)</b> 與<b>自動化守護</b>。
</div>

---
layout: intro
---

# Part 1
## Claude Code 初探

<p class="opacity-60 mt-2">這不是另一個 Chat UI</p>

---

# Claude Code 是什麼？

<div class="grid grid-cols-3 gap-6 mt-8">

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">💻</div>
  <h3 class="font-bold mb-2">終端機 CLI</h3>
  <p class="text-sm opacity-70">跑在你的終端機裡，不是網頁聊天介面</p>
</div>

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">📂</div>
  <h3 class="font-bold mb-2">直接動手</h3>
  <p class="text-sm opacity-70">能讀取檔案、執行指令、寫入程式碼</p>
</div>

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">🏠</div>
  <h3 class="font-bold mb-2">本機環境</h3>
  <p class="text-sm opacity-70">在你的專案裡直接動手，無需手動貼上 context</p>
</div>

</div>

<div v-click class="mt-10 p-4 bg-primary/10 border-l-4 border-primary rounded-r text-center">
  這不是 autocomplete，也不是聊天助理。它是能在你的環境裡自主行動的 Agent。
</div>

---

# Chat UI vs Claude Code

<div class="grid grid-cols-2 gap-8 mt-6">

<div>

### Chat UI

<div v-click class="mt-4 space-y-3">
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    每次對話都是空白記憶，需重新交代背景
  </div>
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    需手動貼上 Context、程式碼片段、規範文件
  </div>
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    行為不一致，每個 Session 結果不同
  </div>
</div>

</div>

<div>

### Claude Code

<div v-click class="mt-4 space-y-3">
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    讀取 Repo 設定，帶著專案知識醒來
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    自動理解技術棧、邊界規則、禁止行為
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    行為可預測，全團隊共享一致的 AI 體驗
  </div>
</div>

</div>

</div>

---

# `.claude/` 目錄：AI 的設定家目錄

<div class="mt-6">
  <div class="text-lg opacity-70 mb-6">這裡的設定，決定 AI 在這個專案裡的一切行為。</div>
</div>

<div class="grid grid-cols-2 gap-6">

<div v-click>

```
.claude/
├── CLAUDE.md          # 入職手冊（記憶）
├── skills/            # 可重用技能包
│   ├── slide-review/
│   ├── openspec-propose/
│   ├── openspec-apply/
│   ├── openspec-archive/
│   └── openspec-explore/
├── agents/            # 專責 Subagents
├── hooks/             # 自動化守衛腳本
└── settings.json      # Hooks 設定
```

</div>

<div v-click class="flex flex-col justify-center gap-4">

<div class="p-4 bg-primary/10 border border-primary/30 rounded">
  <b>跟著 Git 走</b>
  <p class="text-sm opacity-70 mt-2">commit 進 Repo，版本可追溯，PR 可 Review</p>
</div>

<div class="p-4 bg-primary/10 border border-primary/30 rounded">
  <b>AI 行為合約</b>
  <p class="text-sm opacity-70 mt-2">不是個人資產，而是團隊共同維護的基礎設施</p>
</div>

</div>

</div>

---
layout: section
---

# Part 2
## 架構思維：Agentic Workflow 的五層演進

<p class="opacity-60 mt-2">心智模型</p>

---

# 從個人到團隊：為什麼 `.claude/` 要跟著 Git 走？

<div class="grid grid-cols-2 gap-8 mt-6">
<div>

### 今日以前
- Prompt 存在各自的記憶裡
- 好的做法靠口耳相傳
- 每個人的 AI 體驗不同
- 無法 Review、無法版本控制

</div>
<div v-click>

### 今日之後
- `.claude/` 目錄進 Git Repo
- 知識成為可審核的程式碼
- 全團隊共享一致的 AI 行為
- PR Review AI 配置變更

</div>
</div>

<div v-click class="mt-8 p-4 bg-secondary/10 border border-secondary/30 rounded text-center">
  <span class="font-bold">核心洞察：</span>AI 的配置是基礎設施的一部分，不是個人資產。
</div>

---

# 五層演進架構

<div class="grid grid-cols-3 gap-3 mt-4">

<div v-click class="p-3 rounded-lg border-2 border-blue/50 bg-blue/5">
  <div class="flex items-center gap-2 mb-1">
    <span class="text-xl">🧠</span>
    <h3 class="font-bold text-sm">記憶 (Memory)</h3>
  </div>
  <code class="text-xs">CLAUDE.md</code>
  <p class="text-xs opacity-60 mt-1">確定性：永遠被載入，不依賴 AI 記憶</p>
</div>

<div v-click class="p-3 rounded-lg border-2 border-green/50 bg-green/5">
  <div class="flex items-center gap-2 mb-1">
    <span class="text-xl">⚡</span>
    <h3 class="font-bold text-sm">技能 (Skills)</h3>
  </div>
  <code class="text-xs">.claude/skills/</code>
  <p class="text-xs opacity-60 mt-1">機率性：將團隊 SOP 編碼化，提升一致性</p>
</div>

<div v-click class="p-3 rounded-lg border-2 border-red/50 bg-red/5">
  <div class="flex items-center gap-2 mb-1">
    <span class="text-xl">🛡️</span>
    <h3 class="font-bold text-sm">守衛 (Governance)</h3>
  </div>
  <code class="text-xs">.claude/settings.json</code>
  <p class="text-xs opacity-60 mt-1">確定性：強制執行，不經詢問</p>
</div>

<div v-click class="p-3 rounded-lg border-2 border-purple/50 bg-purple/5">
  <div class="flex items-center gap-2 mb-1">
    <span class="text-xl">🌐</span>
    <h3 class="font-bold text-sm">連結 (Connectivity)</h3>
  </div>
  <code class="text-xs">MCP</code>
  <p class="text-xs opacity-60 mt-1">機率性：打破本機邊界，連接外部系統</p>
</div>

<div v-click class="p-3 rounded-lg border-2 border-orange/50 bg-orange/5">
  <div class="flex items-center gap-2 mb-1">
    <span class="text-xl">🤝</span>
    <h3 class="font-bold text-sm">分工 (Delegation)</h3>
  </div>
  <code class="text-xs">.claude/agents/</code>
  <p class="text-xs opacity-60 mt-1">機率性：角色專業化，任務委派與分工</p>
</div>

</div>

<div v-click class="mt-6 text-center text-lg font-bold text-primary italic">
  「先建立底線（確定性），再追求加速（機率性）。」
</div>

---
layout: section
---

# Part 3
## 長期記憶：告別「每次都要重教」
---

# CLAUDE.md 不是 README

<div class="grid grid-cols-2 gap-8 mt-6">

<div>

### README 的目的
- 給「人」看的說明文件
- 描述專案是什麼
- 偶爾更新
- 不影響 AI 行為

</div>

<div v-click class="border-l-4 border-primary pl-6">

### CLAUDE.md 的目的
- 給「AI」看的入職手冊
- 定義 AI 能做什麼、不能做什麼
- 隨專案演進持續更新
- **直接決定 AI 的每個決策**

</div>

</div>

<div v-click class="mt-8 p-4 bg-primary/10 rounded text-center">
  <span class="text-2xl font-bold">「CLAUDE.md 是你與 AI 的合約。」</span>
</div>

---

# 案例 1：技術棧鎖定

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

**問題：** AI 推薦了過時的 `pages/` 目錄結構，而你們已全面轉移到 App Router。

<div v-click class="mt-4">

**解法：在 CLAUDE.md 中鎖定**

```markdown
## Tech Stack
- Framework: Next.js v15+ (App Router ONLY)
- UI: Shadcn/ui (never use bare HTML)
- State: Zustand (no Redux)
- Styling: Tailwind (no CSS modules)

## NEVER suggest:
- pages/ directory structure
- getServerSideProps or getStaticProps
```

</div>

</div>

<div v-click class="flex flex-col justify-center">

**結果：**

<div class="space-y-3 mt-4">
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    AI 永遠使用正確的語法
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    不再需要每次糾正
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    新成員也能得到正確的 AI 建議
  </div>
</div>

</div>
</div>

---

# 案例 2：邊界定義

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

**問題：** AI 自作主張修改了 `migrations/` 目錄，導致生產環境 Schema 異常。

<div v-click class="mt-4">

**解法：明確定義禁止行為**

```markdown
## Boundaries (CRITICAL)

### Database
- NEVER edit files in migrations/
- ALL schema changes via Prisma DSL ONLY
- Run `prisma migrate dev` to apply

### Authentication
- NEVER bypass authMiddleware
- Check permissions BEFORE any data op
- Use existing auth helpers in lib/auth/
```

</div>

</div>

<div v-click class="flex flex-col justify-center">

**策略：漸進式揭露**

<div class="mt-4 space-y-3">
  <div class="p-3 bg-blue/10 border border-blue/30 rounded">
    <b class="text-sm">CLAUDE.md</b>
    <p class="text-xs opacity-70 mt-1">只放路標，不放細節</p>
  </div>
  <div class="text-center opacity-50">↓</div>
  <div class="p-3 bg-blue/10 border border-blue/30 rounded">
    <b class="text-sm">docs/database-guide.md</b>
    <p class="text-xs opacity-70 mt-1">細節文件，按需載入</p>
  </div>
</div>

<p class="text-xs opacity-60 mt-4">避免 Context 被稀釋，保持記憶精煉。</p>

</div>
</div>

---
layout: section
---

# Part 4
## Skills：將團隊 SOP 編碼化
---

# 什麼是 Skill？

<div class="grid grid-cols-3 gap-6 mt-8">

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">📖</div>
  <h3 class="font-bold mb-2">主動性</h3>
  <p class="text-sm opacity-70">AI 知道「什麼時候」主動使用這個流程</p>
</div>

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">🎯</div>
  <h3 class="font-bold mb-2">一致性</h3>
  <p class="text-sm opacity-70">每次執行結果格式相同，可預期</p>
</div>

<div v-click class="text-center p-6 rounded-lg bg-primary/5 border border-primary/20">
  <div class="text-4xl mb-3">🔄</div>
  <h3 class="font-bold mb-2">可傳承</h3>
  <p class="text-sm opacity-70">Senior 的最佳實踐成為全團隊的標準</p>
</div>

</div>

<div v-click class="mt-10 text-center">
  <code class="text-lg">.claude/skills/your-skill/SKILL.md</code>
  <p class="opacity-60 mt-2">一個 Markdown 文件 = 一個可重用的 AI 工作流程</p>
</div>

---

# 案例 1：投影片品質審查 Skill

<div class="mt-2">

**痛點**：投影片修改後，難以一致性地確認是否混入時間資訊、受眾標籤等不應出現在投影片上的內容。

</div>

<div class="grid grid-cols-2 gap-6 mt-4">

<div v-click>

### Skill：`slide-review`

```markdown
# Slide Review

## When to use (IMPORTANT)
ALWAYS use this skill when:
- User says "幫我審查投影片"
- User says "review slides"
- After modifying slides.md

## Steps
1. Read slides.md line by line
2. Check for forbidden patterns:
   - Time info (分鐘, min, 小時)
   - Audience labels (工程師, Tech Lead)
3. Output structured violation report

## Output Format
[OK] No violations found
[WARN] Line 42: forbidden pattern "90 分鐘"
  → Remove time info from slides
```

</div>

<div v-click class="bg-gray/5 border border-gray/20 rounded p-4 font-mono text-sm">

```
# 投影片品質審查報告

掃描目標：slides.md

[OK]   Part 0 封面
[OK]   Part 1 章節頁
[WARN] Line 42
       → 發現時間資訊：「90 分鐘」
         投影片不應包含時間長度
[WARN] Line 87
       → 發現受眾標籤：「工程師」
         受眾資訊屬於講者稿

總計：2 個違規，建議修正後重新審查
```

</div>
</div>

---

# 案例 2：設計系統合規檢查

<div class="mt-2">

**痛點**：開發者手寫 `bg-[#f0f]` 或 `p-[13px]`，設計債不斷累積。

</div>

<div class="grid grid-cols-2 gap-6 mt-4">

<div v-click>

### Skill：`check-design-consistency`

```markdown
# Check Design Consistency

## When to use
After adding UI components or modifying
styles. Also use before PR reviews.

## Steps
1. Scan for hardcoded color values (#xxx)
2. Scan for arbitrary spacing values
3. Map to Design Token equivalents
4. Suggest replacements

## Examples
- bg-[#0d99ff] → bg-primary-500
- p-[13px] → p-3 (or discuss with design)
```

</div>

<div v-click class="flex flex-col gap-4">
  <div class="p-4 bg-red/10 border border-red/30 rounded font-mono text-sm">
    <span class="opacity-60">// 違規</span><br>
    className="bg-[#0d99ff] p-[13px]"
  </div>
  <div class="text-center text-2xl">↓</div>
  <div class="p-4 bg-green/10 border border-green/30 rounded font-mono text-sm">
    <span class="opacity-60">// 合規</span><br>
    className="bg-primary-500 p-3"
  </div>
</div>
</div>

---

# 心法：觸發率 90% 的 Skill Description

<div class="grid grid-cols-2 gap-8 mt-6">

<div>

### 壞的寫法（觸發率低）

```markdown
# Security Check
Checks security of the application.
```

<div v-click class="mt-4 p-3 bg-red/10 border border-red/30 rounded text-sm">
  AI 不知道「何時」用，只有被明確呼叫才執行。
</div>

</div>

<div v-click>

### 好的寫法（觸發率高）

```markdown
# Check Admin Security

## When to use (IMPORTANT)
ALWAYS use this skill when:
- Adding any file under app/admin/
- Creating new API routes
- Before creating a pull request
- When user mentions "security"
```

<div class="mt-4 p-3 bg-green/10 border border-green/30 rounded text-sm">
  AI 清楚知道觸發條件，主動執行。
</div>

</div>

</div>

---
layout: center
class: text-center
---

# Demo 2
## Skills 實作

<div class="mt-8 text-6xl">⚡</div>

<div class="mt-6 text-xl opacity-70">用 slide-review Skill 現場審查這場演講的投影片</div>

---
layout: section
---

# Part 5
## Hooks：確定性的自動化防線
---

# 為什麼需要 Hooks？

<div class="text-center mt-8">
  <div class="text-2xl mb-8">你能保證 AI 每次都記得跑 Lint 嗎？</div>
</div>

<div v-click class="text-center text-3xl font-bold text-red mb-4">不行。</div>

<div v-click class="mt-8 p-6 bg-primary/10 border-l-4 border-primary rounded-r text-lg">
  <b>Hooks 的核心價值：</b><br>
  讓關鍵行為從「機率性」變成「確定性」。<br>
  不依賴 AI 的判斷，直接強制執行。
</div>

---

# Hook 生命週期

<div class="flex justify-center mt-8">
  <div class="flex flex-col items-center gap-2 w-full max-w-lg">

  <div v-click class="w-full p-3 bg-blue/10 border border-blue/30 rounded text-center">
    <b>PreToolUse</b>
    <p class="text-xs opacity-70 mt-1">AI 準備執行工具之前</p>
  </div>

  <div class="text-2xl opacity-50">↓</div>

  <div v-click class="w-full p-3 bg-gray/10 border border-gray/30 rounded text-center">
    <b>工具執行</b>
    <p class="text-xs opacity-70 mt-1">寫檔、讀檔、執行命令...</p>
  </div>

  <div class="text-2xl opacity-50">↓</div>

  <div v-click class="w-full p-3 bg-green/10 border border-green/30 rounded text-center">
    <b>PostToolUse</b>
    <p class="text-xs opacity-70 mt-1">工具執行完畢之後</p>
  </div>

  </div>
</div>

<div v-click class="mt-8 text-center opacity-60 text-sm">
  你可以在任何生命週期節點插入自訂邏輯。
</div>

---

# 案例 1：投影片守衛 (PostToolUse)

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

**設定：** AI 編輯 `slides.md` 後，自動執行品質驗證。

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "bash scripts/validate-slides.sh"
          }
        ]
      }
    ]
  }
}
```

<div class="text-xs opacity-50 mt-2">驗證邏輯封裝於外部腳本，方便維護與跨專案重用。</div>

</div>

<div v-click class="flex flex-col justify-center gap-4">

**效果：**

<div class="p-4 bg-green/10 border border-green/30 rounded font-mono text-sm">
  [GUARD] OK
</div>

<div class="p-4 bg-orange/10 border border-orange/30 rounded font-mono text-sm">
  [GUARD] WARN: forbidden pattern<br>
  <span class="opacity-70 text-xs">→ 投影片內容違規，立即告警</span>
</div>

<div class="p-4 bg-green/10 border border-green/30 rounded">
  <b>AI 寫完就驗，不等人工發現</b>
  <p class="text-sm opacity-70 mt-2">每次修改後確定性執行，品質底線自動守住。</p>
</div>

</div>
</div>

---

# 案例 2：內容攔截 (PreToolUse)

<div class="grid grid-cols-2 gap-6 mt-4">

<div>

**設定：** 偵測到投影片內容違規，寫入前直接攔截。

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'if echo \"$CLAUDE_TOOL_INPUT_FILE_PATH\" | grep -q \"slides.md\"; then if echo \"$CLAUDE_TOOL_INPUT_CONTENT\" | grep -qE \"[0-9]+ (分鐘|min)\"; then echo \"BLOCKED: Time information not allowed in slides.md\"; exit 2; fi; fi'"
          }
        ]
      }
    ]
  }
}
```

</div>

<div v-click class="flex flex-col justify-center gap-4">

**效果：確定性防護**

<div class="p-4 bg-red/10 border border-red/30 rounded font-mono text-sm">
  BLOCKED: Time information<br>not allowed in slides.md
</div>

<div class="p-4 bg-gray/10 border border-gray/30 rounded">
  <b>AI 沒有機會決定要不要守規則</b>
  <p class="text-sm opacity-70 mt-2">Hook 在寫入前先讀取內容，偵測時間關鍵字就硬性阻斷。</p>
</div>

<div v-click class="p-4 bg-orange/10 border border-orange/30 rounded">
  <b>Exit Code 控制</b>
  <p class="text-sm opacity-70 mt-2">Exit 0 = 繼續<br>Exit 2 = 阻擋並顯示錯誤<br>Exit 其他 = 警告但繼續</p>
</div>

</div>
</div>

---

# 延伸應用：Worktree 自動管理

<div class="mt-4">

**場景**：多功能並行開發，每個 Feature 需要獨立環境。

</div>

<div class="grid grid-cols-2 gap-6 mt-4">

<div v-click>

```bash
# PostToolUse Hook Script
# 當偵測到新 branch 建立時自動設置環境

if [[ "$CLAUDE_TOOL_NAME" == "Bash" ]]; then
  if echo "$CLAUDE_TOOL_INPUT" | \
     grep -q "git checkout -b"; then
    # 自動建立 worktree
    # 自動安裝依賴
    # 自動設置環境變數
    setup_worktree.sh
  fi
fi
```

</div>

<div v-click class="flex flex-col justify-center">

**好處：**

<div class="space-y-3">
  <div class="p-3 bg-blue/10 border border-blue/30 rounded text-sm">
    開發者不需要手動切換環境
  </div>
  <div class="p-3 bg-blue/10 border border-blue/30 rounded text-sm">
    AI 可以並行處理多個任務
  </div>
  <div class="p-3 bg-blue/10 border border-blue/30 rounded text-sm">
    環境設置錯誤率降為零
  </div>
</div>

</div>
</div>

---
layout: center
class: text-center
---

# Demo 3
## Hooks 自動化守衛實戰

<div class="mt-8 text-6xl">🛡️</div>

<div class="mt-6 text-xl opacity-70">PostToolUse 驗證守衛 & PreToolUse 時間資訊攔截</div>

---
layout: section
---

# Part 6
## MCP：打破本機邊界，連接外部世界
---

# MCP：讓 AI 具備「特務身分」

<div class="mt-6">
  <div class="text-lg opacity-70 mb-6">MCP (Model Context Protocol) 讓 AI 能連接外部系統，不再被本機 Codebase 限制。</div>
</div>

<div class="grid grid-cols-3 gap-4">

<div v-click class="p-4 rounded-lg border border-gray/30 text-center">
  <div class="text-3xl mb-3">🐙</div>
  <b>GitHub MCP</b>
  <p class="text-xs opacity-60 mt-2">查詢 Issue、建立 PR、管理 Branch</p>
</div>

<div v-click class="p-4 rounded-lg border border-gray/30 text-center">
  <div class="text-3xl mb-3">🗄️</div>
  <b>Database MCP</b>
  <p class="text-xs opacity-60 mt-2">查詢生產數據、分析效能問題</p>
</div>

<div v-click class="p-4 rounded-lg border border-gray/30 text-center">
  <div class="text-3xl mb-3">📊</div>
  <b>Monitoring MCP</b>
  <p class="text-xs opacity-60 mt-2">讀取 Metrics、分析 Log</p>
</div>

</div>

<div v-click class="mt-8 p-4 bg-primary/10 border-l-4 border-primary rounded-r">
  <b>案例：</b> AI 讀取 GitHub Issue #123 → 理解需求 → 建立 feature branch → 實作 → 建立 PR，<b>全程自動。</b>
</div>

---
layout: center
class: text-center
---

# Demo 4
## MCP 跨工具協作

<div class="mt-8 text-6xl">🌐</div>

<div class="mt-6 text-xl opacity-70">透過 GitHub MCP 查詢 Open Issues，展示 AI 打破本機限制</div>

---
layout: section
---

# Part 7
## Subagents：角色分工與任務委派
---

# Subagents：讓 AI 具備「專家大腦」

<div class="mt-4 opacity-70">為什麼 Planner 與 Engineer 必須分開？</div>

<div class="grid grid-cols-3 gap-4 mt-6">

<div v-click class="p-6 rounded-lg border-2 border-blue/50 bg-blue/5">
  <div class="text-3xl mb-3 text-center">📐</div>
  <h3 class="font-bold text-center mb-3">Planner Agent</h3>
  <ul class="text-sm space-y-2 opacity-80">
    <li>只管計畫</li>
    <li>絕不寫 code</li>
    <li>輸出：Tasks List</li>
    <li>避免認知偏差</li>
  </ul>
</div>

<div v-click class="p-6 rounded-lg border-2 border-green/50 bg-green/5">
  <div class="text-3xl mb-3 text-center">⚙️</div>
  <h3 class="font-bold text-center mb-3">Engineer Agent</h3>
  <ul class="text-sm space-y-2 opacity-80">
    <li>只管實作</li>
    <li>照計畫執行</li>
    <li>輸出：Code Changes</li>
    <li>不隨意改需求</li>
  </ul>
</div>

<div v-click class="p-6 rounded-lg border-2 border-orange/50 bg-orange/5">
  <div class="text-3xl mb-3 text-center">🔍</div>
  <h3 class="font-bold text-center mb-3">QA / Reviewer Agent</h3>
  <ul class="text-sm space-y-2 opacity-80">
    <li>獨立 Context</li>
    <li>找漏洞與問題</li>
    <li>輸出：Review Report</li>
    <li>比自問自答更有效</li>
  </ul>
</div>

</div>

---

# 為什麼多 Agent 比單一 Agent 更好？

<div class="grid grid-cols-2 gap-8 mt-8">

<div>

### 單一 Agent 的盲點

<div v-click class="mt-4 space-y-3">
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    寫完 code 後自己 Review，容易看不見自己的錯誤
  </div>
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    計畫與實作混在同一個 Context，容易妥協
  </div>
  <div class="p-3 bg-red/10 border border-red/30 rounded text-sm">
    無法客觀評估自己的產出品質
  </div>
</div>

</div>

<div>

### 多 Agent 的優勢

<div v-click class="mt-4 space-y-3">
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    QA Agent 用全新視角審核，找到更多問題
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    角色分離，每個 Agent 專注自己的任務
  </div>
  <div class="p-3 bg-green/10 border border-green/30 rounded text-sm">
    「互相監督」極大化最終品質
  </div>
</div>

</div>
</div>

---
layout: center
class: text-center
---

# Demo 5
## Subagents 角色分工實戰

<div class="mt-8 text-6xl">🤝</div>

<div class="mt-6 text-xl opacity-70">觸發 presentation-reviewer 審查投影片，展示 Agent 委派與分工</div>

---
layout: section
---

# Part 8
## OpenSpec：規格驅動開發的實際工具

<p class="opacity-60 mt-2">核心精華</p>

---

# 所有錯誤的根源

<div class="flex items-center justify-center h-60">
  <div class="text-center">
    <div v-click class="text-5xl font-bold text-primary mb-6">「人機不對齊」</div>
    <div v-click class="text-xl opacity-70">
      你以為 AI 理解了你的需求。<br>
      AI 以為它理解了你的需求。<br>
      <span class="text-red font-bold mt-2 inline-block">但雙方其實理解的是不同的東西。</span>
    </div>
  </div>
</div>

---

# OpenSpec：四個 Skills

<div class="grid grid-cols-2 gap-4 mt-4">

<div v-click class="p-5 rounded-lg border-2 border-blue/40 bg-blue/5">
  <div class="flex items-center gap-3 mb-2">
    <code class="px-2 py-0.5 rounded bg-blue/20 text-blue font-bold text-sm">explore</code>
  </div>
  <h3 class="font-bold mb-1">釐清需求，成為思考夥伴</h3>
  <p class="text-sm opacity-70">在動手前深入探索問題，確保你真正理解自己要解決什麼。</p>
</div>

<div v-click class="p-5 rounded-lg border-2 border-green/40 bg-green/5">
  <div class="flex items-center gap-3 mb-2">
    <code class="px-2 py-0.5 rounded bg-green/20 text-green font-bold text-sm">propose</code>
  </div>
  <h3 class="font-bold mb-1">一步產出完整 Proposal + Design + Tasks</h3>
  <p class="text-sm opacity-70">從需求出發，自動生成完整的規格文件，人機在此對齊。</p>
</div>

<div v-click class="p-5 rounded-lg border-2 border-orange/40 bg-orange/5">
  <div class="flex items-center gap-3 mb-2">
    <code class="px-2 py-0.5 rounded bg-orange/20 text-orange font-bold text-sm">apply</code>
  </div>
  <h3 class="font-bold mb-1">執行 spec 中的任務</h3>
  <p class="text-sm opacity-70">按照已對齊的規格逐步執行，不再猜測，不再走鐘。</p>
</div>

<div v-click class="p-5 rounded-lg border-2 border-purple/40 bg-purple/5">
  <div class="flex items-center gap-3 mb-2">
    <code class="px-2 py-0.5 rounded bg-purple/20 text-purple font-bold text-sm">archive</code>
  </div>
  <h3 class="font-bold mb-1">歸檔已完成的 change</h3>
  <p class="text-sm opacity-70">完成即歸檔，變更有跡可循，未來可追溯。</p>
</div>

</div>

---

# OpenSpec 的核心邏輯

<div class="mt-6 text-center">

<div v-click class="text-2xl mb-8 opacity-80">
  先對齊，再執行。規格是人機之間的合約。
</div>

<div class="flex items-center justify-center gap-3 mt-8 flex-wrap">

<div v-click class="px-5 py-3 rounded-lg bg-blue/10 border border-blue/30 text-center min-w-28">
  <code class="font-bold text-blue">explore</code>
  <p class="text-xs opacity-60 mt-1">釐清問題</p>
</div>

<div v-click class="text-2xl opacity-40">→</div>

<div v-click class="px-5 py-3 rounded-lg bg-green/10 border border-green/30 text-center min-w-28">
  <code class="font-bold text-green">propose</code>
  <p class="text-xs opacity-60 mt-1">對齊規格</p>
</div>

<div v-click class="text-2xl opacity-40">→</div>

<div v-click class="px-5 py-3 rounded-lg bg-orange/10 border border-orange/30 text-center min-w-28">
  <code class="font-bold text-orange">apply</code>
  <p class="text-xs opacity-60 mt-1">按規執行</p>
</div>

<div v-click class="text-2xl opacity-40">→</div>

<div v-click class="px-5 py-3 rounded-lg bg-purple/10 border border-purple/30 text-center min-w-28">
  <code class="font-bold text-purple">archive</code>
  <p class="text-xs opacity-60 mt-1">完成歸檔</p>
</div>

</div>

<div v-click class="mt-10 p-4 bg-primary/10 border border-primary/30 rounded-lg max-w-lg mx-auto">
  <p class="font-bold">先建立底線（確定性），再追求加速（機率性）。</p>
</div>

</div>

---
layout: center
class: text-center
---

# Demo 6
## OpenSpec 現場實戰

<div class="mt-8 text-5xl font-mono text-primary">opsx:propose → opsx:apply</div>

<div class="mt-6 text-xl opacity-70">建立 Proposal → 現場執行 → 新投影片即時出現</div>

---
layout: section
---

# Part 9
## 結語與團隊導入

<p class="opacity-60 mt-2">Q&A</p>

---

# 團隊導入路徑

<div class="mt-4 opacity-70 mb-6">如何說服團隊開始使用 `.claude/`？</div>

<div class="space-y-4">

<div v-click class="flex items-start gap-4 p-4 rounded-lg border border-gray/30">
  <div class="w-10 h-10 rounded-full bg-blue/20 flex items-center justify-center font-bold shrink-0">1</div>
  <div>
    <b>Week 1-2：個人實驗</b>
    <p class="text-sm opacity-70 mt-1">在自己的專案建立 CLAUDE.md，記錄最常被 AI 搞錯的 3 件事。</p>
  </div>
</div>

<div v-click class="flex items-start gap-4 p-4 rounded-lg border border-gray/30">
  <div class="w-10 h-10 rounded-full bg-green/20 flex items-center justify-center font-bold shrink-0">2</div>
  <div>
    <b>Week 3-4：團隊分享</b>
    <p class="text-sm opacity-70 mt-1">在 Team Meeting 展示一個具體的 Hook 或 Skill 案例，讓結果說話。</p>
  </div>
</div>

<div v-click class="flex items-start gap-4 p-4 rounded-lg border border-gray/30">
  <div class="w-10 h-10 rounded-full bg-orange/20 flex items-center justify-center font-bold shrink-0">3</div>
  <div>
    <b>Month 2：共同維護</b>
    <p class="text-sm opacity-70 mt-1">將 .claude/ 加入 Repo，建立 PR Review 流程，讓整個團隊共同貢獻。</p>
  </div>
</div>

<div v-click class="flex items-start gap-4 p-4 rounded-lg border border-gray/30">
  <div class="w-10 h-10 rounded-full bg-purple/20 flex items-center justify-center font-bold shrink-0">4</div>
  <div>
    <b>Month 3+：系統化</b>
    <p class="text-sm opacity-70 mt-1">導入 OpenSpec，所有新功能開發都從 <code>opsx:propose</code> 開始。</p>
  </div>
</div>

</div>

---

# 未來展望

<div class="grid grid-cols-2 gap-8 mt-8">

<div>

### 當所有規範都變成 Agentic Config

<div v-click class="mt-4 space-y-3">
  <div class="p-3 bg-primary/10 rounded text-sm">
    技術決策 → CLAUDE.md
  </div>
  <div class="p-3 bg-primary/10 rounded text-sm">
    團隊流程 → Skills
  </div>
  <div class="p-3 bg-primary/10 rounded text-sm">
    品質守護 → Hooks
  </div>
  <div class="p-3 bg-primary/10 rounded text-sm">
    功能規格 → OpenSpec Proposals
  </div>
</div>

</div>

<div v-click class="flex flex-col justify-center">

<div class="p-6 bg-gradient-to-br from-primary/20 to-purple/20 rounded-lg border border-primary/30 text-center">
  <div class="text-4xl mb-4">🚀</div>
  <p class="font-bold text-lg">AI 不只是工具</p>
  <p class="text-sm opacity-70 mt-2">它是你的數位團隊成員，和你一起維護同一套工程文化。</p>
</div>

</div>

</div>

---
layout: end
---

# 謝謝大家！

<div class="mt-8 text-xl opacity-80">
  開始建立屬於你的 Agentic Workflow
</div>

<div class="mt-12 grid grid-cols-3 gap-6 text-left text-sm">

<div v-click class="p-4 rounded border border-white/20">
  <b>今天就能做</b>
  <p class="opacity-60 mt-2">建立 CLAUDE.md，記錄你的技術棧邊界</p>
</div>

<div v-click class="p-4 rounded border border-white/20">
  <b>本週可以做</b>
  <p class="opacity-60 mt-2">寫一個 Skill，自動化你最常手動執行的流程</p>
</div>

<div v-click class="p-4 rounded border border-white/20">
  <b>下個月目標</b>
  <p class="opacity-60 mt-2">導入 OpenSpec，讓所有功能開發從 <code>opsx:propose</code> 開始</p>
</div>

</div>

<div class="mt-10 opacity-50 text-sm">
  官方文件：docs.anthropic.com/en/docs/claude-code
</div>
