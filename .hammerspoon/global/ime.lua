-- ============================================================
-- Key Code Constants (マジックナンバーの定義)
-- ============================================================
local KEY_CMD_LEFT  = 55  -- 左Commandキーのキーコード
local KEY_CMD_RIGHT = 54  -- 右Commandキーのキーコード
local KEY_EISU      = 102 -- JISキーボードの「英数」キー (PCキーボードの無変換相当)
local KEY_KANA      = 104 -- JISキーボードの「かな」キー (PCキーボードの変換相当)

-- ============================================================
-- Logic
-- ============================================================

-- ガベージコレクションによる監視停止を防ぐため、グローバル変数に保持
cmd_swapper         = nil

-- Commandキーが「単独で」押されたかを判定するフラグ
local prevCmd       = false

local function keyEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()

    -- ターゲットは左右のCommandキーのみ
    if c == KEY_CMD_LEFT or c == KEY_CMD_RIGHT then
        -- 修飾キーの状態が変化した（押した/離した）タイミング
        if event:getType() == hs.eventtap.event.types.flagsChanged then
            if f['cmd'] then
                -- 1. Commandキーが「押された」
                prevCmd = true
            elseif prevCmd then
                -- 2. Commandキーが「離された」かつ「直前まで押されていた(単独押し)」
                --    (他のキーが混ざっていると prevCmd は false になっている)

                if c == KEY_CMD_LEFT then
                    -- 左Commandを離した瞬間 -> 英数キー(102)を送信
                    hs.eventtap.keyStroke({}, KEY_EISU)
                elseif c == KEY_CMD_RIGHT then
                    -- 右Commandを離した瞬間 -> かなキー(104)を送信
                    hs.eventtap.keyStroke({}, KEY_KANA)
                end

                -- 処理完了につきリセット
                prevCmd = false
            end
        end
    else
        -- Command以外のキー（例: 'C', 'V'など）が押された場合
        -- これは "Cmd + C" などのショートカット操作であるため、単独押しフラグを折る
        if event:getType() == hs.eventtap.event.types.keyDown then
            prevCmd = false
        end
    end

    -- イベントをブロックせず、システムや他のアプリにスルーさせる
    return false
end

-- イベントタッパーの作成
-- flagsChanged: Commandなどの修飾キー用
-- keyDown:     その他のキー入力検知用（コンビネーション判定のため）
cmd_swapper = hs.eventtap.new(
    { hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown },
    keyEvent
)

-- 監視開始
cmd_swapper:start()
