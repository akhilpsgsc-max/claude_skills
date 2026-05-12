# About Me

I am Akhil Prabhakaran, a solutions architect at BSP Corp working on Zoho One platform implementations. My primary projects involve:
- Building Zoho Catalyst serverless provisioning engines (Node.js)
- Building AI applications using the Anthropic Claude API (Python + Node.js)
- Architecture design and technical documentation for multi-tenant ERP systems

# Working Style

- I prefer concise, direct responses — no padding or summaries of what was just done
- Default to writing no comments in code unless the WHY is non-obvious
- For exploratory questions, give a 2-3 sentence recommendation with the main tradeoff
- Don't add features or abstractions beyond what's asked
- Python for data/AI work, Node.js for Catalyst serverless functions

# Tech Stack

- **Zoho**: Catalyst (serverless functions), Creator, CRM, Books, Desk, Analytics, Directory
- **AI**: Anthropic Claude API (anthropic SDK), prompt caching, tool use
- **Languages**: Python 3.12 (AI/data), JavaScript/TypeScript (Catalyst/serverless)
- **Tools**: Git, GitHub CLI, uv (Python), npm (Node.js)
- **Platform**: macOS (Apple Silicon)

# Python Environment

- Global dev venv at `~/.venv` (Python 3.12, has anthropic SDK)
- Activate with: `source ~/.venv/bin/activate`
- For new AI projects: `uv venv .venv && uv pip install anthropic` (project-level venv)
- Never `pip install` into system Python — always use a venv

# Global Claude Code Operating Manual

## Skills available in every session

Custom skills (~/.claude/skills/):
  prd-writer    → write a PRD before any feature work
  new-project   → run at the start of every new project

GStack (~/.claude/skills/gstack/):
  /autoplan, /review, /qa, /ship, /cso, /investigate,
  /careful, /office-hours, /plan-eng-review, /retro

## Core workflows

New project:
  "new project" → new-project skill → CLAUDE.md created and committed

New feature:
  prd-writer → /plan-eng-review → /autoplan → build → /review → /qa → /ship

Bug fix:
  /careful → /investigate → fix → /review → /ship

## Global rules

1. Always check for CLAUDE.md at the start of a session
2. If no CLAUDE.md exists, trigger the new-project skill before anything else
3. Always read docs/prd-*.md before reviewing or planning
4. Never build without an approved /autoplan first
5. Always /investigate before fixing any bug
