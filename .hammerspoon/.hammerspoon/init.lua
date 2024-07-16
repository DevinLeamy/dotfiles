-- Module imports
require("keyboard.yabai")
require("keyboard.clipboard")
require("keyboard.misc")
require("keyboard.hotkey_window")

require("./utils")

hs.hotkey.bind({ "alt", "shift" }, "r", function()
	hs.alert.show("Reload Hammerspoon")
	utils.sleep(1)
	hs.reload()
end)
