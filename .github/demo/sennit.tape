# VHS のデモ定義。README の GIF はこのファイルから生成する。
# 手で録画しないので再現可能で、CI で再生成できる。
#   vhs .github/demo/sennit.tape

Output .github/demo/sennit.gif

# 実環境と同じプロンプト(zsh + starship)で見せる
Set Shell "zsh"

Set Theme { "name": "TokyoNight", "background": "#1a1b26", "foreground": "#c0caf5", "cursor": "#c0caf5", "selection": "#283457", "black": "#15161e", "red": "#f7768e", "green": "#9ece6a", "yellow": "#e0af68", "blue": "#7aa2f7", "magenta": "#bb9af7", "cyan": "#7dcfff", "white": "#a9b1d6", "brightBlack": "#414868", "brightRed": "#f7768e", "brightGreen": "#9ece6a", "brightYellow": "#e0af68", "brightBlue": "#7aa2f7", "brightMagenta": "#bb9af7", "brightCyan": "#7dcfff", "brightWhite": "#c0caf5" }
Set FontFamily "Hack Nerd Font Mono"
Set FontSize 18
Set Width 1100
Set Height 760
Set Padding 24
Set TypingSpeed 45ms

Hide
# zsh は既定で # をコメント扱いしないので有効化する。
# あわせて説明用に簡素なプロンプトにする(本来の 4 行プロンプトは
# デモの縦幅を食うため)。
Type "setopt interactive_comments; PROMPT='%F{111}❯%f '; cd ~/.dotfiles; clear" Enter
Show

Sleep 600ms
Type "# 設定が参照する依存が宣言されているか" Enter
Sleep 400ms
Type "sennit check" Enter
Sleep 2500ms

Type "# theme.toml から配色を生成する" Enter
Sleep 400ms
Type "sennit render" Enter
Sleep 2200ms

Type "# 宣言済みパッケージの過不足" Enter
Sleep 400ms
Type "sennit sync --dry-run" Enter
Sleep 2500ms

Type "# 配置状況" Enter
Sleep 400ms
Type "sennit list | tail -5" Enter
Sleep 3000ms
