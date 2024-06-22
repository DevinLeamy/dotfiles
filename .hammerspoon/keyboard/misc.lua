CODE_PATH = '/usr/local/bin/code'

local function openNew(app)
    hs.execute("open -a " .. utils.quote(app) .. " -n")
end

local function altShiftBinding(key, fn)
    hs.hotkey.bind({ 'alt', 'shift' }, key, fn)
end

local function appBinding(key, app)
    altShiftBinding(key, function()
        openNew(app)
    end)
end

appBinding('a', "Arc")
appBinding('t', "Kali")
appBinding('w', "Google Chrome")

-- Open a new Visual Studio Code window.
altShiftBinding('e', function()
    hs.execute(CODE_PATH .. " -n")
end)

altShiftBinding('d', function()
    os.execute([[
        cd /Users/Devin/Desktop/GitHub/DevinLeamy/2024
        git add .
        git commit -m "Fast deploy"
        git push
    ]])
    hs.alert.show("Deployed https://devinleamy.ca")
end)
