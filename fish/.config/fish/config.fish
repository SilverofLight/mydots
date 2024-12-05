if status is-interactive
    # Commands to run in interactive sessions can go here
    # function fish_prompt
    #   echo -n '@'':'(pwd)\n'>'' '
    # end
  if test (xmodmap -pke | grep -c 'Control_L') -eq 1
      xmodmap $HOME/.Xmodmap
      echo "change keyboard layout successfully"
  end

  # ptyhon path
  set -gx PATH $HOME/.pyenv/bin $PATH
  
  # Initialize pyenv
  status --is-interactive; and pyenv init --path | source
  status --is-interactive; and pyenv init - | source
  status --is-interactive; and pyenv virtualenv-init - | source
  
  # Allow deprecated scikit-learn package installation
  set -gx SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL True

  function ra
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      set cwd (cat "$tmp")
      if test -n "$cwd" -a "$cwd" != "$PWD"
          builtin cd "$cwd"
      end
      rm -f "$tmp"
  end

  # 开启系统代理
  set -x http_proxy http://127.0.0.1:7890
  set -x https_proxy http://127.0.0.1:7890
  set -x no_proxy 127.0.0.1,localhost
  set -x HTTP_PROXY http://127.0.0.1:7890
  set -x HTTPS_PROXY http://127.0.0.1:7890
  set -x NO_PROXY 127.0.0.1,localhost
  
  # 关闭系统代理
  function proxy_off
      set -e http_proxy
      set -e https_proxy
      set -e no_proxy
      set -e HTTP_PROXY
      set -e HTTPS_PROXY
      set -e NO_PROXY
      echo -e "\033[31m[×] 已关闭代理\033[0m"
  end
  alias ls="exa --icons"
  alias ll="exa --icons -l"
  alias la="exa --icons -a"
  alias lla="exa --icons -la"
  alias v="nvim"
  alias wacom="~/.config/xsetwacom.sh"
  alias vh="nvim ~/history"
  alias wifils="nmcli device wifi list"
  alias wificnn="nmcli device wifi connect"
  alias hmm="h-m-m"
  alias gi="lazygit"
  alias setbg="feh --bg-fill"
  alias showip="nmcli device show | grep IP4 | awk 'NR==1 {print $2}'"
  alias c="cowsay"
  alias cs="cowsay 大傻逼"
  alias cn="cowsay 牛逼"
  alias vv="nvim ~/Study/TODOlist.md"
  alias t="tmux"
  alias ta="tmux attach"
  alias tn="tmux new -s"
  alias tt="tmux attach -t"
  alias en="~/.config/touchEtyma.sh"
  alias link="scrcpy"
  alias s="neofetch"
  alias dic="~/Documents/github/my_dict/dict"
  alias mp="mdpdf --style=$HOME/Documents/github/mdpdf/github.css"
  alias baidu="/usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U &"
  alias clash="/home/silver/Documents/github/clash-for-linux/start.sh"
  alias cnnp="nmcli device wifi connect DIRECT-5C-HP\ DeskJet\ 2700\ series"
  alias cnnw="nmcli device wifi connect WHUT-DORM"

  # 如果在使用 kitty, 则更改 ssh
  if test "$TERM" = "xterm-kitty"
    function ssh
        kitty +kitten ssh $argv
    end
  end

  function bg
      eval "$argv & disown"
  end

  set -gx EDITOR nvim
  set -gx fish_greeting ''

  # 设置 FZF 的配置
  set -gx FZF_DEFAULT_OPTS '--height 40% --reverse --preview "cat {}"'
  
  # 为 Fish shell 配置 FZF 的命令补全
  set -g __fzf_fish_path $HOME/.fzf/bin
  set -gx PATH $PATH $HOME/.fzf/bin
  
  # FZF 绑定命令到 Ctrl-T 和 Ctrl-R
  function fzf-file-widget
      commandline -i (fzf)
  end
  function fzf-history-widget
      commandline -i (history | fzf)
  end
  
  # 绑定快捷键
  function fish_user_key_bindings
      bind \ct fzf-file-widget  # Ctrl-T
      bind \cr fzf-history-widget  # Ctrl-R
  end
end
