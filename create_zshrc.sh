#!/bin/bash  
  
ZSHRC_OUT="$HOME/.zshrc"  
  
cat << 'EOF' > "$ZSHRC_OUT"  
# User environment setup (generated)  
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
  
echo "# End of generated .zshrc" >> "$ZSHRC_OUT"  
  
echo ".zshrc generated at $ZSHRC_OUT"  