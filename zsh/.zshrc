export PATH="/opt/homebrew/bin:$PATH" 
eval "$(oh-my-posh init zsh --config /Users/not/Developments/Dotfiles-Mini/zsh/themes/night-owl.omp.json)"

export ZSH_CUSTOM=/Users/not/Developments/Dotfiles-Mini/zsh
ZSH_THEME="robbyrussell"

# Configuración del historial
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS  # No duplicados en historial
setopt HIST_FIND_NO_DUPS     # No duplicados al buscar
setopt INC_APPEND_HISTORY    # Agregar comandos al historial inmediatamente

# Mejoras de autocompletado
fpath=($ZSH_CUSTOM/zsh-completions/src $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select  # Menú interactivo
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' use-cache on  # Activar caché de completions
zstyle ':completion:*' cache-path ~/.zsh/cache  # Ruta del caché


# Alias Propios
alias ls="lsd"
alias la="lsd -la"
alias vim="nvim"
alias to="tmux attach -t"
alias tc="tmux new -s" #Crear nueva sesión
alias tls="tmux ls"
alias tconf='tmux source-file ~/.tmux.conf || echo "No tmux session activa"'
alias studio="npx prisma studio"

# Comandos personalizados
alias ll="eza -lah --icons --git --group-directories-first"
alias ls="eza --icons --git"
alias lt="eza --tree --level=2 --icons"
alias lta="eza --tree --level=3 --icons --git-ignore"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias kill="kill -9"
alias port="sudo lsof -i -P | grep"
# Git mejorado
alias gco="git checkout"
alias gb="git branch"
alias gl="git log --oneline --graph --decorate"
alias grh="git reset --hard"
alias gst="git stash"
alias gstp="git stash pop"
alias ga="git add ."
alias gd="git diff"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
# NPM/Yarn
alias ni="npm install"
alias nid="npm install --save-dev"
alias nr="npm run"
alias dev="npm run dev"
alias build="npm run build"

# Utilidades del sistema
alias mkdir="mkdir -p"
alias c="clear"
alias h="history"
alias e="exit"
# Directorios frecuentes
alias projects="cd ~/Developments"
alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"
alias docs="cd ~/Documents"
alias cat="bat"
# Abrir archivos con Vim directamente
alias v="vim"
# JSON con colores y paginación
alias jqp="jq -C | less -R"
# Herramientas CLI mejoradas
alias find="fd"
alias rg="rg --smart-case --hidden"
alias lzd="lazydocker"

# Plugins
source $ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_CUSTOM/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH_CUSTOM/zsh-you-should-use/you-should-use.plugin.zsh
source $ZSH_CUSTOM/zsh-autopair/autopair.zsh
source $ZSH_CUSTOM/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $ZSH_CUSTOM/zsh-abbr/zsh-abbr.zsh

# Configuración de autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # Color gris para sugerencias
ZSH_AUTOSUGGEST_STRATEGY=(history completion)  # Sugiere desde historial Y completions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20  # Limita el tamaño del buffer

# Bindkeys para history-substring-search
bindkey "^[[OA" history-substring-search-up   # Flecha option + arriba ⬆️
bindkey "^[[OB" history-substring-search-down # Flecha option + abajo ⬇️

# WezTerm/Ghostty suelen enviar ALT+Up/Down como CSI 1;3 A/B
bindkey '\e[1;3A' history-substring-search-up
bindkey '\e[1;3B' history-substring-search-down

# Por si envía SS3 con ALT (algunas configuraciones):
bindkey '^[\eOA' history-substring-search-up
bindkey '^[\eOB' history-substring-search-down

# Fancy Ctrl+Z - Toggle entre fg y clear
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Globalias - Aliases globales que se expanden
alias -g G='| grep'
alias -g L='| less'
alias -g J='| jq'
alias -g NE='2> /dev/null'
alias -g H='| head'
alias -g T='| tail'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
eval "$(fzf --zsh)"
# source ~/fzf-git.sh/fzf-git.sh  # Comentado - el archivo no existe
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#7cbba3,fg+:#d0d0d0,bg:-1,bg+:#090316
  --color=hl:#248eff,hl+:#53ff7e,info:#58ff69,marker:#ffffff
  --color=prompt:#00ff22,spinner:#00ff04,pointer:#00ff6f,header:#87afaf
  --color=gutter:#0d1320,border:#09aba8,separator:#0d1320,label:#aeaeae
  --color=query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1"
  --margin="1" --prompt="👨🏻‍💻" --marker="" --pointer="🚀"
  --separator="" --scrollbar=""'

export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
# --- Configuración de NVM (Node Version Manager) ---
export NVM_DIR="$HOME/.nvm"
# Las siguientes líneas cargan NVM. Asegúrate de que la ruta /opt/homebrew/ sea correcta para tu instalación de Homebrew.
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"      # Carga nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # Carga el autocompletado
# ---
# eval "$(zoxide init zsh)"  # Comentado - reemplazado por z.lua (más rápido)
eval "$(lua /opt/homebrew/share/z.lua/z.lua --init zsh)"

# Atuin - Historial sincronizado con búsqueda mejorada
eval "$(atuin init zsh)"

# Este plugin debe cargarse al final (3x más rápido que zsh-syntax-highlighting)
source $ZSH_CUSTOM/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
