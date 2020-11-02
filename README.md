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
## 共通
```
# 以下で表示されるディレクトリのパーミッションを全て755に変更する
compaudit

# fishの場合のみ
fisher
```

## Mac
```
# fishの場合のみ
source (conda info --root)/etc/fish/conf.d/conda.fish
```
