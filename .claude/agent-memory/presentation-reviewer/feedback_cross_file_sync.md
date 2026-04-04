---
name: Cross-file synchronization check
description: When a demo prompt changes in one file (e.g., PRESENTER_GUIDE), verify it propagates to scripts.md, OUTLINE.md, and demo-prepare.sh
type: feedback
---

When a demo scenario is modified in one file, the same change must propagate across all four places where demo prompts appear:

1. `OUTLINE.md` -- high-level description of demo steps
2. `scripts.md` -- detailed speaker narration with exact commands
3. `scripts/PRESENTER_GUIDE.md` -- step-by-step execution guide
4. `scripts/demo-prepare.sh` -- cheat-sheet printed at the end

**Why:** During the Demo 3 fix (`.env` -> `credentials.json`), PRESENTER_GUIDE.md and demo-prepare.sh were updated but scripts.md and OUTLINE.md were missed. This caused a misalignment where the speaker script would instruct one thing but the presenter guide said another.

**How to apply:** After any demo prompt change, grep for the old prompt text across all four files before marking the fix complete.
