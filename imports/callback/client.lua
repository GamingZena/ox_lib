<<<<<<< HEAD
local events = {}
local timers = {}
local cbEvent = ('__ox_cb_%s')

RegisterNetEvent(cbEvent:format(cache.resource), function(key, ...)
	local cb = events[key]
	return cb and cb(...)
end)

---@param event string
---@param delay number | false prevent the event from being called for the given time
local function eventTimer(event, delay)
	if delay and type(delay) == 'number' and delay > 0 then
		local time = GetGameTimer()

		if (timers[event] or 0) > time then
			return false
		end

		timers[event] = time + delay
	end

	return true
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local pendingCallbacks = {}
local timers = {}
local cbEvent = '__ox_cb_%s'
local callbackTimeout = GetConvarInt('ox:callbackTimeout', 300000)

RegisterNetEvent(cbEvent:format(cache.resource), function(key, ...)
    if source == '' then return end

    local cb = pendingCallbacks[key]

    if not cb then return end

    pendingCallbacks[key] = nil

    cb(...)
end)

---@param event string
---@param delay? number | false prevent the event from being called for the given time
local function eventTimer(event, delay)
    if delay and type(delay) == 'number' and delay > 0 then
        local time = GetGameTimer()

        if (timers[event] or 0) > time then
            return false
        end

        timers[event] = time + delay
    end

    return true
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@param _ any
---@param event string
<<<<<<< HEAD
---@param delay number | false
---@param cb function|false
---@param ... any
---@return ...
local function triggerServerCallback(_, event, delay, cb, ...)
	if not eventTimer(event, delay) then return end

	local key

	repeat
		key = ('%s:%s'):format(event, math.random(0, 100000))
	until not events[key]

	TriggerServerEvent(cbEvent:format(event), cache.resource, key, ...)

	---@type promise | false
	local promise = not cb and promise.new()

	events[key] = function(response, ...)
        response = { response, ... }
		events[key] = nil

		if promise then
			return promise:resolve(response)
		end
=======
---@param delay number | false | nil
---@param cb function | false
---@param ... any
---@return ...
local function triggerServerCallback(_, event, delay, cb, ...)
    if not eventTimer(event, delay) then return end

    local key

    repeat
        key = ('%s:%s'):format(event, math.random(0, 100000))
    until not pendingCallbacks[key]

    TriggerServerEvent('ox_lib:validateCallback', event, cache.resource, key)
    TriggerServerEvent(cbEvent:format(event), cache.resource, key, ...)

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

---@overload fun(event: string, delay: number | false, cb: function, ...)
lib.callback = setmetatable({}, {
<<<<<<< HEAD
	__call = triggerServerCallback
=======
    __call = function(_, event, delay, cb, ...)
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

        return triggerServerCallback(_, event, delay, cb, ...)
    end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
})

---@param event string
---@param delay? number | false prevent the event from being called for the given time.
---Sends an event to the server and halts the current thread until a response is returned.
<<<<<<< HEAD
function lib.callback.await(event, delay, ...)
	return triggerServerCallback(nil, event, delay, false, ...)
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
function lib.callback.await(event, delay, ...)
    return triggerServerCallback(nil, event, delay, false, ...)
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
--- Registers an event handler and callback function to respond to server requests.
function lib.callback.register(name, cb)
	RegisterNetEvent(cbEvent:format(name), function(resource, key, ...)
		TriggerServerEvent(cbEvent:format(resource), key, callbackResponse(pcall(cb, ...)))
	end)
=======
---Registers an event handler and callback function to respond to server requests.
---@diagnostic disable-next-line: duplicate-set-field
function lib.callback.register(name, cb)
    event = cbEvent:format(name)

    lib.setValidCallback(name, true)

    RegisterNetEvent(event, function(resource, key, ...)
        TriggerServerEvent(cbEvent:format(resource), key, callbackResponse(pcall(cb, ...)))
    end)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

return lib.callback
