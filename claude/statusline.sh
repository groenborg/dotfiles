#!/bin/sh
# Claude Code statusLine - based on Oh My Zsh robbyrussell theme

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd')

dir=$(basename "$cwd")


# Git info (skip optional locks to avoid contention)
branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
if [ -n "$branch" ]; then
  dirty=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" status --porcelain 2>/dev/null)
  if [ -n "$dirty" ]; then
    git_info=$(printf '\033[1;34mgit:(\033[0;31m%s\033[1;34m) \033[0;33m✗\033[0m' "$branch")
  else
    git_info=$(printf '\033[1;34mgit:(\033[0;31m%s\033[1;34m)\033[0m' "$branch")
  fi
else
  git_info=""
fi

# Model name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context window usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Arrow + directory + git
if [ -n "$git_info" ]; then
  printf '\033[1;32m➜\033[0m  \033[0;36m%s\033[0m %s' "$dir" "$git_info"
else
  printf '\033[1;32m➜\033[0m  \033[0;36m%s\033[0m' "$dir"
fi

# Model and context, appended after robbyrussell output
if [ -n "$model" ]; then
  if [ -n "$used_pct" ]; then
    printf ' \033[2m|\033[0m \033[2m%s\033[0m \033[2mctx:%s%%\033[0m' "$model" "$(printf '%.0f' "$used_pct")"
  else
    printf ' \033[2m|\033[0m \033[2m%s\033[0m' "$model"
  fi
fi
