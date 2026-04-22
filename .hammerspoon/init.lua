require("hs.ipc")

require("global/alert")
require("global/ime")

require("applications/terminal")
require("applications/brew")
require("applications/hammerspoon")

hs.notify.new({ title = "Hammerspoon", informativeText = "🔄 Configuration reloaded" }):send()
