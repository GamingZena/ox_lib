<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
local cache = _ENV.cache
cache.playerId = PlayerId()
cache.serverId = GetPlayerServerId(cache.playerId)

function cache:set(key, value)
	if value ~= self[key] then
		TriggerEvent(('ox_lib:cache:%s'):format(key), value, self[key])
		self[key] = value

		return true
	end
end

local GetVehiclePedIsIn = GetVehiclePedIsIn
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehicleMaxNumberOfPassengers = GetVehicleMaxNumberOfPassengers
local GetMount = GetMount
local IsPedOnMount = IsPedOnMount
local GetCurrentPedWeapon = GetCurrentPedWeapon

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		cache:set('ped', ped)

		local vehicle = GetVehiclePedIsIn(ped, false)

		if vehicle > 0 then
<<<<<<< HEAD
=======
			if vehicle ~= cache.vehicle then
				cache:set('seat', false)
			end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
			cache:set('vehicle', vehicle)

			if not cache.seat or GetPedInVehicleSeat(vehicle, cache.seat) ~= ped then
				for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
					if GetPedInVehicleSeat(vehicle, i) == ped then
						cache:set('seat', i)
						break
					end
				end
			end
		else
			cache:set('vehicle', false)
			cache:set('seat', false)
		end

		if cache.game == 'redm' then
			local mount = GetMount(ped)
			local onMount = IsPedOnMount(ped)
			cache:set('mount', onMount and mount or false)
		end

		local hasWeapon, currentWeapon = GetCurrentPedWeapon(ped, true)

		cache:set('weapon', hasWeapon and currentWeapon or false)

		Wait(100)
	end
end)

function lib.cache(key)
	return cache[key]
end
