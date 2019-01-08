local hyper = {"cmd", "ctrl", "alt", "shift"}
local switcher = hs.window.switcher.new()

-- Disable animations
hs.window.animationDuration = 0

-- Switch monitors (if there are any)
hs.hotkey.bind(hyper, "m", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()

	win:moveToScreen(screen:next())
end)

-- Maximize current window
hs.hotkey.bind(hyper, "f", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
end)

-- Put current window to left half of screen
hs.hotkey.bind(hyper, "d", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- Put current screen to right half of screen
hs.hotkey.bind(hyper, "g", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 2)
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
end)

-- Autoreload config
function reloadConfig(files)
	hs.reload()
	hs.alert.show("Config reloaded")
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
