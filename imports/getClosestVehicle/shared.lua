<<<<<<< HEAD
---@param coords vector3 The coords to check from.
---@param maxDistance number The max distance to check.
---@param includePlayerVehicle boolean Whether or not to include the player's current vehicle. Ignored on the server.
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---@param coords vector3 The coords to check from.
---@param maxDistance? number The max distance to check.
---@param includePlayerVehicle? boolean Whether or not to include the player's current vehicle. Ignored on the server.
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@return number? vehicle
---@return vector3? vehicleCoords
function lib.getClosestVehicle(coords, maxDistance, includePlayerVehicle)
	local vehicles = GetGamePool('CVehicle')
	local closestVehicle, closestCoords
	maxDistance = maxDistance or 2.0

	for i = 1, #vehicles do
		local vehicle = vehicles[i]

		if lib.context == 'server' or not cache.vehicle or vehicle ~= cache.vehicle or includePlayerVehicle then
			local vehicleCoords = GetEntityCoords(vehicle)
			local distance = #(coords - vehicleCoords)

			if distance < maxDistance then
				maxDistance = distance
				closestVehicle = vehicle
				closestCoords = vehicleCoords
			end
		end
	end

	return closestVehicle, closestCoords
end

return lib.getClosestVehicle
