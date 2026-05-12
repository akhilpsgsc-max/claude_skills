# claude_skills

A collection of custom Claude Code skills — reusable, trigger-based instructions that extend Claude's behavior for specific workflows. This is the single source of truth for all skills, personal and project-specific.

## What are skills?

Skills are markdown files that tell Claude how to behave when a specific task type is detected. They define preconditions to check, output structure, judgment rules, and voice guidelines — so Claude produces consistent output without re-prompting every session.

## Setup

Clone and run the install script once. It symlinks `~/.claude/skills` to this repo's `skills/` folder, so every `git pull` instantly updates your local skills with no manual copying.

```bash
git clone https://github.com/akhilpsgsc-max/claude_skills
cd claude_skills
chmod +x install.sh && ./install.sh
```

### New machine setup
Same three commands above. All skills are live immediately after `./install.sh`.

### Adding a new skill
1. Create `skills/<skill-name>/SKILL.md` in this repo with this structure:

```markdown
--- name: <skill-name> description: <one or two sentences — this is what Claude reads to decide whether to trigger the skill. Be specific about phrases and task types that should activate it.> ---

# <Skill title>

## What this skill does
<one paragraph>

## Preconditions — ask if missing
<list of info Claude must have before acting. If missing, Claude asks — never guesses.>

## <Section 1>
...

## <Section N>
...
```

2. `git add . && git commit && git push`

Because `~/.claude/skills` is symlinked to this repo, the skill is available to Claude Code the moment the file exists on disk — no copy needed.

## Skills

### `prd-writer`
**Trigger:** Any request to write a PRD, product spec, feature brief, or requirements doc. Also triggers on "spec out", "scope a feature", or "what should we build for X."

Produces a structured, seven-section PRD (Problem, Goal, User Stories, Acceptance Criteria, Out of Scope, Open Questions, Success Metrics) from a feature description. Asks for missing context before writing — never guesses personas or scope.

Path: `skills/prd-writer/SKILL.md`
