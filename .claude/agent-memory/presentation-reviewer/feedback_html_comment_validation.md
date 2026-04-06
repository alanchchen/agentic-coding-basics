---
name: HTML comment blocks must be skipped in slide validation
description: validate-slides.sh and slide-review SKILL.md must skip HTML comment blocks since speaker notes are now embedded there
type: feedback
---

When speaker notes moved from a separate scripts.md into slides.md HTML comments (`<!-- -->`), all validation tools that scan slides.md must be updated to skip HTML comment blocks. Otherwise, time references like "約 5 分鐘" in presenter notes trigger false positives.

Affected files:
- `scripts/validate-slides.sh` — needs HTML comment tracking (currently only tracks ``` code blocks)
- `.claude/skills/slide-review/SKILL.md` — references to scripts.md need updating
- `.claude/hooks/pre-slides-guard.sh` — error message references scripts.md

**Why:** Discovered in Apr 2026 review — validate-slides.sh flagged line 1701 ("分鐘" in a speaker note comment) as a violation, which would cause Demo 2 and Demo 3 to produce confusing false positives during live performance.

**How to apply:** Whenever the speaker note storage mechanism changes, audit all validation scripts that scan slides.md for content patterns.
