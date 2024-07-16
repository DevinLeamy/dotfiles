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

utils.ctrlCommandBinding("k", function()
	hotkey_window.toggle()
end)
