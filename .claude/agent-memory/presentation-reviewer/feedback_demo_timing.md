---
name: Demo and concept timing consistency patterns
description: OUTLINE concept sections (non-demo) also underestimate time vs scripts; always sum per-slide script times to verify
type: feedback
---

Two timing patterns to watch:

1. **Demo time overestimation**: OUTLINE.md demo time percentages can overstate actual demo durations compared to scripts.md. Always calculate demo times from scripts.md first.

2. **Concept section underestimation**: Concept-heavy Parts (like Part 2 architecture overview with 5 slides) tend to be allocated too little time in OUTLINE. In Apr 2026, Part 2 was allocated 6 min but scripts needed ~8 min (37% overshoot). The fix was adjusting OUTLINE to match script reality.

**Why:** OUTLINE is written top-down with time budgets, but scripts are written bottom-up per slide. The bottom-up sum is more accurate.

**How to apply:** For every Part, sum the per-slide times in scripts.md and compare to OUTLINE allocation. Flag >15% deviation as Critical. Concept-only Parts with 4+ slides typically need 1.5-2 min per slide minimum.
