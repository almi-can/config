#一回更新したよ
# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

#補完機能を使用する
autoload -U compinit
compinit
#zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*:default' menu select true
#zstyle ':completion:*:default' menu select=1

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

alias emacs='emacs -nw'
alias ..='cd ..'
alias t2p="tex2pdf"

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep  

autoload -Uz colors
colors
#プロンプト設定
PROMPT="%F{red}[%n@%m]:%f"
RPROMPT="%F{blue}[%~]%f"

#./ で実行
alias -s "py"="python3"
