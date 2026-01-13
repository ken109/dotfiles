local function reloadConfig(files)
    local doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end

    if doReload then
        hs.reload()
    end
end

-- Resolve the actual directory if init.lua is a symlink
local watchPath = hs.configdir
local initFile = watchPath .. "/init.lua"
local attrs = hs.fs.symlinkAttributes(initFile)

if attrs and attrs.target then
    local targetDir = attrs.target:match("(.*/)")
    if targetDir then
        watchPath = targetDir:sub(1, -2)
    end
end

watcher = hs.pathwatcher.new(watchPath, reloadConfig)
watcher:start()
