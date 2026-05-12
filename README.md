# claude_skills

A collection of custom skills for [Claude Code](https://claude.ai/code) — reusable, trigger-based instructions that extend Claude's behavior for specific workflows.

Skills live under `.claude/skills/<skill-name>/SKILL.md` and are automatically available in any Claude Code session that uses this repo.

## What are skills?

Skills are markdown files that tell Claude how to behave when a specific task type is detected. They define preconditions to check, output structure, judgment rules, and voice guidelines — so Claude produces consistent, high-quality output without needing re-prompting each time.

## Skills

### `prd-writer`
**Trigger:** Any request to write a PRD, product spec, feature brief, or requirements doc. Also triggers on "spec out", "scope a feature", or "what should we build for X."

Produces a structured, seven-section PRD (Problem, Goal, User Stories, Acceptance Criteria, Out of Scope, Open Questions, Success Metrics) from a feature description. Asks for missing context before writing — never guesses personas or scope.

Path: `.claude/skills/prd-writer/SKILL.md`

## Usage

Clone this repo and point Claude Code at it, or copy individual skill files into your project's `.claude/skills/` directory.

```bash
git clone https://github.com/akhilpsgsc-max/claude_skills
```
