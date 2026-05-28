require("hs.ipc")

require("global/alert")
require("global/ime")

require("applications/alacritty")
require("applications/brew")
require("applications/hammerspoon")

hs.notify.new({ title = "Hammerspoon", informativeText = "🔄 Configuration reloaded" }):send()
