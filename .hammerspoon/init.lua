-- Module imports
require("keyboard.yabai")
require("keyboard.clipboard")
require("keyboard.misc")
require("macground")

hs.hotkey.bind({ "alt", "shift" }, 'r', function()
    hs.alert.show("Reload Hammerspoon")
    hs.reload()
end)
