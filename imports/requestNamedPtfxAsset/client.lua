<<<<<<< HEAD
---Load a named particle effect. When called from a thread, it will yield until it has loaded.
---@param ptFxName string
---@param timeout number? Number of ticks to wait for the particle effect to load. Default is 500.
---@return string? ptFxName
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---Load a named particle effect. When called from a thread, it will yield until it has loaded.
---@param ptFxName string
---@param timeout number? Approximate milliseconds to wait for the particle effect to load. Default is 10000.
---@return string ptFxName
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function lib.requestNamedPtfxAsset(ptFxName, timeout)
    if HasNamedPtfxAssetLoaded(ptFxName) then return ptFxName end

    if type(ptFxName) ~= 'string' then
        error(("expected ptFxName to have type 'string' (received %s)"):format(type(ptFxName)))
    end

<<<<<<< HEAD
    RequestNamedPtfxAsset(ptFxName)

    if not coroutine.isyieldable() then return ptFxName end

    return lib.waitFor(function()
        if HasNamedPtfxAssetLoaded(ptFxName) then return ptFxName end
    end, ("failed to load ptFxName '%s'"):format(ptFxName), timeout or 500)
=======
    return lib.streamingRequest(RequestNamedPtfxAsset, HasNamedPtfxAssetLoaded, 'ptFxName', ptFxName, timeout)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.requestNamedPtfxAsset
