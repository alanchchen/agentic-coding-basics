# Slidev Skill 指南

Slidev 是一個專為開發者設計的簡報平台，讓你可以使用 Markdown 撰寫投影片，同時利用 Vue 和 Web 技術實現互動式、像素級完美的設計。

<instructions>

## 快速開始與設定

### 安裝與初始化
使用以下指令建立新的 Slidev 專案：
- `npm init slidev` 或 `pnpm create slidev`

### 核心指令
- 啟動開發伺服器: `slidev` 或 `slidev slides.md`
- 建立正式版本: `slidev build`
- 匯出 PDF: `slidev export`
- 格式化投影片: `slidev format`

## Markdown 語法

### 投影片分隔
使用 `---` 並在前後留空行來分隔投影片。

### Frontmatter 設定
在檔案開頭（Headmatter）或個別投影片開頭設定 YAML 區塊：
```yaml
---
theme: default
layout: center
highlighter: shiki
---
```

### 程式碼區塊
支援語法高亮、行號顯示與特定行高亮：
- 行號: ` ```ts {lines:true} `
- 高亮特定行: ` ```ts {2,4-6} `
- Monaco 編輯器: ` ```ts {monaco} `

## 佈局 (Layouts)
在 Frontmatter 中指定 `layout`。內建佈局包括：
- 基礎: `default`, `center`, `cover`, `end`, `none`
- 內容: `intro`, `section`, `quote`, `fact`, `statement`, `full`
- 圖片: `image`, `image-left`, `image-right`
- 雙欄: `two-cols`, `two-cols-header`

## 元件 (Components)
### 內建元件
- 導覽: `<Link>`, `<Arrow>`, `<Toc>`
- 媒體: `<Youtube id="xxx" />`, `<Tweet id="xxx" />`
- 文字: `<AutoFitText>`
- 互動: `<VSwitch>`, `<VDrag>`

### 自定義元件
將 Vue 元件放在 `./components/` 目錄下，Slidev 會自動匯入。

## 動畫 (Animations)
- `v-click`: 點擊後顯示。
- `v-after`: 與前一個動畫同時或之後顯示。
- `v-clicks`: 用於列表自動加入點擊動畫。
- `v-motion`: 使用 `@vueuse/motion` 進行更複雜的動作動畫。

## 樣式與主題
- **UnoCSS**: 支援 Tailwind 相容的 utility classes。
- **自定義樣式**: 建立 `./styles/index.css`。
- **主題**: 在 Headmatter 設定 `theme: theme-name`。常用主題包括 `seriph`, `apple-basic`, `shibainu`。

## 匯出選項
- `--format`: pdf, pptx, png, md
- `--with-clicks`: 包含動畫步驟
- `--range`: 指定投影片範圍 (例如 `1,6-8,10`)
- `--dark`: 使用深色模式匯出

## 進階功能
- **匯入投影片**: 使用 `src: ./other.md` 匯入外部檔案。
- **全域圖層**: 建立 `global-top.vue` 或 `global-bottom.vue`。
- **遠端存取**: `slidev --remote`。

</instructions>

<available_resources>
- 官方網站: https://sli.dev
- 語法指南: https://sli.dev/guide/syntax
- 主題庫: https://sli.dev/themes/gallery
</available_resources>
