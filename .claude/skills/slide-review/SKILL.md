# Slide Review

投影片品質審查 Skill：掃描 slides.md，偵測不應出現在投影片上的內容。

## When to use (IMPORTANT)

ALWAYS use this skill when:
- User says "幫我審查投影片" or "review slides" or "check slides"
- User says "投影片品質" or "slide quality"
- After any modification to `slides.md`
- Before committing changes that include `slides.md`
- When user asks to verify slides are clean / ready for presentation

## Context

投影片 (`slides.md`) 是面向觀眾的內容。以下資訊屬於講者稿（內嵌在 `slides.md` 的 `<!-- -->` HTML comment 區塊中）或內部文件，**絕對不能**出現在投影片的可見內容上：

1. **時間資訊** — 場次長度、段落時間分配等（例如 `90 分鐘`、`5 min`、`小時`）
2. **受眾標籤** — 明確標示目標聽眾的文字（例如 `軟體工程師`、`Team Lead`、`Tech Lead`）

## Steps

1. **Read** `slides.md` in its entirety
2. **Scan** every line for forbidden patterns:
   - Time information: any match of `\d+\s*min`, `分鐘`, `小時`, `\d+\s*分`, `場次`, `時間分配`
   - Audience labels: `軟體工程師`, `Team Lead`, `Tech Lead`, `工程師 /`, `適合.*工程師`
3. **Skip** lines inside code blocks (``` fenced blocks) and HTML comment blocks (`<!-- ... -->`) — code examples may legitimately contain these patterns, and HTML comments contain speaker notes
4. **Compile** a structured violation report
5. **Suggest** specific fixes for each violation

## Output Format

Always output the report in this exact format:

```
# 投影片品質審查報告

掃描目標：slides.md
掃描時間：YYYY-MM-DD HH:mm

## 掃描結果

[OK]   Slide N: <slide title>
[WARN] Slide N, Line L: <violation type>
       原文：「<offending text>」
       建議：<how to fix>

## 總結
- 總掃描投影片數：N
- 通過：N
- 違規：N
- 建議：<overall recommendation>
```

## Important

- WARN = 違規，必須修正才能上台
- 每個違規都要提供具體的修正建議，不只是標記問題
- 如果沒有違規，輸出 `[OK] slides.md 通過品質審查，未發現違規內容。`
- Code block 內的內容不算違規（投影片上展示 code 範例是合理的）
