
export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:/usr/local/bin:/usr/local/sbin:$PATH
eval "$(rbenv init - zsh)"
export GOPATH=~/.go

# for capistrano
echo -n "ssh-agent: "
if [ -e ~/.ssh-agent-info ]; then
    source ~/.ssh-agent-info
fi

ssh-add -l >&/dev/null
if [ $? = 2 ] ; then
    echo -n "ssh-agent: restart...."
    ssh-agent >~/.ssh-agent-info
    source ~/.ssh-agent-info
fi
if ssh-add -l >&/dev/null ; then
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
fi

## for nvm
if [[ -s ~/.nvm/nvm.sh ]]; then
  source ~/.nvm/nvm.sh

  if which nvm >/dev/null 2>&1 ;then
    _nodejs_use_version="v0.10.12"
    if nvm ls | grep -F -e "${_nodejs_use_version}" >/dev/null 2>&1 ;then
      nvm use "${_nodejs_use_version}" >/dev/null
      export NODE_PATH=${NVM_PATH}_modules${NODE_PATH:+:}${NODE_PATH}
      export PATH=/usr/local/bin:~/bin:$NPM_PATH:$NODE_PATH:$PATH
    fi
    unset _nodejs_use_version
  fi
fi


## for zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'


# 文字コード
export LANG=ja_JP.UTF-8

# プロンプト
autoload colors
colors

autoload -Uz vcs_info
autoload -U compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '%{${fg[red]}%}(%s %b%{${fg[cyan]}%}%c%u%{${fg[red]}%}) %{$reset_color%}'

setopt prompt_subst
precmd () {
  LANG=en_US.UTF-8 vcs_info
  if [ -z "${SSH_CONNECTION}" ]; then
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
[%n]$ "
  else
    PROMPT="
 %{${fg[yellow]}%}%~%{${reset_color}%} ${vcs_info_msg_0_}
%{${fg[green]}%}[%n@%m]$%{${reset_color}%} "
  fi
}

PROMPT2='[%n]> ' 

# 補完
[ -d ~/.zsh_fn ] && fpath=($HOME/.zsh_fn $fpath)
autoload -U compinit
compinit -u

# 履歴
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

# エディタ
export EDITOR=vim

# キーバインド
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 
bindkey '^R' history-incremental-pattern-search-backward

# ビープ音ならなさない
setopt nobeep

# cd
setopt auto_cd
setopt auto_pushd 
setopt pushd_ignore_dups

# 改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

# lsと補間にでる一覧の色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# デフォルトパーミッションの設定
umask 022

# alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GFa"
  ;;
linux*)
  alias ls="ls -Fa --color"
  ;;
esac

alias ll='ls -l'

# 環境ごとの設定読み込む
[ -f ~/.zshrc_env ] && source ~/.zshrc_env

# 個別設定を読み込む
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# gitで差分ファイルを抽出
function git_diff_archive() {
  local diff=""
  local h="HEAD"
  if [ $# -eq 1 ]; then
    if expr "$1" : '[0-9]*' > /dev/null ; then
      diff="HEAD HEAD~${1}"
    else
      diff="HEAD ${1}"
    fi
  elif [ $# -eq 2 ]; then
    diff="${1} ${2}"
    h=$1
  fi
  if [ "$diff" != "" ]; diff="git diff --name-only ${diff}"
  git archive --format=zip --prefix=root/ $h `eval $diff` -o archive.zip
}

# git hubコマンド
eval "$(hub alias -s)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH="/Users/fni_nishiyama/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/Users/fni_nishiyama/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/fni_nishiyama/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/fni_nishiyama/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/fni_nishiyama/perl5"; export PERL_MM_OPT;


### boot2 docker 環境変数設定
#if [ "`boot2docker status`" = "running" ]; then
  #$(boot2docker shellinit)
#fi


