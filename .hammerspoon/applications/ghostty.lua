local appName = "Ghostty"

hs.hotkey.bind({ "command", "shift" }, "return", function()
    local frontApp = hs.application.frontmostApplication()

    if frontApp and frontApp:name() == appName then
        frontApp:hide()
    else
        hs.application.launchOrFocus(appName)
    end
end)
