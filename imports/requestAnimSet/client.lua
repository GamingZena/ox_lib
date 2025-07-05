<<<<<<< HEAD
---Load an animation clipset. When called from a thread, it will yield until it has loaded.
---@param animSet string
---@param timeout number? Number of ticks to wait for the clipset to load. Default is 500.
---@return string? animSet
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---Load an animation clipset. When called from a thread, it will yield until it has loaded.
---@param animSet string
---@param timeout number? Approximate milliseconds to wait for the clipset to load. Default is 10000.
---@return string animSet
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function lib.requestAnimSet(animSet, timeout)
    if HasAnimSetLoaded(animSet) then return animSet end

    if type(animSet) ~= 'string' then
        error(("expected animSet to have type 'string' (received %s)"):format(type(animSet)))
    end

<<<<<<< HEAD
    RequestAnimSet(animSet)

    if not coroutine.isyieldable() then return animSet end

    return lib.waitFor(function()
        if HasAnimSetLoaded(animSet) then return animSet end
    end, ("failed to load animSet '%s'"):format(animSet), timeout or 500)
=======
    return lib.streamingRequest(RequestAnimSet, HasAnimSetLoaded, 'animSet', animSet, timeout)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.requestAnimSet
