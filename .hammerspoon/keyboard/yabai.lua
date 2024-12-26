require("../utils")
cjson = require("cjson")

yabai = {}

-- Homebrew installed binary.
YABAI_PATH = "/opt/homebrew/bin/yabai"

-- Built-from-source binary.
YABAI_LOCAL_PATH = "/Users/Devin/Desktop/Github/OpenSource/yabai"

SUPER = "alt"

-- Send a single command to yabai.
local function yabaiCommand(command)
	return os.execute(YABAI_LOCAL_PATH .. " " .. command)
end

-- Yabai query. Returns the parsed JSON result of the query.
-- type: ["windows", "displays", "spaces"]
local function yabaiQuery(type, query)
	query = query and query or ""
	local rawOutput = hs.execute(YABAI_LOCAL_PATH .. " " .. "-m query --" .. type .. " " .. query)
	local json = nil
	pcall(function()
		json = cjson.decode(rawOutput)
	end)
	return json
end

-- Send command(s) to yabai.
local function yabaiCommands(commands)
	for _, command in ipairs(commands) do
		if type(command) == "string" then
			-- Execute a single command.
			yabaiCommand("-m " .. command)
		else
			-- Execute commands until one doesn't fail.
			-- Equivalent to: <cmd1> || <cmd2> || <cmd3>
			for _, option in ipairs(command) do
				local _, _, exitcode = yabaiCommand("-m " .. option)
				if exitcode == 0 then
					break
				end
			end
		end
	end
end

-- Send super+key commands.
local function super(key, commands)
	hs.hotkey.bind({ SUPER }, key, type(commands) == "function" and commands or function()
		yabaiCommands(commands)
	end)
end

-- Send super+shift+key commands.
local function superShift(key, commands)
	hs.hotkey.bind({ SUPER, "shift" }, key, type(commands) == "function" and commands or function()
		yabaiCommands(commands)
	end)
end

-- Send super+shift+ctrl commands.
local function superShiftCtrl(key, commands)
	hs.hotkey.bind({ SUPER, "shift", "ctrl" }, key, type(commands) == "function" and commands or function()
		yabaiCommands(commands)
	end)
end

-- Toggle fullscreen.
local function toggleFullscreen()
	local focusedWindow = yabaiQuery("windows", "--window")
	local windows = yabaiQuery("windows")
	local activeSpace = focusedWindow["space"]
	local isFullscreen = focusedWindow["has-fullscreen-zoom"]

	-- Make all the windows in a space have the same fullscreen zoom.
	-- e.g. all full screen or all split
	for _, window in ipairs(windows) do
		local id = math.floor(window["id"])
		if window["space"] == activeSpace and window["has-fullscreen-zoom"] == isFullscreen then
			yabaiCommand("-m window " .. id .. " --toggle zoom-fullscreen")
		end
	end
end

-- Navigate between spaces on a single display.
-- direction: ["left", "right"]
local function moveToSpace(direction)
	local focusedSpace = yabaiQuery("spaces", "--space")
	local display = yabaiQuery("displays", "--display " .. math.floor(focusedSpace["display"]))
	local spaceIndex = assert(utils.indexOf(display["spaces"], math.floor(focusedSpace["index"])))
	local newIndex = utils.modAdd(spaceIndex, direction == "left" and -1 or 1, utils.length(display["spaces"]))
	local newSpaceId = math.floor(display["spaces"][newIndex])
	yabaiCommand("-m space --focus " .. newSpaceId)
end

-- Create a new space and navigate to it.
local function createSpace()
	local display = yabaiQuery("displays", "--display")
	local spaces = utils.length(display["spaces"])
	local lastSpaceIndex = display["spaces"][spaces]
	local newSpaceIndex = math.floor(lastSpaceIndex + 1)
	yabaiCommand("-m space --create")
	yabaiCommand("-m space --focus " .. newSpaceIndex)
end

-- Destroy a space. When a space is destroyed, all windows in the space are moved onto the
-- next space to the left and the focus is also moved to that space.
-- Note: The last space on a display cannot be destroyed.
local function destroySpace()
	local focusedSpace = yabaiQuery("spaces", "--space")
	local display = yabaiQuery("displays", "--display " .. math.floor(focusedSpace["display"]))
	local spaceIndex = assert(utils.indexOf(display["spaces"], math.floor(focusedSpace["index"])))
	local totalSpaces = utils.length(display["spaces"])
	if totalSpaces == 1 then
		hs.alert.show("cannot destroy the last space on a display")
		return
	end

	-- If the space being destroyed is the last space on the display, then
	-- move everything onto the previous space.
	local newIndex = math.floor(display["spaces"][spaceIndex == totalSpaces and spaceIndex - 1 or spaceIndex])
	yabaiCommand("-m space --destroy")
	for _, windowId in ipairs(focusedSpace["windows"]) do
		yabaiCommand("-m window " .. math.floor(windowId) .. " --space " .. newIndex)
	end

	yabaiCommand("-m space --focus " .. newIndex)
end

-- Resizing windows.
super("h", { { "window --resize left:-80:0", "window --resize right:-80:0" } })
super("l", { { "window --resize right:80:0", "window --resize left:80:0" } })
super("space", toggleFullscreen)

-- Changing the focused window.
super("j", { { "window --focus next", "window --focus first" } })
super("k", { { "window --focus prev", "window --focus last" } })

-- Swap windows.
superShift("j", { { "window --swap next", "window --swap first" } })
-- move the window to the previous space and focus it.
superShiftCtrl("i", { "window --space prev", "space --focus prev" })
-- move the window to the next space and focus it.
superShiftCtrl("o", { "window --space next", "space --focus next" })

-- Moving between displays.
superShift("m", { { "display --focus next", "display --focus first" } })
superShiftCtrl("m", { { "window --display next", "window --display prev" }, { "window --focus recent" } }) -- Move window across displays.
superShiftCtrl("t", { { "window --toggle float" }, { "window --grid 4:4:1:1:2:2" } }) -- Toggle floating window.

-- Move between spaces.
-- TODO: Update these to stay local to each display.
--       i.e. each display should have it's own set of spaces.
superShift("i", function()
	moveToSpace("left")
end)
superShift("o", function()
	moveToSpace("right")
end)

-- Create/destroy spaces.
superShift("n", createSpace)
superShiftCtrl("n", destroySpace)

local function yabaiIgnoreApp(name)
	local regex = '"^' .. name .. '$"'
	yabaiCommand("-m rule --add app=" .. regex .. " manage=off")
end

local function yabaiConfig()
	yabaiCommand("-m config layout bsp")
	yabaiCommand("-m config top_padding 3")
	yabaiCommand("-m config bottom_padding 35")
	yabaiCommand("-m config left_padding 3")
	yabaiCommand("-m config right_padding 3")
	yabaiCommand("-m config window_gap 5")
	yabaiCommand("-m config mouse_follows_focus off")
	yabaiCommand("-m config focus_follows_mouse off")
	yabaiCommand("-m config window_opacity off")
	yabaiCommand("-m config window_opacity_duration 0.0")
	yabaiCommand("-m config window_shadow on")
	yabaiCommand("-m config window_border off ")
	yabaiCommand("-m config active_window_opacity 1.0")
	yabaiCommand("-m config normal_window_opacity 0.90")
	yabaiCommand("-m config split_ratio 0.50")
	yabaiCommand("-m config auto_balance off")
	yabaiCommand("-m config window_placement second_child")
	-- Application to ignore.
	yabaiIgnoreApp("System Settings")
	yabaiIgnoreApp("Activity Monitor")
	yabaiIgnoreApp("Finder")
	yabaiIgnoreApp("SF Symbols beta")
	yabaiIgnoreApp("Hammerspoon")
	yabaiIgnoreApp("App Store")
	yabaiIgnoreApp("Preview")
	yabaiIgnoreApp("Font Book")
	yabaiIgnoreApp("QuickTime Player")
end

--- Restart yabai.
hs.hotkey.bind({ SUPER, "shift", "ctrl" }, "P", function()
	hs.alert.show("Restarting Yabai")
	yabaiCommand("--stop-service")
	yabaiCommand("--start-service")
end)

-- Configure yabai. This is an alternative to using .yabairc
-- TODO: Determine why I can't slap this inside of the restart function.
hs.hotkey.bind({ SUPER, "shift", "ctrl" }, "0", function()
	yabaiConfig()
end)

yabai.query = yabaiQuery
yabai.command = yabaiCommand
