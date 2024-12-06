require("keyboard.yabai")
require("../utils")

HotkeyWindow = {
	-- Name of the application being managed.
	app = nil,
	-- Function called after the hotkey window is created.
	onCreate = nil,
	-- Function called after the hotkey window is moved into view.
	onShow = nil,
	-- Hotkey window id file.
	idFile = nil,
	-- Use '-n' when creating a new window.
	openNew = nil,
	-- Opacity [0-1] of the created window.
	opacity = nil
}

HotkeyWindow.__index = HotkeyWindow

-- Constructor
function HotkeyWindow:new(app, options)
	-- Create a new table for the instance
	local window = setmetatable({}, HotkeyWindow)

	window.app = app
	window.openNew = options.openNew
	window.onCreate = options.onCreate or function() end
	window.onShow = options.onShow or function() end
	window.idFile = "/Users/Devin/.config/hotkey_window/" .. app .. "_id.txt"
	window.opacity = options.opacity or 1.0

	return window
end

-- Check if a hotkey window has already been created.
function HotkeyWindow:exists()
	local file = io.open(self.idFile, "r")
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

function HotkeyWindow:createHotkeyWindow()
	-- Create a new Alacritty window and get its PID
	local args = ""
	if self.openNew then args = "-n" end
	hs.execute("open -a " .. utils.quote(self.app) .. " " .. args)

	utils.sleep(2) -- wait for the application to launch

	-- Find the PID of the application. "<name>$" is done so that it doesn't match secondary
	-- processes that have the <name> in the title.
	local windowPid = hs.execute('pgrep -n -f ' .. utils.quote(self.app) .. "$")

	if windowPid == nil then
		print("Failed to get pid of hotkey window")
		return nil
	end
	windowPid = math.floor(windowPid)
	print(self.app .. " hotkey window pid: ", windowPid)

	-- Find the winodw id of the new window and write it to the file.
	local windows = yabai.query("windows")
	local windowId = nil

	-- Check if any of the active windows are the hotkey window.
	for _, window in ipairs(windows) do
		local pid = math.floor(window["pid"])
		if pid == windowPid then
			windowId = math.floor(window["id"])
		end
		print("WINDOW ID: " .. pid)
	end

	if windowId == nil then
		print("Failed to get window id for hotkey window")
		return nil
	end

	local file = io.open(self.idFile, "w")
	if not file then
		print("Failed to write to hotkey window id file")
		return nil
	end

	file:write(windowId)
	file:close()

	-- Make the window float (aka be unmanaged)
	yabai.command("-m window " .. windowId .. " --opacity " .. self.opacity)
	yabai.command("-m window " .. windowId .. " --toggle float")
	yabai.command("-m window " .. windowId .. " --grid 1:1:0:0:1:1")

	self.onCreate()
	self.onShow()

	return windowId
end

function HotkeyWindow:toggle()
	-- Query for the focused window and space before doing anything else because
	-- showing/hinding the hotkey window may change the focused space.
	--
	-- Note: focusedWindow will be nil if there is no focused window.
	local focusedSpace = yabai.query("spaces", "--space")
	local focusedWindow = yabai.query("windows", "--window")

	local windowExists, windowId = self:exists()

	if not windowExists then
		print("Creating new hotkey window")
		windowId = self:createHotkeyWindow()
	end

	if windowId == nil then
		print("Failed to toggle hotkey window.")
		return
	end

	if focusedWindow ~= nil and focusedWindow["id"] == windowId then
		-- Hide the hotkey window.
		yabai.command("-m window " .. windowId .. " --space 1")
	else
		-- Show the hotkey window.
		--
		-- 1. Move it to the focused space.
		-- 2. Make it focused.
		-- 3. Make it full screen.

		yabai.command("-m window " .. windowId .. " --space " .. math.floor(focusedSpace["index"]))
		yabai.command("-m window " .. windowId .. " --focus")
		yabai.command("-m window " .. windowId .. " --grid 1:1:0:0:1:1")
	end
end
