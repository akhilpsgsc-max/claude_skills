#!/bin/bash
# Run once after cloning: ./install.sh
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_TARGET="$HOME/.claude/skills"
CLAUDE_TARGET="$HOME/.claude/CLAUDE.md"

if [ -L "$SKILLS_TARGET" ]; then
  echo "Symlink already exists at $SKILLS_TARGET"
elif [ -d "$SKILLS_TARGET" ]; then
  echo "Directory exists at $SKILLS_TARGET — backing up to ${SKILLS_TARGET}.bak"
  mv "$SKILLS_TARGET" "${SKILLS_TARGET}.bak"
fi

ln -s "$REPO_DIR/skills" "$SKILLS_TARGET"
echo "Linked $SKILLS_TARGET -> $REPO_DIR/skills"

if [ -L "$CLAUDE_TARGET" ]; then
  echo "Symlink already exists at $CLAUDE_TARGET"
elif [ -f "$CLAUDE_TARGET" ]; then
  echo "File exists at $CLAUDE_TARGET — backing up to ${CLAUDE_TARGET}.bak"
  mv "$CLAUDE_TARGET" "${CLAUDE_TARGET}.bak"
fi

ln -s "$REPO_DIR/config/CLAUDE.md" "$CLAUDE_TARGET"
echo "Linked $CLAUDE_TARGET -> $REPO_DIR/config/CLAUDE.md"
