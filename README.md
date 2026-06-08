# config

Personal local dev environment configuration — terminal, shell, editors, prompt, container runtime, and a few CLI tools. Built for macOS + zsh; most modules also work on Linux.

## Modules

| Directory    | What it configures                                                      |
| ------------ | ----------------------------------------------------------------------- |
| `bitwarden/` | Bitwarden SSH agent socket wiring                                       |
| `colima/`    | Colima / Docker socket env vars                                         |
| `ghostty/`   | Ghostty terminal (theme, font, padding)                                 |
| `git/`       | Per-gitdir personal identity via `includeIf`                            |
| `ideavim/`   | IdeaVim — bindings, which-key prefixes, camelCase motion toggle         |
| `lsd/`       | `lsd` colors and config                                                 |
| `nvim/`      | Neovim colorscheme plugin                                               |
| `ollama/`    | Ollama host env var                                                     |
| `remote/`    | SSH host aliases                                                        |
| `shell/`     | Zsh aliases + helper functions (`repo`, `mkcd`, `groot`, `init_python`) |
| `starship/`  | Starship prompt (Catppuccin Mocha + custom Docker / git-sync modules)   |
| `tmux/`      | Tmux + Catppuccin                                                       |

## Install

Each module is independent. From inside the module directory, run its `setup.sh`:

```sh
cd shell && ./setup.sh
cd starship && ./setup.sh
# ...etc
```

Most setup scripts:

1. Symlink the tracked config file into `$HOME` (or `~/.config/...`).
2. Append a `source` line to `~/.zshrc` where applicable.
3. If a `.local` override file exists in the module directory, symlink it too.

Only install the modules you want — there is no top-level installer.

## Machine-specific overrides (`.local` files)

A few modules ship with a generic tracked file plus a gitignored `.local` sibling for values that shouldn't be public (work email, internal hostnames, SSH targets, etc.):

| Tracked (committed)            | Override (gitignored)                |
| ------------------------------ | ------------------------------------ |
| `git/.gitconfig.personal`      | `git/.gitconfig.personal.local`      |
| `remote/.remote.sh`            | `remote/.remote.local.sh`            |
| `ollama/.ollama.sh`            | `ollama/.ollama.local.sh`            |

The tracked file conditionally sources/includes the `.local` file when present, so the public version stays clean and your machine-specific values stay local. The `.gitignore` covers `*.local`, `*.local.sh`, `*.env`, `*.secret`, `id_*`, `*.pem`, `*.key` to prevent accidental commits.

### Examples

**`git/.gitconfig.personal.local`** — used by the global git `includeIf` set up via `setup_git_personal <path>`:

```ini
[user]
	email = you@example.com
	name = Your Name
```

**`remote/.remote.local.sh`** — SSH aliases to your hosts:

```sh
alias prod='ssh user@prod.example.com'
```

**`ollama/.ollama.local.sh`** — point Ollama at a remote inference host:

```sh
export OLLAMA_HOST="host.example.com"
```

## Per-gitdir identity

`git/.gitconfig.setup.sh` exposes two zsh functions for scoping a personal identity to a directory tree:

- `setup_git_personal <path>` — append an `[includeIf "gitdir:<path>"]` block to `~/.gitconfig` that pulls in `~/.gitconfig.personal`.
- `setup_git_personal_here` — same, for the current directory.

The included `~/.gitconfig.personal` (symlinked from this repo) in turn `[include]`s `~/.gitconfig.personal.local`, where the actual `user.email` / `user.name` live.

## Shell helpers (selected)

Run `help_aliases` after sourcing `shell/.aliases.sh` for the full list. Highlights:

- `repo <name>` — create directory, `cd`, `git init`
- `mkcd <name>` — create directory and `cd`
- `groot` — `cd` to the current git repo root
- `initial_git` — `git init` + stage all + commit `initial` (with confirmation)
- `init_python <version> [venv_path] [file]` — generate a `mise.toml` with a Python toolchain + venv

## Dependencies

Not all modules are useful without their target tool installed:

- [ghostty](https://ghostty.org/) · [starship](https://starship.rs/) · [lsd](https://github.com/lsd-rs/lsd) · [neovim](https://neovim.io/) (LazyVim) · [tmux](https://github.com/tmux/tmux) · [colima](https://github.com/abiosoft/colima) · [mise](https://mise.jdx.dev/) · [ollama](https://ollama.com/) · [Bitwarden Desktop](https://bitwarden.com/help/ssh-agent/)
