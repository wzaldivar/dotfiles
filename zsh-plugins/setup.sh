#! /bin/sh
#
# zsh-autosuggestions and zsh-syntax-highlighting, preferring a copy the system
# package manager already maintains. Homebrew packages both; MacPorts packages
# neither, which is why the direct clone exists as a fallback.

cd "$(dirname "$0")" || exit 1

# Order matters: zsh-syntax-highlighting has to be sourced last.
PLUGINS="zsh-autosuggestions zsh-syntax-highlighting"

# share/ dirs to probe, in preference order: homebrew (arm), homebrew (intel)
# and macports both under /opt, then the usual Linux locations.
PREFIXES="/opt/homebrew/share /opt/local/share /usr/local/share /usr/share"

# Print the file to source for a plugin, cloning only if nothing packages it.
resolve() {
  for prefix in $PREFIXES; do
    if [ -r "$prefix/$1/$1.zsh" ]; then
      echo "$prefix/$1/$1.zsh"
      return 0
    fi
  done

  mkdir -p "$HOME/.zsh"
  if [ ! -d "$HOME/.zsh/$1" ]; then
    git clone "https://github.com/zsh-users/$1.git" "$HOME/.zsh/$1" >&2 || return 1
  fi
  echo "\$HOME/.zsh/$1/$1.zsh"
}

for plugin in $PLUGINS; do
  # Check this before resolving: otherwise a machine that already sources the
  # plugin from elsewhere gets a clone it will never use.
  # Match however the existing line is written: quoted, unquoted, any prefix.
  if grep -q "^source .*$plugin" "$HOME/.zshrc" 2>/dev/null; then
    echo "$plugin: already sourced, left alone"
    continue
  fi

  file=$(resolve "$plugin") || continue

  echo "source \"$file\"" >>"$HOME/.zshrc"
  echo "$plugin: $file"
done
