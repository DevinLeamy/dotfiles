utils = {}

-- Sleeps for n seconds.
local function sleep(n)
	os.execute("sleep " .. tonumber(n))
end

-- Index of an value in a table.
-- Returns nil if the element is no found.
local function indexOf(table, v)
	for i, value in ipairs(table) do
		if value == v then
			return i
		end
	end
	return nil
end

local function length(table)
	local count = 0
	for _ in pairs(table) do
		count = count + 1
	end
	return count
end

-- Modular add.
-- Assumes lhs + rhs >= -mod
local function modAdd(lhs, rhs, mod)
	return (lhs + rhs - 1 + mod) % mod + 1
end

local function quote(string)
	return '"' .. string .. '"'
end

local function altShiftBinding(key, fn)
	hs.hotkey.bind({ "alt", "shift" }, key, fn)
end

local function ctrlCommandBinding(key, fn)
	hs.hotkey.bind({ "ctrl", "cmd" }, key, fn)
end

-- Execute a fish command inside of standard fish environment.
local function fish(command)
	local value, status = hs.execute("/opt/homebrew/bin/fish -c 'source ~/.config/fish/config.fish; " .. command .. "'")
	return value, status
end

-- Trim whitespace.
function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- Read an environment variable.
local function env(variable)
	local value, status = fish("echo $" .. variable)

	if status then
		return trim(value)
	else
		return nil
	end
end

utils.sleep = sleep
utils.indexOf = indexOf
utils.length = length
utils.modAdd = modAdd
utils.quote = quote
utils.altShiftBinding = altShiftBinding
utils.ctrlCommandBinding = ctrlCommandBinding
utils.env = env
