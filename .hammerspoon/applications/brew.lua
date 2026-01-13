-- ============================================================
-- 定期実行: 毎時0分に brew upgrade
-- ============================================================

local brewPath = ""
if hs.fs.attributes("/opt/homebrew/bin/brew") then
    brewPath = "/opt/homebrew/bin/brew"
else
    brewPath = "/usr/local/bin/brew"
end

local function runBrewUpgrade()
    hs.notify.new({ title = "Hammerspoon", informativeText = "🍺 brew upgrade を開始しました..." }):send()

    local task = hs.task.new(brewPath, function(exitCode, stdOut, stdErr)
        local message = ""
        if exitCode == 0 then
            message = "✅ brew upgrade が完了しました！\n" .. stdOut
        else
            message = "⚠️ brew upgrade に失敗しました。\n" .. stdErr
        end

        hs.notify.new({ title = "Hammerspoon", informativeText = message }):send()

        print(message)
    end, { "upgrade" })

    task:start()
end

timer = hs.timer.doEvery(60, function()
    local date = os.date("*t")
    if date.min == 0 then
        runBrewUpgrade()
    end
end)
