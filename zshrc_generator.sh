#!/bin/bash

ZSHRC_OUT="$HOME/.zshrc"
FORCE=0

for arg in "$@"; do
  case "$arg" in
    -y | --yes | -f | --force)
      FORCE=1;;
    *)
    echo "Usage: $0 [-y|--yes|-f|--force]"
    exit 1;;
  esac
done

# check if .zshrc exist
if [ -e "$ZSHRC_OUT" ]  && [ "$FORCE" -ne 1 ]; then
  echo "$ZSHRC_OUT already exist."
  read -p "Overwrite? [y/N]: " yn
  case "$yn" in
    [Yy]*)
      cp "$ZSHRC_OUT" "$ZSHRC_OUT".bkup
      echo "$ZSHRC_OUT copied to ${ZSHRC_OUT}.bkup";;
    *) echo "$0: Abort."; exit 1;;
  esac
fi

cat << 'EOF' > "$ZSHRC_OUT"
# This script is created by https://github.com/MasaYan24/create_zshrc
export PATH=~/bin:$PATH
setopt no_beep

# Editor
EOF

if command -v nvim >/dev/null 2>&1; then
  echo 'export VISUAL=nvim' >> "$ZSHRC_OUT"
  echo 'export EDITOR=nvim' >> "$ZSHRC_OUT"
else
  echo 'export VISUAL=vi' >> "$ZSHRC_OUT"
  echo 'export EDITOR=vi' >> "$ZSHRC_OUT"
fi

cat << 'EOF' >> "$ZSHRC_OUT"

# Keybind
bindkey "^l" forward-word
bindkey -e

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt hist_ignore_all_dups

# Completion
autoload -Uz compinit && compinit
EOF

if command -v brew >/dev/null 2>&1; then
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$ZSHRC_OUT"
fi
if command -v starship >/dev/null 2>&1; then
  echo 'eval "$(starship init zsh)"' >> "$ZSHRC_OUT"
fi
if [ -x "$HOME/.miniconda/bin/conda" ]; then
  echo 'eval "$($HOME/.miniconda/bin/conda shell.zsh hook)"' >> "$ZSHRC_OUT"
fi
if command -v direnv >/dev/null 2>&1; then
  echo 'eval "$(direnv hook zsh)"' >> "$ZSHRC_OUT"
fi
if command -v ssh-agent >/dev/null 2>&1; then
  echo 'eval "$(ssh-agent)" 1> /dev/null' >> "$ZSHRC_OUT"
fi
if [ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$ZSHRC_OUT"
fi

cat << 'EOF' >> "$ZSHRC_OUT"

# Aliases
EOF

if command -v nvim >/dev/null 2>&1; then
  echo "alias vi='nvim'" >> "$ZSHRC_OUT"
fi

if ls --color >/dev/null 2>&1; then
  echo "alias ls='ls --color'" >> "$ZSHRC_OUT"
elif ls -G >/dev/null 2>&1; then
  echo "alias ls='ls -G'" >> "$ZSHRC_OUT"
fi

if command -v xclip >/dev/null 2>&1; then
  echo "alias copyfile='xclip -selection clipboard <'" >> "$ZSHRC_OUT"
fi

echo "# End of generated .zshrc" >> "$ZSHRC_OUT"

echo ".zshrc generated at $ZSHRC_OUT"
