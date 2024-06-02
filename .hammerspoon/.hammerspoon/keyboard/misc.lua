local function openNew(app)
    hs.execute("open -a " .. utils.quote(app) .. " -n")
end

local function appBinding(key, app)
    hs.hotkey.bind({ 'alt', 'shift' }, key, function()
        openNew(app)
    end)
end

local function configBinding(key, fn)
    hs.hotkey.bind({ 'ctrl', 'alt' }, key, fn)
end

appBinding('a', "Arc")
appBinding('e', "Visual Studio Code")
appBinding('t', "Kali")
appBinding('w', "Safari")

configBinding('1', function()
    hs.execute('toggle_icons', true)
end)

