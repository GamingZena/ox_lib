<<<<<<< HEAD
---@param coords vector3 The coords to check from.
---@param maxDistance number The max distance to check.
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---@param coords vector3 The coords to check from.
---@param maxDistance? number The max distance to check.
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@return number? object
---@return vector3? objectCoords
function lib.getClosestObject(coords, maxDistance)
	local objects = GetGamePool('CObject')
	local closestObject, closestCoords
	maxDistance = maxDistance or 2.0

	for i = 1, #objects do
		local object = objects[i]

		local objectCoords = GetEntityCoords(object)
		local distance = #(coords - objectCoords)

		if distance < maxDistance then
			maxDistance = distance
			closestObject = object
			closestCoords = objectCoords
		end
	end

	return closestObject, closestCoords
end

return lib.getClosestObject
