<<<<<<< HEAD
---Yields the current thread until a non-nil value is returned by the function.  
---Errors after timeout (default 1000) iterations.
---@generic T
---@param cb fun(): T?
---@param errMessage string?
---@param timeout number?
---@return T?
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---Yields the current thread until a non-nil value is returned by the function.
---@generic T
---@param cb fun(): T?
---@param errMessage string?
---@param timeout? number | false Error out after `~x` ms. Defaults to 1000, unless set to `false`.
---@return T
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@async
function lib.waitFor(cb, errMessage, timeout)
    local value = cb()

    if value ~= nil then return value end

    if timeout or timeout == nil then
<<<<<<< HEAD
        timeout = tonumber(timeout) or 1000
    end

    local start = GetGameTimer()
    local i = 0

    while value == nil do
        if timeout then
            i += 1

            if i > timeout then return error(('%s (waited %.1fms)'):format(errMessage or 'failed to resolve callback', (GetGameTimer() - start) / 1000), 2) end
        end

        Wait(0)
=======
        if type(timeout) ~= 'number' then timeout = 1000 end
    end

    local start = timeout and GetGameTimer()

    while value == nil do
        Wait(0)

        local elapsed = timeout and GetGameTimer() - start

        if elapsed and elapsed > timeout then
            return error(('%s (waited %.1fms)'):format(errMessage or 'failed to resolve callback', elapsed), 2)
        end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        value = cb()
    end

    return value
end

return lib.waitFor
