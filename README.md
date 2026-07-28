# official dotfile management repo

The script is split in two. One for installation and one for symlinks.

## installation

```sh
./install.sh     # tools (bun, tpm, ...)
brew bundle      # Brewfile
```

## symlinks

```sh
./setup.sh       # stow zsh/ -> ~ and .config/ -> ~/.config
```

## shared vs. machine-specific zsh config

| file | tracked? | purpose |
| --- | --- | --- |
| `zsh/.zshrc` | yes | portable config: oh-my-zsh, aliases, guarded tool init |
| `zsh/.zprofile` | yes | login shell; detects Homebrew prefix automatically |
| `~/.zshrc.local` | **no** | anything specific to one machine |
| `~/.zprofile.local` | **no** | login-shell equivalent |
| `templates/zshrc.local.example` | yes | template copied to `~/.zshrc.local` by `setup.sh` |

Rules of thumb:

- Never hardcode `/Users/<name>` — use `$HOME`.
- Guard optional tools so a missing binary doesn't break startup:
  `(( $+commands[foo] )) && eval "$(foo init zsh)"`.
- When an installer appends junk to `~/.zshrc`, move those lines into
  `~/.zshrc.local` and commit nothing.
