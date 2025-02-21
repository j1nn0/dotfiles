# ほかの formula に依存していない formula を一覧化する
# https://yulii.github.io/brew-cleanup-installed-formulae-20200509.html
function brew-deps() {
    brew list --formula | xargs -P$(expr $(sysctl -n hw.ncpu) - 1) -I{} sh -c 'brew uses --installed {} | wc -l | xargs printf "%20s is used by %2d formulae.\n" {}'
}

# fbr - checkout git branch
fbr() {
    local branches branch
    branches=$(git branch -vv) &&
        branch=$(echo "$branches" | fzf +m) &&
        git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fbrm - checkout git branch (including remote branches)
fbrm() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
            fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
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
function ytm() {
    url=$1
    id=$(yt-dlp -F "${url}" | grep "audio only" | grep -v "webm" | tail -n 1 | awk '{print $1}')

    if [[ "${id}" =~ ^[0-9]+$ ]]; then
        yt-dlp -f "${id}" "${url}"
    else
        echo "IDが取得できませんでした。"
    fi
}

mkcd() {
    mkdir $argv && cd $argv
}

## show parents directory list
function pwp {
    local -i depth=0
    currentDir=$(pwd)
    echo -e "$fg_bold[red]*: $currentDir$reset"

    while :; do
        depth+=1
        currentDir=$(dirname $currentDir)
        if [ $(($depth % 2)) -eq 1 ]; then
            echo -e "$fg[green]$depth: $currentDir$reset"
        else
            echo -e "$fg[yellow]$depth: $currentDir$reset"
        fi
        [[ $currentDir != "/" ]] || break
    done
}

## interactive directory selection using pwp
function cdp() {
    local parents=()
    while IFS= read -r line; do
        parents+=("$line")
    done < <(pwp | awk -F': ' '/[0-9]+:/ {print $2}')

    local selected=$(printf "%s\n" "${parents[@]}" | fzf --reverse --prompt="Select directory > ")

    if [[ -n "$selected" ]]; then
        cd "$selected" || echo "Failed to change directory to $selected"
    fi
}
