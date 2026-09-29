# ~/.zshrc — shared, portable config (tracked in dotfiles repo)
#
# Anything machine-specific (paths that only exist on one box, work-only
# env vars, installer-appended lines) goes in ~/.zshrc.local, which is NOT
# tracked. See zsh/.zshrc.local.example for a template.

typeset -U path fpath   # auto-dedupe

### Completion search path (must be set before compinit / oh-my-zsh) ###
for _dir in "$HOME/.zsh/completions" "$HOME/.docker/completions"; do
  [[ -d "$_dir" ]] && fpath=("$_dir" $fpath)
done
unset _dir

### Oh My Zsh ###
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder   # remind, don't auto-update
plugins=(git)

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"        # runs compinit for us
else
  autoload -Uz compinit && compinit
fi

### PATH ###
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

### Tools ###
# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# deno
[[ -s "$HOME/.deno/env" ]] && source "$HOME/.deno/env"

# zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

### Aliases ###
alias t="tmux"
alias got="git"
alias gut="git"
alias lg="lazygit"

### Machine-specific overrides (not in version control) ###
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/simon/.antigravity-ide/antigravity-ide/bin:$PATH"

# Unity CLI
. "/Users/simon/.unity/env"
