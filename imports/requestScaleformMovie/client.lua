<<<<<<< HEAD
---Load a scaleform movie. When called from a thread, it will yield until it has loaded.
---@param scaleformName string
---@param timeout number? Number of ticks to wait for the scaleform movie to load. Default is 500.
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---Load a scaleform movie. When called from a thread, it will yield until it has loaded.
---@param scaleformName string
---@param timeout number? Approximate milliseconds to wait for the scaleform movie to load. Default is 1000.
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@return number? scaleform
function lib.requestScaleformMovie(scaleformName, timeout)
    if type(scaleformName) ~= 'string' then
        error(("expected scaleformName to have type 'string' (received %s)"):format(type(scaleformName)))
    end

    local scaleform = RequestScaleformMovie(scaleformName)

<<<<<<< HEAD
    if not coroutine.isyieldable() then return scaleform end

    return lib.waitFor(function()
        if HasScaleformMovieLoaded(scaleform) then return scaleform end
    end, ("failed to load scaleform '%s'"):format(scaleform), timeout or 500)
=======
    return lib.waitFor(function()
        if HasScaleformMovieLoaded(scaleform) then return scaleform end
    end, ("failed to load scaleformMovie '%s'"):format(scaleformName), timeout)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.requestScaleformMovie
