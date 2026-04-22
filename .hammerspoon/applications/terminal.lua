local terminals = { "Ghostty", "Alacritty" }
local preferredIndex = 1

local function preferred()
    return terminals[preferredIndex]
end

-- Cmd+Shift+Return: 優先ターミナルをトグル（表示/非表示）
hs.hotkey.bind({ "command", "shift" }, "return", function()
    local app = preferred()
    local frontApp = hs.application.frontmostApplication()

    if frontApp and frontApp:name() == app then
        frontApp:hide()
    else
        hs.application.launchOrFocus(app)
    end
end)

-- Cmd+Shift+T: GhosttyとAlacrittyを切り替え
hs.hotkey.bind({ "command", "shift" }, "t", function()
    preferredIndex = (preferredIndex % #terminals) + 1
    local app = preferred()
    hs.alert.show("Terminal: " .. app)
    hs.application.launchOrFocus(app)
end)
