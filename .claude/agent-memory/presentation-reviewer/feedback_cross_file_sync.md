---
name: Cross-file synchronization check
description: When a demo prompt changes in one file, verify it propagates to OUTLINE.md, slides.md (embedded notes), PRESENTER_GUIDE, and demo-prepare.sh
type: feedback
---

When a demo scenario is modified in one file, the same change must propagate across all places where demo prompts appear:

1. `OUTLINE.md` -- high-level description of demo steps
2. `slides.md` (embedded `<!-- -->` HTML comments) -- detailed speaker narration with exact commands
3. `scripts/PRESENTER_GUIDE.md` -- step-by-step execution guide
4. `scripts/demo-prepare.sh` -- cheat-sheet printed at the end

Note: There is NO separate `scripts.md` file. Speaker notes are embedded in slides.md as HTML comments.

**Why:** During prior fix cycles, changes in one file (e.g., PRESENTER_GUIDE.md) were not propagated to the embedded notes in slides.md, causing misalignment between what the speaker reads and what the guide instructs.

**How to apply:** After any demo prompt change, grep for the old prompt text across all four locations before marking the fix complete. Pay special attention to slides.md HTML comments which are easy to miss.
