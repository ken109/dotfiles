# 事前に

Ubuntuの場合
```
sudo apt install make git
```

# インストール

```
bash -c "$(curl -L https://raw.githubusercontent.com/ken109/dotfiles/master/etc/install.sh)"
```

# インストール後
## Mac、 Ubuntu共通
```
# zshの場合のみ
# 以下で表示されるディレクトリのパーミッションを全て755に変更する
compaudit

# fishの場合のみ
fisher
```
### NeoVim
初めてvimを開いた時
```
:PlugInstall
```

## Macのみ
```
# fishの場合のみ
source (conda info --root)/etc/fish/conf.d/conda.fish
```
