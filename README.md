# 事前に

Ubuntuの場合

```
sudo apt install make git
```

# インストール

```
bash -c "$(curl -L https://raw.githubusercontent.com/ken109/dotfiles/master/bin/install.sh)"
```

# インストール後

## Mac、 Ubuntu共通

```
# 以下で表示されるディレクトリのパーミッションを全て755に変更する
compaudit
```

### NeoVim

初めてvimを開いた時

```
:PlugInstall
```
