# .zshrc はzshを起動したときに読み込まれるが、シェルスクリプトを実行したときは読み込まれない。
#   例：エイリアスやキーバインドの設定、zshのオプションなど対話的に使用するための設定を書く。
# （※）対話的に使用するための設定を.zshenvに書いてしまうと
#      zshをシェルスクリプトとして実行したときにデフォルト設定と異なっているため
#      誤動作を引き起こす可能性がある。zshの設定は基本的には.zshrcに記述するものと思えばよい
###################################################################

eval "$(sheldon source)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

if [[ "$TERM_PROGRAM" == "tmux" ]]; then
    [[ "$TMUX_PANE" == "%0" ]] && fastfetch
else
    fastfetch
fi
