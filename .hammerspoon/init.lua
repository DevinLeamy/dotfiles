-- Module imports
require("keyboard.yabai")
require("keyboard.clipboard")
require("keyboard.misc")

hs.hotkey.bind({ "alt", "shift" }, 'r', function()
    hs.alert.show("Reload Hammerspoon")
    hs.sleep(1)
    hs.reload()
end)
