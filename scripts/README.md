# Demo Overview

All demo files live directly in the repo's standard directories. This document provides a quick reference.

## Demo Map

| Demo | Part | Time | Key Concept | Key Files |
|------|------|------|-------------|-----------|
| Demo 1 | Part 4 | 6 min | Skills (slide-review) | `.claude/skills/slide-review/SKILL.md` |
| Demo 2 | Part 5 | 5 min | Hooks (validate + guard) | `.claude/settings.json`, `.claude/hooks/` |
| Demo 3 | Part 6 | 3 min | MCP (GitHub) | `.claude/settings.json` (mcpServers) |
| Demo 4 | Part 7 | 5 min | Subagents (presentation-reviewer) | `.claude/agents/` |

## File Locations

```
CLAUDE.md                              # Part 3: AI memory / onboarding doc (concept, no demo)
.claude/
  settings.json                        # Demo 2 & 4: hooks + MCP config
  hooks/
    pre-slides-guard.sh                # Demo 2: blocks time info in slides.md
    post-slides-validate.sh            # Demo 2: auto-validate after write
    pre-tool-use-guard.sh              # General: blocks sensitive file writes
  skills/
    slide-review/SKILL.md              # Demo 1: slides quality audit skill
  agents/
    presentation-reviewer.md           # Demo 4: subagent example
    slides-creator.md                  # Demo 4: subagent example
    demo-code-generator.md             # Demo 4: subagent example
scripts/
  validate-slides.sh                   # Demo 2: forbidden pattern scanner
  demo-prepare.sh                      # One-click setup before presentation
  demo-reset-all.sh                    # Reset all demos to clean state
  demo1-setup.sh                       # Demo 1: inject violation / reset
  demo2-setup.sh                       # Demo 2: verify hooks / reset
  demo3-setup.sh                       # Demo 3: show MCP config / check token
```

## Quick Start

```bash
# Before the presentation
./scripts/demo-prepare.sh

# After the presentation (or to practice again)
./scripts/demo-reset-all.sh
```
