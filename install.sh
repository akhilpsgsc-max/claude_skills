#!/bin/bash
# Run once after cloning: ./install.sh
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_TARGET="$HOME/.claude/skills"

if [ -L "$SKILLS_TARGET" ]; then
  echo "Symlink already exists at $SKILLS_TARGET"
elif [ -d "$SKILLS_TARGET" ]; then
  echo "Directory exists at $SKILLS_TARGET — backing up to ${SKILLS_TARGET}.bak"
  mv "$SKILLS_TARGET" "${SKILLS_TARGET}.bak"
fi

ln -s "$REPO_DIR/skills" "$SKILLS_TARGET"
echo "Linked $SKILLS_TARGET -> $REPO_DIR/skills"
