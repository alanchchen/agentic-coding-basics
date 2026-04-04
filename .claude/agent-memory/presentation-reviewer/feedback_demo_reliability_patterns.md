---
name: Demo reliability anti-patterns for AI-driven live demos
description: Key patterns discovered during Criterion 6 review -- never depend on AI making errors, always have improvisation checkpoints for probabilistic features
type: feedback
---

Three critical anti-patterns for live AI demos:

1. **Never depend on AI making errors for Before/After contrast.** AI models improve over time and may not make the "expected" mistake. Instead, build contrast on project-private knowledge (conventions, boundaries, internal APIs) that AI cannot know without configuration. This makes the demo deterministic.

2. **CLAUDE.md NEVER rules can prevent Hook demos from firing.** If CLAUDE.md tells AI to NEVER modify a file, AI will self-refuse before the Write tool is invoked, so PreToolUse hooks never trigger. Choose demo targets that are caught by hooks but NOT listed in CLAUDE.md prohibitions.

3. **Skills are probabilistic -- always have an improvisation checkpoint.** When demoing Skill auto-trigger, have a two-step approach: first try auto-trigger, then have explicit redirect ready. Frame the fallback as a teaching moment about Skill description quality.

**Why:** Discovered during Criterion 6 (Demo Reliability) review of 5 live demos. Demos 1, 3, and 5 all had variants of these issues.

**How to apply:** When reviewing any demo that depends on AI behavior, check: (a) is the expected behavior deterministic or probabilistic? (b) if probabilistic, is there a fallback that still teaches the concept? (c) do CLAUDE.md rules conflict with the demo scenario?
