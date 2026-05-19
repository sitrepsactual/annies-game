#!/usr/bin/env bash
# Annie's Game — Claude Code status line
# Kid-friendly, Minecraft-magical-girl vibes

input=$(cat)

# Derive project root from this script's location so it works on any clone
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
branch=$(git -C "$PROJECT_DIR" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main")
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# ANSI truecolor helpers
RESET="\033[0m"
BOLD="\033[1m"

# Hot pink  (r=255 g=20 b=147)
PINK="\033[38;2;255;20;147m"
# Sunshine yellow  (r=255 g=230 b=0)
YELLOW="\033[38;2;255;230;0m"
# Sky blue  (r=30 g=200 b=255)
BLUE="\033[38;2;30;200;255m"
# Soft lavender  (r=210 g=160 b=255)
LAVENDER="\033[38;2;210;160;255m"
# Mint green  (r=100 g=255 b=180)
MINT="\033[38;2;100;255;180m"

# Build context-remaining badge only when we have data
ctx_badge=""
if [ -n "$remaining" ]; then
  ctx_int=$(printf "%.0f" "$remaining")
  ctx_badge=" ${LAVENDER}${BOLD}[${ctx_int}% left]${RESET}"
fi

printf '%b' "${PINK}${BOLD}🌈✨ ANNIE'S CHAT ✨🌈${RESET}"
printf '%b' "  ${YELLOW}${BOLD}🦄 ${model}${RESET}"
printf '%b' "  ${BLUE}${BOLD}🌸 branch: ${branch}${RESET}"
printf '%b' "${ctx_badge}"
printf '%b' "  ${MINT}${BOLD}🏰⛏️ annies-game 🎮💖${RESET}"
printf '\n'
