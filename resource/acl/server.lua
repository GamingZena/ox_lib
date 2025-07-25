<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
local function allowAce(allow)
	return allow == false and 'deny' or 'allow'
end

-- Adds the ace to the principal.
function lib.addAce(principal, ace, allow)
	if type(principal) == 'number' then
		principal = 'player.'..principal
	end

	ExecuteCommand(('add_ace %s %s %s'):format(principal, ace, allowAce(allow)))
end

-- Removes the ace from the principal.
function lib.removeAce(principal, ace, allow)
	if type(principal) == 'number' then
		principal = 'player.'..principal
	end

	ExecuteCommand(('remove_ace %s %s %s'):format(principal, ace, allowAce(allow)))
end

-- Adds the child principal to the parent principal.
function lib.addPrincipal(child, parent)
	if type(child) == 'number' then
		child = 'player.'..child
	end

	ExecuteCommand(('add_principal %s %s'):format(child, parent))
end

-- Removes the child principal from the parent principal.
function lib.removePrincipal(child, parent)
	if type(child) == 'number' then
		child = 'player.'..child
	end

	ExecuteCommand(('remove_principal %s %s'):format(child, parent))
end

lib.callback.register('ox_lib:checkPlayerAce', function(source, command)
    return IsPlayerAceAllowed(source, command)
end)
