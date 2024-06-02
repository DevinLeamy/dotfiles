UNSPLASH_API_KEY = "dDD4ek7ULqlw162m0TN8O-fSE9Hk-OffkuQg-1UdKw8"
MACGROUND_PATH = "/Users/Devin/.cargo/bin/macground"

local function macground(command)
    os.execute("UNSPLASH_API_KEY=" .. UNSPLASH_API_KEY .. " " .. MACGROUND_PATH .. " " .. command)
end

hs.hotkey.bind({ SUPER, "shift" }, "b", function()
    macground("--text-color 'beige' --random-image --message=''")
end)
