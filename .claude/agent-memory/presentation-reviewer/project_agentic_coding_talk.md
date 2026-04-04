---
name: Agentic Coding presentation project context
description: 88-min technical talk on Claude Code/.claude/ config — 10 Parts (0-9), ~43 Slidev slides, 6 live demos, engineers/tech leads audience
type: project
---

This project is a ~88-minute technical presentation titled "Agentic Coding: From Personal Tool to Team Infrastructure". Target audience is engineers and tech leads, most familiar with Chat UI (ChatGPT/Claude.ai), minority with AI IDE experience.

Structure: 10 parts (Part 0-9), ~43 Slidev slides (including demo placeholder pages), 6 live demos. Key structural decisions as of Apr 2026:
- Part 3 (CLAUDE.md) is concept-only, no demo (Demo 1 removed)
- Part 6 (MCP) and Part 7 (Subagents) are separate parts (previously merged)
- Demo numbering: Demo 1 removed; Demo 2 = slide-review Skill; Demo 3 = Hooks PostToolUse/PreToolUse; Demo 4 = GitHub MCP; Demo 5 = Subagents (.claude/agents/); Demo 6 = OpenSpec (opsx:propose + opsx:apply)
- src/ directory deleted (no Next.js demo project); check-security and sdd-workflow skills deleted
- 5-layer architecture: Memory -> Skills -> Governance -> Connectivity (MCP) -> Delegation (Agents)

**Why:** Speaker wants to convince engineering teams to adopt `.claude/` directory as version-controlled team infrastructure, not just personal tooling.

**How to apply:** All review feedback should evaluate from perspective of an engineer who uses ChatGPT but hasn't tried Claude Code. Demos are critical - always verify demo materials exist and backup plans are defined. When structural changes add Parts, verify Part numbering consistency across OUTLINE.md, slides.md, and scripts.md.
