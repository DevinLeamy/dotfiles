LINKEDIN = "https://www.linkedin.com/in/devin-leamy-439b8a1b5/"
GITHUB = "https://github.com/DevinLeamy"
WEBSITE = "https://devinleamy.ca"

local ClipboardKeybinding = { "cmd", "shift" }

local function clipboardBinding(key, text, message)
    hs.hotkey.bind(ClipboardKeybinding, key, function()
        hs.pasteboard.setContents(text)
        if message ~= nil then
            hs.alert.show(message)
        end
    end)
end

clipboardBinding("h", LINKEDIN, "Copied LinkedIn to clipboard")
clipboardBinding("g", GITHUB, "Copied GitHub to clipboard")
clipboardBinding("w", WEBSITE, "Copied Website to clipboard")
