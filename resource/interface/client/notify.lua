<<<<<<< HEAD
---@alias NotificationPosition 'top' | 'top-right' | 'top-left' | 'bottom' | 'bottom-right' | 'bottom-left' | 'center-right' | 'center-left'
---@alias NotificationType 'info' | 'warning' | 'success' | 'error'
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

---@alias NotificationPosition 'top' | 'top-right' | 'top-left' | 'bottom' | 'bottom-right' | 'bottom-left' | 'center-right' | 'center-left'
---@alias NotificationType 'info' | 'warning' | 'success' | 'error'
---@alias IconAnimationType 'spin' | 'spinPulse' | 'spinReverse' | 'pulse' | 'beat' | 'fade' | 'beatFade' | 'bounce' | 'shake'
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

---@class NotifyProps
---@field id? string
---@field title? string
---@field description? string
---@field duration? number
<<<<<<< HEAD
---@field position? NotificationPosition
---@field type? NotificationType
---@field style? { [string]: any }
---@field icon? string | {[1]: IconProp, [2]: string};
---@field iconColor? string;
---@field alignIcon? 'top' | 'center';
=======
---@field showDuration? boolean
---@field position? NotificationPosition
---@field type? NotificationType
---@field style? { [string]: any }
---@field icon? string | { [1]: IconProp, [2]: string }
---@field iconAnimation? IconAnimationType
---@field iconColor? string
---@field alignIcon? 'top' | 'center'
---@field sound? { bank?: string, set: string, name: string }

local settings = require 'resource.settings'
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

---`client`
---@param data NotifyProps
---@diagnostic disable-next-line: duplicate-set-field
function lib.notify(data)
<<<<<<< HEAD
=======
    local sound = settings.notification_audio and data.sound
    data.sound = nil
    data.position = data.position or settings.notification_position

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    SendNUIMessage({
        action = 'notify',
        data = data
    })
<<<<<<< HEAD
=======

    if not sound then return end

    if sound.bank then lib.requestAudioBank(sound.bank) end

    local soundId = GetSoundId()
    PlaySoundFrontend(soundId, sound.name, sound.set, true)
    ReleaseSoundId(soundId)

    if sound.bank then ReleaseNamedScriptAudioBank(sound.bank) end
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
end

---@class DefaultNotifyProps
---@field title? string
---@field description? string
---@field duration? number
---@field position? NotificationPosition
---@field status? 'info' | 'warning' | 'success' | 'error'
---@field id? number

---@param data DefaultNotifyProps
function lib.defaultNotify(data)
    -- Backwards compat for v3
    data.type = data.status
    if data.type == 'inform' then data.type = 'info' end
    return lib.notify(data --[[@as NotifyProps]])
end

RegisterNetEvent('ox_lib:notify', lib.notify)
RegisterNetEvent('ox_lib:defaultNotify', lib.defaultNotify)
