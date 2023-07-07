# 事前に

Ubuntuの場合

```shell
$ sudo apt install make git
```

# インストール

```shell
$ bash -c "$(curl -L https://raw.githubusercontent.com/ken109/dotfiles/master/script/install.sh)"
```

# インストール後

## Mac、 Ubuntu共通

```shell
# 以下で表示されるディレクトリのパーミッションを全て755に変更する
$ compaudit
```

### NeoVim

初めてvimを開いた時

```
:PlugInstall
```

# アップデート

```shell
$ dotfiles-update
```

# ユーティリティ
```shell
# ghqでインストールしたレポジトリのパスに移動する
$ cdg
```
