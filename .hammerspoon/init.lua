-- Module imports
require("keyboard.yabai")
require("keyboard.clipboard")
require("keyboard.misc")
require("macground")

SUPER = "alt"

hs.hotkey.bind({ SUPER, "shift" }, "R", function()
    hs.reload()
end)
