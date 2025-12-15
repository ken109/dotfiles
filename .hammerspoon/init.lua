local appName = "Alacritty"

hs.hotkey.bind({"command", "shift"}, "return", function()
  local frontApp = hs.application.frontmostApplication()

  if frontApp and frontApp:name() == appName then
    frontApp:hide()
  else
    hs.application.launchOrFocus(appName)
  end
end)

local spacesWatcher = hs.spaces.watcher.new(function()
  hs.timer.doAfter(0, function()
    local app = hs.application.get(appName)

    if app and not app:isHidden() then
      app:activate()
    end
  end)
end)

spacesWatcher:start()
