local hyper = {"cmd", "ctrl", "alt", "shift"}
local padding = 10

-- Disable animations
hs.window.animationDuration = 0

-- Toggle padding sizes
hs.hotkey.bind(hyper, "p", function()
	if padding == 10 then
		padding = 0
	else
		padding = 10
	end

	hs.alert.show("Padding set to " .. padding)
end)

-- Maximize current window
hs.hotkey.bind(hyper, "f", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + padding
	f.y = max.y + padding
	f.w = max.w - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end)

-- Put current window to left half of screen
hs.hotkey.bind(hyper, "d", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + padding
	f.y = max.y + padding
	f.w = max.w / 2 - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end)

-- Put current screen to right half of screen
hs.hotkey.bind(hyper, "g", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 2) + padding
	f.y = max.y + padding
	f.w = max.w / 2 - (padding * 2)
	f.h = max.h - (padding * 2)
	win:setFrame(f)
end)

-- Autoreload config
function reloadConfig(files)
	doReload = false
	for _,file in pairs(files) do
		if file:sub(-4) == ".lua" then
			doReload = true
		end
	end
	if doReload then
		hs.reload()
	end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")
