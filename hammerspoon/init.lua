local ctrl_cmd = {"cmd", "ctrl"}
local switcher = hs.window.switcher.new()

-- Disable animations
hs.window.animationDuration = 0

-- Switch monitors (if there are any)
hs.hotkey.bind(ctrl_cmd, "m", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()

	win:moveToScreen(screen:next())
end)

-- Maximize current window
hs.hotkey.bind(ctrl_cmd, "f", function()
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
hs.hotkey.bind(ctrl_cmd, "d", function()
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
hs.hotkey.bind(ctrl_cmd, "g", function()
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
