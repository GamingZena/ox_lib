<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
-- Add additional functions to the standard table library

---@class oxtable : tablelib
lib.table = table
local pairs = pairs

---@param tbl table
---@param value any
---@return boolean
---Checks if tbl contains the given values. Only intended for simple values and unnested tables.
local function contains(tbl, value)
<<<<<<< HEAD
	if type(value) ~= 'table' then
		for _, v in pairs(tbl) do
			if v == value then return true end
		end
	else
		local matched_values = 0
		local values = 0
		for _, v1 in pairs(value) do
			values += 1

			for _, v2 in pairs(tbl) do
				if v1 == v2 then matched_values += 1 end
			end
		end
		if matched_values == values then return true end
	end

	return false
=======
    if type(value) ~= 'table' then
        for _, v in pairs(tbl) do
            if v == value then
                return true
            end
        end

        return false
    else
        local set = {}

        for _, v in pairs(tbl) do
            set[v] = true
        end

        for _, v in pairs(value) do
            if not set[v] then
                return false
            end
        end

        return true
    end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@param t1 any
---@param t2 any
---@return boolean
---Compares if two values are equal, iterating over tables and matching both keys and values.
local function table_matches(t1, t2)
<<<<<<< HEAD
	local type1, type2 = type(t1), type(t2)

	if type1 ~= type2 then return false end
	if type1 ~= 'table' and type2 ~= 'table' then return t1 == t2 end

	for k1,v1 in pairs(t1) do
	   local v2 = t2[k1]
	   if v2 == nil or not table_matches(v1,v2) then return false end
	end

	for k2,v2 in pairs(t2) do
	   local v1 = t1[k2]
	   if v1 == nil or not table_matches(v1,v2) then return false end
	end

	return true
=======
    local tabletype1 = table.type(t1)

    if not tabletype1 then return t1 == t2 end

    if tabletype1 ~= table.type(t2) or (tabletype1 == 'array' and #t1 ~= #t2) then
        return false
    end

    for k, v1 in pairs(t1) do
        local v2 = t2[k]
        if v2 == nil or not table_matches(v1, v2) then
            return false
        end
    end

    for k in pairs(t2) do
        if t1[k] == nil then
            return false
        end
    end

    return true
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@generic T
---@param tbl T
---@return T
---Recursively clones a table to ensure no table references.
local function table_deepclone(tbl)
<<<<<<< HEAD
	tbl = table.clone(tbl)

	for k, v in pairs(tbl) do
		if type(v) == 'table' then
			tbl[k] = table_deepclone(v)
		end
	end

	return tbl
=======
    tbl = table.clone(tbl)

    for k, v in pairs(tbl) do
        if type(v) == 'table' then
            tbl[k] = table_deepclone(v)
        end
    end

    return tbl
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@param t1 table
---@param t2 table
<<<<<<< HEAD
---@return table
---Merges two tables together. Duplicate keys will be added together if they are numbers, or otherwise overwritten.
local function table_merge(t1, t2)
    for k, v in pairs(t2) do
        local type1 = type(t1[k])
        local type2 = type(v)

		if type1 == 'table' and type2 == 'table' then
            table_merge(t1[k], v)
        elseif type1 == 'number' and type2 == 'number' then
            t1[k] += v
		else
			t1[k] = v
=======
---@param addDuplicateNumbers boolean? add duplicate number keys together if true, replace if false. Defaults to true.
---@return table
---Merges two tables together. Defaults to adding duplicate keys together if they are numbers, otherwise they are overriden.
local function table_merge(t1, t2, addDuplicateNumbers)
    addDuplicateNumbers = addDuplicateNumbers == nil or addDuplicateNumbers
    for k, v2 in pairs(t2) do
        local v1 = t1[k]
        local type1 = type(v1)
        local type2 = type(v2)

        if type1 == 'table' and type2 == 'table' then
            table_merge(v1, v2, addDuplicateNumbers)
        elseif addDuplicateNumbers and (type1 == 'number' and type2 == 'number') then
            t1[k] = v1 + v2
        else
            t1[k] = v2
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        end
    end

    return t1
end

<<<<<<< HEAD
=======
---@param tbl table
---@return table
---Shuffles the elements of a table randomly using the Fisher-Yates algorithm.
local function shuffle(tbl)
    local len = #tbl
    for i = len, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
table.contains = contains
table.matches = table_matches
table.deepclone = table_deepclone
table.merge = table_merge
<<<<<<< HEAD
=======
table.shuffle = shuffle
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

local frozenNewIndex = function(self) error(('cannot set values on a frozen table (%s)'):format(self), 2) end
local _rawset = rawset

---@param tbl table
---@param index any
---@param value any
---@return table
function rawset(tbl, index, value)
    if table.isfrozen(tbl) then
        frozenNewIndex(tbl)
    end

    return _rawset(tbl, index, value)
end

---Makes a table read-only, preventing further modification. Unfrozen tables stored within `tbl` are still mutable.
---@generic T : table
---@param tbl T
---@return T
function table.freeze(tbl)
    local copy = table.clone(tbl)
    local metatbl = getmetatable(tbl)

    table.wipe(tbl)
    setmetatable(tbl, {
        __index = metatbl and setmetatable(copy, metatbl) or copy,
        __metatable = 'readonly',
        __newindex = frozenNewIndex,
        __len = function() return #copy end,
        ---@diagnostic disable-next-line: redundant-return-value
        __pairs = function() return next, copy end,
    })

    return tbl
end

---Return true if `tbl` is set as read-only.
---@param tbl table
---@return boolean
function table.isfrozen(tbl)
    return getmetatable(tbl) == 'readonly'
end

return lib.table
