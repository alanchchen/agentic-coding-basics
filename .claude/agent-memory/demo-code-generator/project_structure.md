---
name: Demo file structure convention
description: Demo files live in repo standard directories, never in nested sub-projects like src/demo-project/
type: feedback
---

Demo files must be placed directly in the repo's standard directories:
- `.claude/skills/` for skill definitions
- `.claude/settings.json` for hooks and MCP config
- `docs/` for documentation files
- `scripts/` for setup/reset shell scripts
- `src/` for source code (flat, no sub-project nesting)

**Why:** User explicitly rejected `src/demo-project/` nesting and alternative directory names like `claude-skills/`, `claude-settings/`. The demo should showcase real `.claude/` directory structure as it would appear in a production repo.

**How to apply:** When regenerating demos, always use the canonical `.claude/` paths. Scripts reference files at repo root level, not inside any sub-project.
