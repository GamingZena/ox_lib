<<<<<<< HEAD
lib.print.warn('ox_lib\'s class module is experimental and may break without warning.')

-- Fields added to the "private" field on a class will not be msgpacked.
-- Use setters/getters when working with these values.
local private_mt = {
    __ext = 0,
    __pack = function() return '' end,
}
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---@diagnostic disable: invisible
local getinfo = debug.getinfo
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

---Ensure the given argument or property has a valid type, otherwise throwing an error.
---@param id number | string
---@param var any
---@param expected type
local function assertType(id, var, expected)
    local received = type(var)

    if received ~= expected then
<<<<<<< HEAD
        error(("expected %s %s to have type '%s' (received %s)"):format(type(id) == 'string' and 'field' or 'argument', id, expected, received), 3)
=======
        error(("expected %s %s to have type '%s' (received %s)")
            :format(type(id) == 'string' and 'field' or 'argument', id, expected, received), 3)
    end

    if expected == 'table' and table.type(var) ~= 'hash' then
        error(("expected argument %s to have table.type 'hash' (received %s)")
            :format(id, table.type(var)), 3)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    end

    return true
end

<<<<<<< HEAD
---Creates a new instance of the given class.
local function createObj(class, obj)
    if obj.private then
        assertType('private', obj.private, 'table')
        setmetatable(obj.private, private_mt)
    end

    setmetatable(obj, class)

    if class.init then obj:init() end
=======
---@alias OxClassConstructor<T> fun(self: T, ...: unknown): nil

---@class OxClass
---@field private __index table
---@field protected __name string
---@field protected private? { [string]: unknown }
---@field protected super? OxClassConstructor
---@field protected constructor? OxClassConstructor
local mixins = {}
local constructors = {}

---Somewhat hacky way to remove the constructor from the class.__index.
---Maybe add static fields in the future?
---@param class OxClass
local function getConstructor(class)
    local constructor = constructors[class] or class.constructor

    if class.constructor then
        constructors[class] = class.constructor
        class.constructor = nil
    end

    return constructor
end

local function void() return '' end

---Creates a new instance of the given class.
---@protected
---@generic T
---@param class T | OxClass
---@return T
function mixins.new(class, ...)
    local constructor = getConstructor(class)
    local private = {}
    local obj = setmetatable({ private = private }, class)

    if constructor then
        local parent = class

        rawset(obj, 'super', function(self, ...)
            parent = getmetatable(parent)
            constructor = getConstructor(parent)

            if constructor then return constructor(self, ...) end
        end)

        constructor(obj, ...)
    end

    rawset(obj, 'super', nil)

    if private ~= obj.private or next(obj.private) then
        private = table.clone(obj.private)

        table.wipe(obj.private)
        setmetatable(obj.private, {
            __metatable = 'private',
            __tostring = void,
            __index = function(self, index)
                local di = getinfo(2, 'n')

                if di.namewhat ~= 'method' and di.namewhat ~= '' then return end

                return private[index]
            end,
            __newindex = function(self, index, value)
                local di = getinfo(2, 'n')

                if di.namewhat ~= 'method' and di.namewhat ~= '' then
                    error(("cannot set value of private field '%s'"):format(index), 2)
                end

                private[index] = value
            end
        })
    else
        obj.private = nil
    end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

    return obj
end

<<<<<<< HEAD
---Creates a new class.
---@todo add inherited types for new/private/init fields (not yet supported by lls)
---@param name string
---@param super? table
function lib.class(name, super)
    assertType(1, name, 'string')

    local class = {
        __name = name,
        new = createObj,
    }

    class.__index = class

    return super and setmetatable(class, super) or class
=======
---Checks if an object is an instance of the given class.
---@param class OxClass
function mixins:isClass(class)
    return getmetatable(self) == class
end

---Checks if an object is an instance or derivative of the given class.
---@param class OxClass
function mixins:instanceOf(class)
    local mt = getmetatable(self)

    while mt do
        if mt == class then return true end

        mt = getmetatable(mt)
    end

    return false
end

---Creates a new class.
---@generic S : OxClass
---@generic T : string
---@param name `T`
---@param super? S
---@return `T`
function lib.class(name, super)
    assertType(1, name, 'string')

    local class = table.clone(mixins)

    class.__name = name
    class.__index = class

    if super then
        assertType('super', super, 'table')
        setmetatable(class, super)
    end

    ---@todo See if there's a way we can auto-create a class using the name and super
    return class
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.class
