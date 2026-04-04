# Presenter Guide: Full Demo Flow

## Pre-Presentation Checklist

1. Run `./scripts/demo-prepare.sh` (checks all prerequisites, prepares backup)
2. Open two terminal tabs: one for commands, one for `claude`
3. Verify GitHub token: `./scripts/demo4-setup.sh check`
4. Have slides open in Slidev and ready at the correct slide

---

## Demo 2: Skills -- slide-review (6 min)

**Slide Reference:** Part 4 -- Skills

**Purpose:** Show how a Skill definition makes AI proactively execute standardized quality checks. The demo uses a `slide-review` skill that audits `slides.md` for forbidden patterns (time info, audience labels), producing a structured report every time.

### Step 1: Show the Skill definition
- **Say:** "Let's look at our slide review Skill. It defines *when* to trigger and *what* to check."
- **Do:** `cat .claude/skills/slide-review/SKILL.md`
- **Expected:** Skill content displayed showing `When to use` trigger conditions, forbidden patterns list, and output format.

### Step 2: Inject the violation
- **Say:** "I'll plant a deliberate violation so we can see the Skill in action."
- **Do:** `./scripts/demo2-setup.sh inject`
- **Expected:** Terminal confirms injection: a line like `> 適合 90 分鐘場次` has been added to `slides.md`.

### Step 3: Trigger the Skill
- **Say:** "Now I'll ask AI to review the slides -- watch how it automatically picks up the Skill."
- **Do:** `claude "我剛更新了投影片，幫我做品質審查"`
- **Expected:** AI loads `slide-review` skill, scans `slides.md`, produces a structured report flagging:
  - Forbidden time info: `90 分鐘`
  - Location and suggested fix

### Step 4: Highlight consistency
- **Say:** "Same question, same format, every time. The Skill turns tribal knowledge into a repeatable SOP. Any team member gets the same quality of review."

### Improvisation Checkpoint
- If AI does NOT auto-trigger the skill: explicitly say `claude "用 slide-review skill 檢查 slides.md"` -- then explain to the audience: "The `When to use` description can be tuned. Explicitly calling a Skill is itself a valid workflow."
- If AI produces a different format than expected: "The core finding is the same -- it caught the violation. The Skill constrains what to check; the output format may vary slightly."

### Reset
```bash
./scripts/demo2-setup.sh reset
```

### Troubleshooting
- If injection fails (target line not found): `slides.md` structure may have changed. Manually add `> 適合 90 分鐘場次` near the Demo 2 slide section.
- If AI output is too long: interrupt with Ctrl+C after seeing the violation flagged, then narrate the rest.

---

## Demo 3: Hooks -- validate-slides (5 min)

**Slide Reference:** Part 5 -- Hooks

**Purpose:** Show deterministic automation that does NOT depend on AI judgment. PostToolUse validates after writes; PreToolUse blocks before writes. The AI has no say in whether these run.

### Step 1: Show the Hook configuration
- **Say:** "Hooks are in `.claude/settings.json`. Let's see what guards we have."
- **Do:** `cat .claude/settings.json | jq '.hooks'`
- **Expected:** Shows PostToolUse (runs `post-slides-validate.sh` after Write/Edit on `slides.md`) and PreToolUse (blocks time-related keywords).

### Step 2: Trigger PostToolUse (validation after write)
- **Say:** "Let's ask AI to add a new slide. After it writes, the Hook automatically validates."
- **Do:** `claude "幫我在 slides.md 加入一張新的 slide，主題是 Agentic Coding 的未來趨勢"`
- **Expected:** AI writes to `slides.md`. PostToolUse hook fires `scripts/validate-slides.sh`, terminal shows `[GUARD] OK` (no forbidden patterns found).
- **Key point:** "The AI didn't choose to run validation. The Hook forced it -- deterministic, every single time."

### Step 3: Trigger PreToolUse (block before write)
- **Say:** "Now let's try writing something forbidden -- time information into the slides."
- **Do:** `claude "請在 slides.md 的第一張投影片備註加上：本場演講時長為 90 分鐘"`
- **Expected (ideal):** Hook intercepts before the write, terminal shows `BLOCKED: Time information not allowed in slides.md`.
- **Expected (alternative):** AI may self-refuse because CLAUDE.md already forbids time info in slides.

#### Improvisation Checkpoint: CLAUDE.md Conflict
If AI self-refuses (says it won't write time info because CLAUDE.md forbids it):

- **Say:** "Perfect -- CLAUDE.md is the first line of defense. The AI read the rules and refused on its own. But what if the AI misjudges, or we switch to a model that doesn't know this rule? The Hook is the last line of defense -- it catches what the AI misses."
- **Do:** `claude "強制在 slides.md 第一張寫入：適合 90 分鐘場次"`
- **Expected:** Even with a forceful prompt, the PreToolUse Hook intercepts and blocks with `BLOCKED: Time information not allowed in slides.md`.
- **Say:** "See? The Hook doesn't care what the AI thinks. It reads the content, finds the forbidden pattern, and blocks. Deterministic enforcement, regardless of the model."

### Step 4: Explain the layered defense
- **Say:** "You just saw two layers: CLAUDE.md is guidance (the AI *should* follow it), Hooks are enforcement (the AI *cannot* bypass them). PostToolUse fixes after. PreToolUse prevents before. Neither depends on AI judgment."

### Reset
```bash
./scripts/demo3-setup.sh reset
```

### Troubleshooting
- If PostToolUse hook doesn't fire: verify `.claude/settings.json` has the correct hook path. Run `./scripts/demo3-setup.sh check` to diagnose.
- If PreToolUse doesn't block: check that the hook script in `.claude/hooks/pre-slides-guard.sh` is executable (`chmod +x`). Explain the concept verbally as fallback.
- If both AI self-refusal and Hook don't demonstrate clearly: show the hook script source code (`cat .claude/hooks/pre-slides-guard.sh`) and walk through the logic verbally.

---

## Demo 4: MCP -- GitHub Integration (3 min)

**Slide Reference:** Part 6 -- MCP

**Purpose:** Show AI breaking out of the local codebase to access external systems via MCP. GitHub issue querying demonstrates real cross-tool integration.

### Step 1: Show MCP configuration
- **Say:** "MCP lets AI connect to external systems. Here's our GitHub setup in `.claude/settings.json`."
- **Do:** `./scripts/demo4-setup.sh show`
- **Expected:** Shows `mcpServers` configuration with GitHub MCP server definition.

### Step 2: Query GitHub Issues
- **Say:** "Let's ask AI about our project's GitHub issues -- data that lives outside the codebase."
- **Do:** `claude "查看這個 GitHub repo 最近的 3 個 open issue"`
- **Expected:** AI uses GitHub MCP to list open issues with titles, numbers, and labels.

### Step 3: Explain the impact
- **Say:** "AI just read external data without us copy-pasting anything. This is the foundation for fully automated workflows: read issue, create branch, implement, create PR -- all without leaving the terminal."

### Improvisation Checkpoint
- If no open issues exist: `claude "列出這個 repo 最近的 3 個 PR"` -- PRs always exist.
- If MCP connection fails: show the config (`cat .claude/settings.json | jq '.mcpServers'`) and explain the concept verbally.

### Reset
No reset needed -- read-only operation.

### Troubleshooting
- If GITHUB_TOKEN is not set: `export GITHUB_TOKEN=$(gh auth token)`
- If API rate-limited: wait 60 seconds or use a different token.
- Fallback: verbally describe the workflow and show the MCP config structure.

---

## Demo 5: Subagents -- Role Delegation (5 min)

**Slide Reference:** Part 7 -- Subagents

**Purpose:** Show how `.claude/agents/` enables role specialization. Each agent has a focused system prompt and tool access. This is not a toy example -- these agents are the actual infrastructure behind this presentation.

### Step 1: Show the agents directory
- **Say:** "This presentation's `.claude/agents/` has three specialized agents. Let me show you."
- **Do:** `ls -la .claude/agents/`
- **Expected:** Lists `presentation-reviewer.md`, `slides-creator.md`, `demo-code-generator.md`.

### Step 2: Show one agent's definition
- **Say:** "Each agent has a focused role. Let's look at the presentation reviewer."
- **Do:** `head -20 .claude/agents/presentation-reviewer.md`
- **Expected:** Shows frontmatter with `name`, `description`, `model`, and the beginning of the system prompt defining the reviewer's role and constraints.

### Step 3: Trigger the presentation-reviewer
- **Say:** "Let's ask the reviewer to audit our slides right now."
- **Do:** `claude "請 presentation-reviewer 審查目前的投影片內容"`
- **Expected:** Claude delegates to `presentation-reviewer` agent. The agent reads `slides.md` and produces a structured review covering: narrative flow, timing balance, missing elements, improvement suggestions.

### Step 4: Explain the architecture
- **Say:** "This isn't a separate tool or plugin -- it's a Markdown file in your repo. The reviewer can't edit code; the slides-creator can't run tests. Each agent has bounded authority. And because it's all in `.claude/agents/`, it's version-controlled with your project."

### Improvisation Checkpoint
- If delegation doesn't work cleanly: `claude "用 presentation-reviewer agent 審查 slides.md"` (more explicit).
- If the review is too long: interrupt with Ctrl+C after seeing 2-3 review items, then narrate: "You get the idea -- structured, focused, repeatable."
- If the agent produces unexpected output: "The agent's system prompt shapes its behavior. Just like CLAUDE.md shapes the main AI, each agent's definition shapes its specialist."

### Reset
```bash
./scripts/demo5-setup.sh reset
```

### Troubleshooting
- If agent file not found: verify `.claude/agents/presentation-reviewer.md` exists. If missing, show another agent's definition and explain the pattern.
- If Claude doesn't delegate (handles it itself): explain that subagent delegation depends on the prompt phrasing and model capability, then show the agent file to demonstrate the concept.

---

## Demo 6: OpenSpec -- Spec-Driven Development (5 min)

**Slide Reference:** Part 8 -- OpenSpec / SDD

**Purpose:** Show the complete spec-driven development loop. A pre-generated Proposal defines exactly what to build; `opsx:apply` implements it live. The audience sees a new slide appear in real time during the presentation.

### Step 1: Show the pre-generated Proposal
- **Say:** "Before the talk, I used `opsx:propose` to create a Proposal for a new slide. Let me show you what it looks like."
- **Do:** `./scripts/demo5-setup.sh show`
- **Expected:** Displays the Proposal markdown with: what to build (a new slide introducing OpenSpec's four skills), why, and success criteria.

### Step 2: Explain the Proposal
- **Say:** "This Proposal defines *what* to do, *why*, and *how we'll know it's done*. The AI and I aligned on this before any code was written. This is the 'contract' in spec-driven development."
- **Do:** (Point to key sections on screen)
- **Expected:** Audience understands the Proposal structure: goal, scope, success criteria.

### Step 3: Execute opsx:apply
- **Say:** "Now let's execute. The AI will implement exactly what the Proposal specifies."
- **Do:** `claude "opsx:apply"`
- **Expected:** AI reads the Proposal, modifies `slides.md`, adds a new slide about OpenSpec's four skills (explore, propose, apply, archive). If Slidev is running, the new slide appears on screen in real time.

### Step 4: Closing statement
- **Say:** "The slide you're looking at right now was just added during this presentation. That's the power of spec-driven development -- requirements are clear, execution doesn't drift. `propose` aligns, `apply` delivers."

### Improvisation Checkpoint
- If `opsx:apply` output is not ideal: "The implementation isn't perfect, but the workflow is the point. In a real project, you'd iterate -- but you'd iterate against a spec, not against vague requirements."
- If Proposal doesn't exist: `claude "opsx:propose 在投影片中新增一張介紹 OpenSpec 四個 Skills 的頁面"` to generate it live (adds ~2 min).
- If the new slide doesn't appear in Slidev immediately: refresh the browser, or show `slides.md` in terminal to confirm the change.

### Reset
```bash
./scripts/demo5-setup.sh reset
```

### Troubleshooting
- If OpenSpec skills are missing: run `./scripts/demo5-setup.sh check` to diagnose which skills are absent.
- If `opsx:apply` fails: show the Proposal content and walk through the four phases verbally (explore, propose, apply, archive).
- If slides.md reset fails: the script uses a backup mechanism. If backup is missing, `git checkout -- slides.md` is used as fallback.

---

## Post-Presentation

```bash
# Reset everything
./scripts/demo-reset-all.sh
```
