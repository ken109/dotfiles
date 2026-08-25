# =======================================================
# theme — tokyonight (night)
# 単一ソース: theme.toml (sennit render が生成する)
# =======================================================

export BAT_THEME="tokyonight_night"

export FZF_DEFAULT_OPTS="\
--color=bg+:#283457,bg:#16161e,border:#27a1b9,fg:#c0caf5 \
--color=gutter:#16161e,header:#ff9e64,hl+:#2ac3de,hl:#2ac3de \
--color=info:#545c7e,marker:#ff007c,pointer:#ff007c \
--color=prompt:#2ac3de,query:#c0caf5:regular,scrollbar:#27a1b9 \
--color=separator:#ff9e64,spinner:#ff007c"

# eza: ディレクトリ=blue, シンボリックリンク=cyan, 実行可能=green
export EZA_COLORS="di=38;2;122;162;247:ln=38;2;125;207;255:ex=38;2;158;206;106:ur=38;2;224;175;104:uw=38;2;247;118;142:ux=38;2;158;206;106"
