---
name: Reviewer must not create files directly
description: presentation-reviewer should never create demo files or edit slides/scripts directly - must delegate to slides-creator or demo-code-generator agents via Tasks
type: feedback
---

The presentation-reviewer must NOT create files (demo code, slides, scripts) directly. It should only:
1. Read and analyze OUTLINE.md, slides.md, scripts.md
2. Identify issues (Critical/Major/Minor)
3. Modify OUTLINE.md if structure/timing changes are needed
4. Delegate all other fixes via Tasks to the appropriate subagent (slides-creator for slides/scripts, demo-code-generator for demo code)

**Why:** User explicitly corrected this behavior when reviewer tried to create 17 demo files directly. Each agent has its own expertise and constraints (e.g., demo-code-generator mandates scripts/ and src/ directories, NOT demos/).

**How to apply:** When Critical/Major issues are found, create Tasks with detailed instructions for the correct subagent. Never write to slides.md, scripts.md, or demo directories directly.
