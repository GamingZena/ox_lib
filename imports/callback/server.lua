<<<<<<< HEAD
local events = {}
local cbEvent = ('__ox_cb_%s')

RegisterNetEvent(cbEvent:format(cache.resource), function(key, ...)
	local cb = events[key]
	return cb and cb(...)
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local pendingCallbacks = {}
local cbEvent = '__ox_cb_%s'
local callbackTimeout = GetConvarInt('ox:callbackTimeout', 300000)

RegisterNetEvent(cbEvent:format(cache.resource), function(key, ...)
    local cb = pendingCallbacks[key]

    if not cb then return end

    pendingCallbacks[key] = nil

    cb(...)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end)

---@param _ any
---@param event string
---@param playerId number
---@param cb function|false
---@param ... any
---@return ...
local function triggerClientCallback(_, event, playerId, cb, ...)
<<<<<<< HEAD
	local key

	repeat
		key = ('%s:%s:%s'):format(event, math.random(0, 100000), playerId)
	until not events[key]

	TriggerClientEvent(cbEvent:format(event), playerId, cache.resource, key, ...)

	---@type promise | false
	local promise = not cb and promise.new()

	events[key] = function(response, ...)
        response = { response, ... }
		events[key] = nil

		if promise then
			return promise:resolve(response)
		end
=======
    assert(DoesPlayerExist(playerId --[[@as string]]), ("target playerId '%s' does not exist"):format(playerId))

    local key

    repeat
        key = ('%s:%s:%s'):format(event, math.random(0, 100000), playerId)
    until not pendingCallbacks[key]

    TriggerClientEvent('ox_lib:validateCallback', playerId, event, cache.resource, key)
    TriggerClientEvent(cbEvent:format(event), playerId, cache.resource, key, ...)

    ---@type promise | false
    local promise = not cb and promise.new()

    pendingCallbacks[key] = function(response, ...)
        if response == 'cb_invalid' then
            response = ("callback '%s' does not exist"):format(event)

            return promise and promise:reject(response) or error(response)
        end

        response = { response, ... }

        if promise then
            return promise:resolve(response)
        end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

        if cb then
            cb(table.unpack(response))
        end
<<<<<<< HEAD
	end

	if promise then
		return table.unpack(Citizen.Await(promise))
	end
=======
    end

    if promise then
        SetTimeout(callbackTimeout, function() promise:reject(("callback event '%s' timed out"):format(key)) end)

        return table.unpack(Citizen.Await(promise))
    end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@overload fun(event: string, playerId: number, cb: function, ...)
lib.callback = setmetatable({}, {
<<<<<<< HEAD
	__call = triggerClientCallback
=======
    __call = function(_, event, playerId, cb, ...)
        if not cb then
            warn(("callback event '%s' does not have a function to callback to and will instead await\nuse lib.callback.await or a regular event to remove this warning")
                :format(event))
        else
            local cbType = type(cb)

            if cbType == 'table' and getmetatable(cb)?.__call then
                cbType = 'function'
            end

            assert(cbType == 'function', ("expected argument 3 to have type 'function' (received %s)"):format(cbType))
        end

        return triggerClientCallback(_, event, playerId, cb, ...)
    end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
})

---@param event string
---@param playerId number
--- Sends an event to a client and halts the current thread until a response is returned.
<<<<<<< HEAD
function lib.callback.await(event, playerId, ...)
	return triggerClientCallback(nil, event, playerId, false, ...)
end

local function callbackResponse(success, result, ...)
	if not success then
		if result then
			return print(('^1SCRIPT ERROR: %s^0\n%s'):format(result , Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString()) or ''))
		end

		return false
	end

	return result, ...
=======
---@diagnostic disable-next-line: duplicate-set-field
function lib.callback.await(event, playerId, ...)
    return triggerClientCallback(nil, event, playerId, false, ...)
end

local function callbackResponse(success, result, ...)
    if not success then
        if result then
            return print(('^1SCRIPT ERROR: %s^0\n%s'):format(result,
                Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString()) or ''))
        end

        return false
    end

    return result, ...
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

local pcall = pcall

---@param name string
---@param cb function
<<<<<<< HEAD
--- Registers an event handler and callback function to respond to client requests.
function lib.callback.register(name, cb)
	RegisterNetEvent(cbEvent:format(name), function(resource, key, ...)
		TriggerClientEvent(cbEvent:format(resource), source, key, callbackResponse(pcall(cb, source, ...)))
	end)
end

return lib.callback


=======
---Registers an event handler and callback function to respond to client requests.
---@diagnostic disable-next-line: duplicate-set-field
function lib.callback.register(name, cb)
    event = cbEvent:format(name)

    lib.setValidCallback(name, true)

    RegisterNetEvent(event, function(resource, key, ...)
        TriggerClientEvent(cbEvent:format(resource), source, key, callbackResponse(pcall(cb, source, ...)))
    end)
end

return lib.callback
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
