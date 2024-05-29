local hyper = {"cmd", "ctrl", "shift", "option"}
local switcher = hs.window.switcher.new()

-- Disable animations
hs.window.animationDuration = 0

-- Reserved hyper keys:
-- c, a, u, n, p, h, j, k, l, w, r, v, [, ], o, i, space

-- Switch monitors (if there are any)
hs.hotkey.bind(hyper, "m", function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()

	win:moveToScreen(screen:next())
end)

-- Maximize current window
hs.hotkey.bind(hyper, "3", function()
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
hs.hotkey.bind(hyper, "1", function()
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
hs.hotkey.bind(hyper, "2", function()
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

