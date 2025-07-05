<<<<<<< HEAD
local loaded = {}

package = {
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local loaded = {}
local _require = require

package = {
    path = './?.lua;./?/init.lua',
    preload = {},
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    loaded = setmetatable({}, {
        __index = loaded,
        __newindex = noop,
        __metatable = false,
<<<<<<< HEAD
    }),
    path = './?.lua;'
}

local _require = require

---@param modpath string
---@param modname? string
---@return string, string?
local function getModuleInfo(modpath, modname)
    local resourceSrc

    if not modpath:find('^@') then
        local idx = 1

        while true do
            local di = debug.getinfo(idx, 'S')

            if di then
                if not di.short_src:find('^@ox_lib/imports/require') and not di.short_src:find('^%[C%]') and not di.short_src:find('^citizen') and di.short_src ~= '?' then
                    resourceSrc = di.short_src:gsub('^@(.-)/.+', '%1')
                    break
                end
            else
                resourceSrc = cache.resource
                break
            end

            idx += 1
        end

        if modname and resourceSrc ~= cache.resource then
            modname = ('@%s.%s'):format(resourceSrc, modname)
        end
    end

    return resourceSrc, modname
end

---@param filePath string
---@param env? table
---@return any
---Loads and runs a Lua file at the given path. Unlike require, the chunk is not cached for future use.
function lib.load(filePath, env)
    local resourceSrc
    local modpath = filePath:gsub('%.', '/')

    if not modpath:find('^@') then
        resourceSrc = getModuleInfo(modpath)
    end

    if not resourceSrc then
        resourceSrc = modpath:gsub('^@(.-)/.+', '%1')
        modpath = modpath:sub(#resourceSrc + 3)
    end

    for path in package.path:gmatch('[^;]+') do
        local scriptPath = path:gsub('?', modpath):gsub('%.+%/+', '')
        local resourceFile = LoadResourceFile(resourceSrc, scriptPath)

        if resourceFile then

            local chunk, err = load(resourceFile, ('@@%s/%s'):format(resourceSrc, modpath), 't', env or _ENV)

            if not chunk or err then
                error(err or 'an unknown error occurred', 2)
            end

            return chunk()
        end
    end

    error(('cannot load file at path %s'):format(modpath))
=======
    })
}

---@param modName string
---@return string
---@return string
local function getModuleInfo(modName)
    local resource = modName:match('^@(.-)/.+') --[[@as string?]]

    if resource then
        return resource, modName:sub(#resource + 3)
    end

    local idx = 4 -- call stack depth (kept slightly lower than expected depth "just in case")

    while true do
        local src = debug.getinfo(idx, 'S')?.source

        if not src then
            return cache.resource, modName
        end

        resource = src:match('^@@([^/]+)/.+')

        if resource and not src:find('^@@ox_lib/imports/require') then
            return resource, modName
        end

        idx += 1
    end
end

local tempData = {}

---@param name string
---@param path string
---@return string? filename
---@return string? errmsg
---@diagnostic disable-next-line: duplicate-set-field
function package.searchpath(name, path)
    local resource, modName = getModuleInfo(name:gsub('%.', '/'))
    local tried = {}

    for template in path:gmatch('[^;]+') do
        local fileName = template:gsub('^%./', ''):gsub('?', modName:gsub('%.', '/') or modName)
        local file = LoadResourceFile(resource, fileName)

        if file then
            tempData[1] = file
            tempData[2] = resource
            return fileName
        end

        tried[#tried + 1] = ("no file '@%s/%s'"):format(resource, fileName)
    end

    return nil, table.concat(tried, "\n\t")
end

---Attempts to load a module at the given path relative to the resource root directory.\
---Returns a function to load the module chunk, or a string containing all tested paths.
---@param modName string
---@param env? table
local function loadModule(modName, env)
    local fileName, err = package.searchpath(modName, package.path)

    if fileName then
        local file = tempData[1]
        local resource = tempData[2]

        table.wipe(tempData)
        return assert(load(file, ('@@%s/%s'):format(resource, fileName), 't', env or _ENV))
    end

    return nil, err or 'unknown error'
end

---@alias PackageSearcher
---| fun(modName: string): function loader
---| fun(modName: string): nil, string errmsg

---@type PackageSearcher[]
package.searchers = {
    function(modName)
        local ok, result = pcall(_require, modName)

        if ok then return result end

        return ok, result
    end,
    function(modName)
        if package.preload[modName] ~= nil then
            return package.preload[modName]
        end

        return nil, ("no field package.preload['%s']"):format(modName)
    end,
    function(modName) return loadModule(modName) end,
}

---@param filePath string
---@param env? table
---@return unknown
---Loads and runs a Lua file at the given path. Unlike require, the chunk is not cached for future use.
function lib.load(filePath, env)
    if type(filePath) ~= 'string' then
        error(("file path must be a string (received '%s')"):format(filePath), 2)
    end

    local result, err = loadModule(filePath, env)

    if result then return result() end

    error(("file '%s' not found\n\t%s"):format(filePath, err))
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@param filePath string
---@return table
---Loads and decodes a json file at the given path.
function lib.loadJson(filePath)
<<<<<<< HEAD
    local resourceSrc
    local modpath = filePath:gsub('%.', '/')

    if not modpath:find('^@') then
        resourceSrc = getModuleInfo(modpath)
    end

    if not resourceSrc then
        resourceSrc = modpath:gsub('^@(.-)/.+', '%1')
        modpath = modpath:sub(#resourceSrc + 3)
    end

    local scriptPath = ('%s.json'):format(modpath)
    local resourceFile = LoadResourceFile(resourceSrc, scriptPath)
=======
    if type(filePath) ~= 'string' then
        error(("file path must be a string (received '%s')"):format(filePath), 2)
    end

    local resourceSrc, modPath = getModuleInfo(filePath:gsub('%.', '/'))
    local resourceFile = LoadResourceFile(resourceSrc, ('%s.json'):format(modPath))
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

    if resourceFile then
        return json.decode(resourceFile)
    end

<<<<<<< HEAD
    error(('cannot load json file at path %s'):format(modpath))
end

---Loads the given module inside the current resource, returning any values returned by the file or `true` when `nil`.
---@param modname string
---@return unknown?
function lib.require(modname)
    if type(modname) ~= 'string' then return end

    local modpath = modname:gsub('%.', '/')
    local module = loaded[modname]

    if module then return module end

    local success, result = pcall(_require, modname)

    if success then
        loaded[modname] = result
        return result
    end

    local resourceSrc

    if not modpath:find('^@') then
        resourceSrc, modname = getModuleInfo(modpath, modname) --[[@as string]]
    end

    if not module then
        if module == false then
            error(("^1circular-dependency occurred when loading module '%s'^0"):format(modname), 2)
        end

        if not resourceSrc then
            resourceSrc = modpath:gsub('^@(.-)/.+', '%1')
            modpath = modpath:sub(#resourceSrc + 3)
        end

        for path in package.path:gmatch('[^;]+') do
            local scriptPath = path:gsub('?', modpath):gsub('%.+%/+', '')
            local resourceFile = LoadResourceFile(resourceSrc, scriptPath)

            if resourceFile then
                loaded[modname] = false
                scriptPath = ('@@%s/%s'):format(resourceSrc, scriptPath)

                local chunk, err = load(resourceFile, scriptPath)

                if err or not chunk then
                    loaded[modname] = nil
                    return error(err or ("unable to load module '%s'"):format(modname), 3)
                end

                module = chunk(modname) or true
                loaded[modname] = module

                return module
            end
        end

        return error(result, 2)
    end

    return module
=======
    error(("json file '%s' not found\n\tno file '@%s/%s.json'"):format(filePath, resourceSrc, modPath))
end

---Loads the given module, returns any value returned by the seacher (`true` when `nil`).\
---Passing `@resourceName.modName` loads a module from a remote resource.
---@param modName string
---@return unknown
function lib.require(modName)
    if type(modName) ~= 'string' then
        error(("module name must be a string (received '%s')"):format(modName), 3)
    end

    local module = loaded[modName]

    if module == '__loading' then
        error(("^1circular-dependency occurred when loading module '%s'^0"):format(modName), 2)
    end

    if module ~= nil then return module end

    loaded[modName] = '__loading'

    local err = {}

    for i = 1, #package.searchers do
        local result, errMsg = package.searchers[i](modName)

        if result then
            if type(result) == 'function' then result = result() end
            loaded[modName] = result or result == nil

            return loaded[modName]
        end

        err[#err + 1] = errMsg
    end

    error(("%s"):format(table.concat(err, "\n\t")))
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.require
