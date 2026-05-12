---
name: new-project
description: Use this skill whenever the user says "new project",
  "starting a project", "init a repo", "set up a new app", "new repo",
  "bootstrap a project", or opens a folder that has no CLAUDE.md.
  Always trigger this skill at the start of any new codebase to ensure
  the project is properly configured before any work begins.
---

# New project setup

## What this skill does
Checks if CLAUDE.md exists in the current directory. If not, creates
it from the template and asks the user to fill in their stack. Ensures
every project starts with the full operating manual in place.

## Steps

1. Check if CLAUDE.md exists in the current directory
   - Run: ls CLAUDE.md
   - If it exists: print "CLAUDE.md already exists. You're good to go."
     and stop
   - If missing: continue to step 2

2. Ask the user three questions (all at once, not one at a time):
   - What is the app name?
   - What is the tech stack? (frontend, backend, database, hosting)
   - Any custom chains or rules specific to this project?

3. Copy the template into place:
   - Source: ~/.claude/skills/new-project/templates/CLAUDE.md.template
   - Destination: ./CLAUDE.md
   - Replace [Your App Name] with the app name from step 2
   - Fill in the stack section with answers from step 2
   - Add any custom rules from step 2 into the Rules section

4. Create the docs/ folder if it doesn't exist

5. Commit everything:
   git add CLAUDE.md docs/
   git commit -m "init: add CLAUDE.md and docs folder"

6. Print:
   "[APP_NAME] is ready.
    - CLAUDE.md committed
    - docs/ folder created
    - Run prd-writer when you're ready to define your first feature"
