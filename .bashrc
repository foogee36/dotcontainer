# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# 重複する行や先頭にスペースがある行を履歴に保存しないようにする
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# 履歴ファイルに追記し、上書きしないようにする                                                                             
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# 最大で1000個のコマンド履歴をメモリ中に保持する
HISTSIZE=1000
# 最大で2000個までの履歴をファイルに保存する
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# 各コマンドの実行後にウィンドウサイズを確認し、必要であれば
# LINESとCOLUMNSの値を更新する
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# もし設定されていれば、パス名の展開コンテキストでのパターン "**" は
# すべてのファイルとゼロまたはそれ以上のディレクトリおよびサブディレクトリにマッチする。
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
# less を非テキストの入力ファイルに対しても使いやすくする（lesspipe(1)を参照）
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# 作業しているchroot（chroot環境）を識別する変数を設定する
# プロンプトで使用される
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then 
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# 見栄えの良いプロンプトを設定する（色が使える場合のみ、色は使用される）
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# ターミナルがカラー表示に対応している場合に、カラーでのプロンプトを有効にする
# ユーザーに気を取られないようにデフォルトでは無効になっている
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        # カラーサポートがある場合、それがEcma-48（ISO/IEC-6429）に準拠していると仮定する
        # （このサポートがないことは非常にまれであり、そのような場合はsetafではなくsetfをサポートする傾向があります）
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # カラープロンプトの設定
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    # カラープロンプトが無効の場合の設定
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# もしxtermであれば、タイトルを"user@host:dir"に設定する
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
# ls コマンドに色のサポートを有効にし、便利なエイリアスも追加する
if [ -x /usr/bin/dircolors ]; then
    # ~/.dircolors ファイルが存在すればその内容を評価し、なければデフォルト設定を評価する
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# いくつかの便利な ls コマンドのエイリアスを追加
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
# "alert" エイリアスを追加し、長時間かかるコマンドの後に使用できるようにする
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]
\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "${XDG_CONFIG_HOME}/bash/conf.d/alias" ]; then
    . "${XDG_CONFIG_HOME}/bash/conf.d/alias"
fi

if [ -f "${XDG_CONFIG_HOME}/bash/conf.d/prompt" ]; then
    . "${XDG_CONFIG_HOME}/bash/conf.d/prompt"
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# rtx
if [ -f ~/.local/bin/rtx ]; then
  eval "$(rtx activate bash)"
fi
