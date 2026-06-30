#!/usr/bin/env bash
set -euo pipefail

SKILL_NAME="paper-reading"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILL_SRC="$ROOT_DIR/$SKILL_NAME"

INSTALL_CODEX=0
INSTALL_CLAUDE=0
USE_LINK=0
PROJECT_SCOPE=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Install the paper-reading skill for Codex and/or Claude Code.

Usage:
  scripts/install.sh [options]

Options:
  --codex        Install only for Codex.
  --claude       Install only for Claude Code.
  --both         Install for both Codex and Claude Code. This is the default.
  --copy         Copy the skill directory. This is the default.
  --link         Symlink the skill directory instead of copying it.
  --project      Install into project-local skill directories under this repo.
  --dry-run      Print actions without changing files.
  -h, --help     Show this help.

Environment overrides:
  CODEX_SKILLS_DIR     Codex user skill directory. Default: $HOME/.agents/skills
  CLAUDE_SKILLS_DIR    Claude Code user skill directory. Default: $HOME/.claude/skills

Examples:
  scripts/install.sh
  scripts/install.sh --codex --link
  scripts/install.sh --project --link
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex)
      INSTALL_CODEX=1
      ;;
    --claude)
      INSTALL_CLAUDE=1
      ;;
    --both)
      INSTALL_CODEX=1
      INSTALL_CLAUDE=1
      ;;
    --copy)
      USE_LINK=0
      ;;
    --link)
      USE_LINK=1
      ;;
    --project)
      PROJECT_SCOPE=1
      ;;
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [[ $INSTALL_CODEX -eq 0 && $INSTALL_CLAUDE -eq 0 ]]; then
  INSTALL_CODEX=1
  INSTALL_CLAUDE=1
fi

if [[ ! -f "$SKILL_SRC/SKILL.md" ]]; then
  echo "Missing skill source: $SKILL_SRC/SKILL.md" >&2
  exit 1
fi

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    printf '+'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

backup_existing() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Existing target found: $target"
    echo "Backing it up to: $backup"
    run mv "$target" "$backup"
  fi
}

install_one() {
  local label="$1"
  local base_dir="$2"
  local target="$base_dir/$SKILL_NAME"

  echo "Installing for $label: $target"
  run mkdir -p "$base_dir"
  backup_existing "$target"

  if [[ $USE_LINK -eq 1 ]]; then
    run ln -s "$SKILL_SRC" "$target"
  elif command -v rsync >/dev/null 2>&1; then
    run rsync -a --delete --exclude '.DS_Store' "$SKILL_SRC/" "$target/"
  else
    run mkdir -p "$target"
    run cp -R "$SKILL_SRC/." "$target/"
  fi
}

if [[ $PROJECT_SCOPE -eq 1 ]]; then
  CODEX_DIR="$ROOT_DIR/.codex/skills"
  CLAUDE_DIR="$ROOT_DIR/.claude/skills"
else
  CODEX_DIR="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"
  CLAUDE_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
fi

if [[ $INSTALL_CODEX -eq 1 ]]; then
  install_one "Codex" "$CODEX_DIR"
fi

if [[ $INSTALL_CLAUDE -eq 1 ]]; then
  install_one "Claude Code" "$CLAUDE_DIR"
fi

cat <<EOF

Done.

Try:
  Codex:       \$paper-reading 帮我精读这篇论文: <paper>
  Claude Code: /paper-reading 帮我精读这篇论文: <paper>
EOF
