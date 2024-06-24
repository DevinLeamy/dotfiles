require("keyboard.yabai")
require("../utils")

hotkey_window = {}

local HOTKEY_WINDOW_ID_FILE = "/Users/Devin/.config/hotkey_window/window_id.txt"

-- Check if a hotkey window has already been created.
local function exists()
	local file = io.open(HOTKEY_WINDOW_ID_FILE, "r")
	if not file then
		return false
	end

	local hotkeyWindowId = math.floor(file:read("*all"))
	file:close()

	local windows = yabai.query("windows")

	-- Check if any of the active windows are the hotkey window.
	for _, window in ipairs(windows) do
		local id = math.floor(window["id"])
		if id == hotkeyWindowId then
			return true, hotkeyWindowId
		end
	end

	return false
end

local function createHotkeyWindow()
	-- Create a new Alacritty window and get its PID
	hs.execute("open -a " .. utils.quote("Alacritty") .. " -n")

	utils.sleep(1) -- wait for the application to launch

	local windowPid = hs.execute('pgrep -n -f "Alacritty"')
	if windowPid == nil then
		print("Failed to get pid of hotkey window")
		return nil
	end
	windowPid = math.floor(windowPid)
	print("Alacritty hotkey window pid: ", windowPid)

	-- Find the winodw id of the new window and write it to the file.
	local windows = yabai.query("windows")
	local windowId = nil

	-- Check if any of the active windows are the hotkey window.
	for _, window in ipairs(windows) do
		local pid = math.floor(window["pid"])
		if pid == windowPid then
			windowId = math.floor(window["id"])
		end
	end

	if windowId == nil then
		print("Failed to get window id for hotkey window")
		return nil
	end

	local file = io.open(HOTKEY_WINDOW_ID_FILE, "w")
	if not file then
		print("Failed to write to hotkey window id file")
		return nil
	end

	file:write(windowId)
	file:close()

	-- Make the window float (aka be unmanaged)
	yabai.command("-m window " .. windowId .. " --opacity 0.9")
	yabai.command("-m window " .. windowId .. " --toggle float")
	yabai.command("-m window " .. windowId .. " --grid 1:1:0:0:1:1")

	return windowId
end

local function toggle()
	-- Query for the focused window and space before doing anything else because
	-- showing/hinding the hotkey window may change the focused space.
	local focusedWindow = yabai.query("windows", "--window")
	local focusedSpace = math.floor(focusedWindow["space"])

	local windowExists, windowId = exists()

	if not windowExists then
		print("Creating new hotkey window")
		windowId = createHotkeyWindow()
	end

	if windowId == nil then
		print("Failed to toggle hotkey window.")
		return
	end

	if focusedWindow["id"] == windowId then
		-- Hide the hotkey window.
		yabai.command("-m window " .. windowId .. " --space 9")
	else
		-- Show the hotkey window.
		--
		-- 1. Move it to the focused space.
		-- 2. Make it focused.
		-- 3. Make it full screen.

		yabai.command("-m window " .. windowId .. " --space " .. focusedSpace)
		yabai.command("-m window " .. windowId .. " --focus")
		yabai.command("-m window " .. windowId .. " --grid 1:1:0:0:1:1")
	end
end

hotkey_window.toggle = toggle
