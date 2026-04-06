---
name: Agentic Coding presentation project context
description: 86-min technical talk on Claude Code/.claude/ config — 10 Parts (0-9), ~34 Slidev content slides + 5 demo placeholders, 5 live demos (Demo 2-6), engineers/tech leads audience
type: project
---

This project is a ~86-minute technical presentation titled "Agentic Coding: From Personal Tool to Team Infrastructure". Target audience is engineers and tech leads, most familiar with Chat UI (ChatGPT/Claude.ai), minority with AI IDE experience.

**Key architecture change (Apr 2026):** Speaker notes (presenter scripts) are now embedded directly in slides.md as HTML comment blocks (`<!-- -->`). There is NO separate scripts.md file. All review criteria referencing "scripts.md" are outdated.

Structure: 10 parts (Part 0-9), ~34 Slidev content slides + 5 demo placeholder slides, 5 live demos. Key structural decisions:
- Part 3 (CLAUDE.md) is concept-only, no demo (Demo 1 removed)
- Part 6 (MCP) and Part 7 (Subagents) are separate parts
- Demo numbering: Demo 2 = slide-review Skill; Demo 3 = Hooks PostToolUse/PreToolUse; Demo 4 = GitHub MCP; Demo 5 = Subagents (.claude/agents/); Demo 6 = OpenSpec (opsx:propose + opsx:apply)
- src/ directory deleted (no Next.js demo project); all demos use this repo itself
- 5-layer architecture: Memory -> Skills -> Governance -> Connectivity (MCP) -> Delegation (Agents)

**Why:** Speaker wants to convince engineering teams to adopt `.claude/` directory as version-controlled team infrastructure, not just personal tooling.

**How to apply:** All review feedback should evaluate from perspective of an engineer who uses ChatGPT but hasn't tried Claude Code. Demos are critical - always verify demo materials exist and backup plans are defined. When checking cross-file sync, verify consistency across OUTLINE.md, slides.md (including embedded notes), scripts/PRESENTER_GUIDE.md, and scripts/demo-prepare.sh.
