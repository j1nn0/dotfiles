# ほかの formula に依存していない formula を一覧化する
# https://yulii.github.io/brew-cleanup-installed-formulae-20200509.html
brew-deps() {
    brew list --formula | xargs -P$(expr $(sysctl -n hw.ncpu) - 1) -I{} sh -c 'brew uses --installed {} | wc -l | xargs printf "%20s is used by %2d formulae.\n" {}'
}

# fzfで実装する便利関数
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e#fzf%E3%81%A7%E5%AE%9F%E8%A3%85%E3%81%99%E3%82%8B%E4%BE%BF%E5%88%A9%E9%96%A2%E6%95%B0
## fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

## fbrm - checkout git branch (including remote branches)
fbrm() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
            fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

## fshow - git commit browser
fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# YouTubeから高音質のオーディオファイルを抽出・ダウンロード
# https://github.com/yt-dlp/yt-dlp
ytm() {
    url=$1
    id=$(yt-dlp -F "${url}" | grep "audio only" | grep -v "webm" | tail -n 1 | awk '{print $1}')

    if [[ "${id}" =~ ^[0-9]+$ ]]; then
        yt-dlp -f "${id}" "${url}"
    else
        echo "IDが取得できませんでした。"
    fi
}

# mkdir と cd コマンド
mkcd() {
    mkdir -p $argv && cd $argv
}

# oh-my-opencode-slim multiplexer integration
omo() {
    # CMUX_BUNDLE_ID が設定されている場合は cmux コマンドを実行
    #if [[ -n "$CMUX_BUNDLE_ID" ]]; then
    #    echo 'cmux is running'
    #    cmux omo$argv
    #    return
    #fi

    local port
    port=$(jot -r 1 49152 65535)
    OPENCODE_PORT="$port" \
        opencode --port "$port" $argv
}

# devcontainer を起動・停止、コマンドを実行する関数
dev() {
    if [[ ! -f .devcontainer/devcontainer.json ]]; then
        echo "Error: .devcontainer/devcontainer.json not found in the current directory."
        return 1
    fi

    case "$1" in
    up)
        devcontainer up
        ;;
    build)
        devcontainer build
        ;;
    exec)
        shift
        devcontainer exec $argv
        ;;
    restart)
        (cd infra/docker/dev && make down)
        devcontainer up
        ;;
    *)
        (cd infra/docker/dev && make $argv)
        ;;
    esac
}
devx() {
    if [[ ! -f .devcontainer/devcontainer.json ]]; then
        echo "Error: .devcontainer/devcontainer.json not found in the current directory."
        return 1
    fi

    devcontainer exec $argv
}

# cdコマンドでGitリポジトリへ移動した際に、onefetchでリポジトリ情報を自動表示する
# https://github.com/o2sh/onefetch/wiki/getting-started#1-bash--zsh
# git repository greeter
last_repository=
check_directory_for_new_repository() {
    current_repository=$(git rev-parse --show-toplevel 2>/dev/null)

    if [ "$current_repository" ] &&
        [ "$current_repository" != "$last_repository" ]; then
        onefetch
    fi
    last_repository=$current_repository
}
cd() {
    builtin cd "$@" || return
    check_directory_for_new_repository
}

zi() {
    local dir
    dir=$(zoxide query -l | fzf) && z "$dir"
}

tmux() {
    # 引数がある場合はそのまま tmux コマンドを実行
    if [ $# -gt 0 ]; then
        command tmux "$@"
    else
        # https://github.com/tmux/tmux/wiki/Getting-Started#attaching-and-detaching
        command tmux new -As1
    fi
}

config() {
    edit=zed

    if [ "$1" = "opencode" ]; then
        $edit $XDG_CONFIG_HOME/opencode
    elif [ "$1" = "codex" ]; then
        $edit $HOME/.codex
    elif [ "$1" = "omp" ]; then
        $edit $HOME/.omp
    elif [ "$1" = "claude-code" ]; then
        $edit $HOME/.claude
    elif [ "$1" = "zsh" ]; then
        $edit $XDG_CONFIG_HOME/zsh
    else
        $edit $XDG_CONFIG_HOME/$argv
    fi
}
