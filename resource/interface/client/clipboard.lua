<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@param value string
function lib.setClipboard(value)
    SendNUIMessage({
        action = 'setClipboard',
        data = value
    })
<<<<<<< HEAD
end
=======
end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
