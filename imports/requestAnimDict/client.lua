<<<<<<< HEAD
---Load an animation dictionary. When called from a thread, it will yield until it has loaded.
---@param animDict string
---@param timeout number? Number of ticks to wait for the dictionary to load. Default is 500.
---@return string? animDict
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---Load an animation dictionary. When called from a thread, it will yield until it has loaded.
---@param animDict string
---@param timeout number? Approximate milliseconds to wait for the dictionary to load. Default is 10000.
---@return string animDict
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function lib.requestAnimDict(animDict, timeout)
    if HasAnimDictLoaded(animDict) then return animDict end

    if type(animDict) ~= 'string' then
        error(("expected animDict to have type 'string' (received %s)"):format(type(animDict)))
    end

    if not DoesAnimDictExist(animDict) then
<<<<<<< HEAD
        return error(("attempted to load invalid animDict '%s'"):format(animDict))
    end

    RequestAnimDict(animDict)

    if not coroutine.isyieldable() then return animDict end

    return lib.waitFor(function()
        if HasAnimDictLoaded(animDict) then return animDict end
    end, ("failed to load animDict '%s'"):format(animDict), timeout or 500)
=======
        error(("attempted to load invalid animDict '%s'"):format(animDict))
    end

    return lib.streamingRequest(RequestAnimDict, HasAnimDictLoaded, 'animDict', animDict, timeout)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.requestAnimDict
