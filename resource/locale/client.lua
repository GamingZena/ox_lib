<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

local settings = require 'resource.settings'

local function loadLocaleFile(key)
    local file = LoadResourceFile(cache.resource, ('locales/%s.json'):format(key))
        or LoadResourceFile(cache.resource, 'locales/en.json')

    return file and json.decode(file) or {}
end

function lib.getLocaleKey() return settings.locale end

---@param key string
function lib.setLocale(key)
    TriggerEvent('ox_lib:setLocale', key)
    SendNUIMessage({
        action = 'setLocale',
        data = loadLocaleFile(key)
    })
end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
RegisterNUICallback('init', function(_, cb)
    cb(1)

    SendNUIMessage({
<<<<<<< HEAD
        action = 'loadLocales',
        data = {}
    })

	local JSON = LoadResourceFile(cache.resource, ('locales/%s.json'):format(GetConvar('ox:locale', 'en'))) or LoadResourceFile(cache.resource, 'locales/en.json')

    SendNUIMessage({
        action = 'setLocale',
        data = JSON and json.decode(JSON) or {}
    })
end)
=======
        action = 'setLocale',
        data = loadLocaleFile(settings.locale)
    })
end)

lib.locale(settings.locale)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
