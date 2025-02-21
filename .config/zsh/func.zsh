# ほかの formula に依存していない formula を一覧化する
# https://yulii.github.io/brew-cleanup-installed-formulae-20200509.html
function brew-deps() {
    brew list --formula | xargs -P$(expr $(sysctl -n hw.ncpu) - 1) -I{} sh -c 'brew uses --installed {} | wc -l | xargs printf "%20s is used by %2d formulae.\n" {}'
}

# fzfで実装する便利関数
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e#fzf%E3%81%A7%E5%AE%9F%E8%A3%85%E3%81%99%E3%82%8B%E4%BE%BF%E5%88%A9%E9%96%A2%E6%95%B0
## fbr - checkout git branch
function fbr() {
    local branches branch
    branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}
## fbrm - checkout git branch (including remote branches)
function fbrm() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
            fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
## fshow - git commit browser
function fshow() {
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
function ytm() {
    url=$1
    id=$(yt-dlp -F "${url}" | grep "audio only" | grep -v "webm" | tail -n 1 | awk '{print $1}')

    if [[ "${id}" =~ ^[0-9]+$ ]]; then
        yt-dlp -f "${id}" "${url}"
    else
        echo "IDが取得できませんでした。"
    fi
}

# mkdirが成功したらcdを実行
function mkcd() {
    if [[ -d $1 ]]; then
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}
