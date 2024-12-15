require("../utils")
require("keyboard.hotkey_window")

CODE_PATH = "/usr/local/bin/code"

local function openNew(app)
	hs.execute("open -a " .. utils.quote(app) .. " -n")
end

local function appBinding(key, app)
	utils.altShiftBinding(key, function()
		openNew(app)
	end)
end

appBinding("a", "Arc")
appBinding("p", "Alacritty")
appBinding("w", "Google Chrome")
appBinding("u", "Kitty")
appBinding("c", "Cursor")

-- Open a new Visual Studio Code window.
utils.altShiftBinding("e", function()
	hs.execute(CODE_PATH .. " -n")
end)

utils.altShiftBinding("d", function()
	os.execute([[
        cd /Users/Devin/Desktop/GitHub/DevinLeamy/2024
        git add .
        git commit -m "Fast deploy"
        git push
    ]])
	hs.alert.show("Deployed https://devinleamy.ca")
end)

-- Hotkey Windows
local alacritty = HotkeyWindow:new("Alacritty", {
	openNew = true,
	opacity = 0.9,
	query = "Alacritty",
})
local mochi = HotkeyWindow:new("Mochi", {
	openNew = false,
	opacity = 1.0,
	query = "Mochi$",
})

utils.ctrlCommandBinding("k", function()
	alacritty:toggle()
end)

utils.ctrlCommandBinding("l", function()
	mochi:toggle()
end)
